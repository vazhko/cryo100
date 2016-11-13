#include 	"main.h"
#include 	"usart.h"
#include	"modbus_RTU.h"
#include	"buttons.h"

/*
Описание зарезервированных комманд в протоколе MODBUS (0х10, 0х03)
Контрольная сумма - обычная, только вначале передается младший байт
Пользовательские, свободно назначаемые комманды, начинаются с номера 0х41


Запись байт в EEPROM (Preset multiple registers)
Запрос:
ADDEV	//Адрес девайса (например 0х55)
0x10	//Комманда
ADRH	//Адрес первого байта
ADRL
NUMH	//Количество передаваемых регистров BYCO/2
NUML
BYCO	//Количество передаваемых байт (Byte count)
DATA1H
DATA1L
DATA2H
DATA2L
----
DATAnH
DATAnL
CRCL
CRCH

Ответ:
ADDEV	//Адрес девайса
0x10	//Комманда
ADRH	//Адрес первого байта
ADRL
NUMH	//Количество передаваемых регистров BYCO/2
NUML
CRCL
CRCH



Чтение байт из EEPROM (Read holding registers)
Запрос:
ADDEV	//Адрес девайса
0x03	//Комманда
ADRH	//Адрес первого байта
ADRL
NUMH	//Количество запрашиваемых регистров (регистр - 2 байта)
NUML
CRCL
CRCH

Ответ:
ADDEV	//Адрес девайса
0x03	//Комманда
BYCO	//Количество передаваемых байт (Byte count)
DATA1H
DATA1L
DATA2H
DATA2L
----
DATAnH
DATAnL
CRCL
CRCH

 */


extern double f_curr_T[8];
extern volatile int sys_tick;

void Task_Buttons_(void);

/***************************************************************************************/
/*
void crc_send(unsigned int crc) {
	putbyte((unsigned char) (crc >> 8));
	putbyte((unsigned char) crc);
}
*/

/***************************************************************************************/

BYTE RxTxBuff[73]; // RX/TX буффер
unsigned int iCs; // CRC
BYTE cData, cAdr, *lp_p;


static WORD iStart, iStop; // для расчета адресов перадачи из архива


/***************************************************************************************/
// Отсылка измеренных данных (0x55 0x45 без CS)

void send_measured_data(void) {
	BYTE i;
	NOP();
	crc_mb_init(&iCs);
	putbyte(crc_mb_calc(&iCs, RS232_ADR));
	putbyte(crc_mb_calc(&iCs, 0x45));

	for (i = 0; i < 8; i++) {
		lp_p = (BYTE*) & f_curr_T[i];
		NOP();
		putbyte(crc_mb_calc(&iCs, *lp_p++));
		putbyte(crc_mb_calc(&iCs, *lp_p++));
		putbyte(crc_mb_calc(&iCs, *lp_p++));
		putbyte(crc_mb_calc(&iCs, *lp_p));
	}

	crc_send(iCs);
}




/***************************************************************************************/
/***************************************************************************************/
//#pragma interrupt_level 1

static void interrupt HI_ISR(void) {
	/***************************************************************************************/
	// INT_RS232
	//if_RCIF:;
	if (RCIF) {
		NOP();
		//Принимаем
		// адрес
		RxTxBuff[0] = timed_getc();
		if (RxTxBuff[0] == 0xEA) RESET();
		if ((RxTxBuff[0] != RS232_ADR)) goto error;
		if ((FERR) || (OERR)) goto error;
		if (timeout_error) goto error;
		// комманда
		RxTxBuff[1] = timed_getc();
		if ((FERR) || (OERR)) goto error;
		if (timeout_error) goto error;

		// обрабатываем комманду
		switch (RxTxBuff[1]) {
			default:
				//RxTxBuff[1] += 0x80;
				break;

			case 0x10: // запись в EEPROM (preset multiple registers)
				// Принимаем заголовок
				// RxTxBuff[6] - количество байт данных
				for (cAdr = 2; cAdr < 7; cAdr++) {
					RxTxBuff[cAdr] = timed_getc();
					if ((FERR) || (OERR)) goto error;
					if (timeout_error) goto error;
					NOP();
				}
				// Принимаем данные
				for (cAdr = 7; cAdr < RxTxBuff[6] + 9; cAdr++) {
					RxTxBuff[cAdr] = timed_getc();
					if ((FERR) || (OERR)) goto error;
					if (timeout_error) goto error;
					NOP();
				}
				// Проверка КС и запись, если ОК
				if (crc_mb_check(RxTxBuff, RxTxBuff[6] + 7)) {
					// todo: запись в еепром
					cData = 7;
					for (cAdr = RxTxBuff[3]; cAdr < RxTxBuff[6] + RxTxBuff[3]; cAdr++) {
						EEPROM_WRITE(cAdr, (RxTxBuff[cData]));
						NOP();
						cData++;
					}
					// Ответ
					crc_mb_init(&iCs);
					for (cAdr = 0; cAdr < 6; cAdr++) {
						putbyte(crc_mb_calc(&iCs, RxTxBuff[cAdr]));
						NOP();
					}
					// передача КС
					crc_send(iCs);
					//cmd_refrash = 1; // Обновляем конфигурацию
				} else {
					// todo: передача кода ошибки в КС
				}
				break;

			case 0x41: // выполнение комманды чтения массива данных
				for (cAdr = 2; cAdr < 8; cAdr++) {
					RxTxBuff[cAdr] = timed_getc();
					if ((FERR) || (OERR)) goto error;
					if (timeout_error) goto error;
					NOP();
				}
				NOP();
				if (crc_mb_check(RxTxBuff, 6)) { // если КС совпадает, то формируем передачу

					crc_mb_init(&iCs);
					putbyte(crc_mb_calc(&iCs, RS232_ADR));
					putbyte(crc_mb_calc(&iCs, 0x41));

					iStart = (RxTxBuff[2] << 8) | RxTxBuff[3];
					iStop = (RxTxBuff[4] << 8) | RxTxBuff[5];
					//putbyte(crc_mb_calc(&iCs, 0));
					// Передача данных с извлечением
					do {
						///cData = ee_rd(iStart);
						putbyte(crc_mb_calc(&iCs, cData));
						if (iStart == 0xffff) break;
						iStart++;
					} while (iStart <= iStop);

				}
				// передача КС
				crc_send(iCs);
				break;

			case 0x03: // чтение из EEPROM (read holding registers)
				for (cAdr = 2; cAdr < 8; cAdr++) {
					RxTxBuff[cAdr] = timed_getc();
					if ((FERR) || (OERR)) goto error;
					if (timeout_error) goto error;
					NOP();
				}
				NOP();
				if (crc_mb_check(RxTxBuff, 6)) { // если КС совпадает, то формируем передачу
					crc_mb_init(&iCs);
					putbyte(crc_mb_calc(&iCs, RS232_ADR));
					putbyte(crc_mb_calc(&iCs, 0x03));
					RxTxBuff[5] *= 2; // преобраз количество регистров в байты
					putbyte(crc_mb_calc(&iCs, RxTxBuff[5]));
					// Передача данных с извлечением
					for (cAdr = RxTxBuff[3]; cAdr < (RxTxBuff[5] + RxTxBuff[3]); cAdr++) {
						cData = EEPROM_READ(cAdr);
						putbyte(crc_mb_calc(&iCs, cData));
					}
				}
				// передача КС
				crc_send(iCs);
				break;

			case 0x44: // выполнение комманды идентификации
				crc_mb_init(&iCs);
				putbyte(crc_mb_calc(&iCs, RS232_ADR));
				putbyte(crc_mb_calc(&iCs, 0x44));
				putbyte(crc_mb_calc(&iCs, RS232_ADR));
				crc_send(iCs);
				break;

			case 0x45: // чтение измеренных данных (из пользовательских комманд)
				send_measured_data();
				break;

			case 0x48: // чтение выбраных измеренных данных (из пользовательских комманд)
				putstr(__DATE__);

				break;

		}//END_SWITCH

error:

		RCIF = 0;
		CREN = 0;
		NOP();
		CREN = 1;
	}//END_INT_RS232


}


/***************************************************************************************/
// частота подобрана

void interrupt low_priority LOW_ISR(void) {

	static BYTE btn_counter;
	//BYTE btn_state;

	if (TMR0IF) { // 2 Hz

		WRITETIMER0(-625);
		sys_tick++;
		NOP();
		// 20mS
		if (++btn_counter > 20) {
			btn_counter = 0;
			Task_Buttons_();
		}
		TMR0IF = 0;

	}//END_TMR0IF


}

void Task_Buttons_(void) {

	static BYTE prev_btn0_st = 1;
	static BYTE prev_btn1_st = 1;
	//static BYTE long_st;
	static WORD long_btn_count;


	if ((!pin_BUTTON0) && (!pin_BUTTON1) && (long_btn_count)) {
		prev_btn0_st = 1;
		prev_btn1_st = 1;
		if (++long_btn_count > 100) {
			long_btn_count = 0;
			//long_st = 1;
			SendMessage(MSG_KEY);
			SendMessage(MSG_KEY_LONG_PRESSED);
		}
	} else {

		// разрешаем long_btn_count
		if ((pin_BUTTON0) && (pin_BUTTON1)) long_btn_count = 1;
		if (long_btn_count == 0) return;

		if (!pin_BUTTON0) {
			prev_btn0_st = 0;
		} else {
			if (prev_btn0_st == 0) {
				SendMessage(MSG_KEY);
				SendMessage(MSG_KEY_P_PRESSED);
			}
			prev_btn0_st = 1;
		}

		if (!pin_BUTTON1) {
			prev_btn1_st = 0;
		} else {
			if (prev_btn1_st == 0) {
				SendMessage(MSG_KEY);
				SendMessage(MSG_KEY_M_PRESSED);
			}
			prev_btn1_st = 1;
		}


		//long_st = 0;
	}


}