// vazko vlad 01.05.2014
// Стандартный TR построенный на новом железе T9000Tx2
// c возможностью выбора типа термометра


/******************************************************************************************/
#include 	<pic18.h>
#include 	<stdlib.h>
#include 	<stdio.h>
#include 	<math.h>

#include 	"main.h"
/******************************************************************************************/
/*Global var*/
#include 	"var.c"

volatile int sys_tick;
BYTE sens_no = 0;
ST curr_state = 0;
BYTE g_mode_coeff = 0; // какой коэфф будет редактироваться в режиме калибровки 0 - ток, 1 - zero
/******************************************************************************************/

void mesure_task(void);
void display_task(void);
void menu_task(void);
void disp_info(BYTE mode);

/******************************************************************************************/
EEPROM_INIT


/******************************************************************************************/
void display_task(void){
    double f_max, f_min;
    char pstr[2][20];
    char i, j;

    static char i_blink;

    if(! cmd_screen) return;
    cmd_screen = 0;

    switch(curr_state){
        default: break;

        case ST_NORM:
            if(PORTBbits.RB6){

                for(i = 0; i < 3; i ++){
                    for(j = 0; j < 2; j ++){

                        EE_TO_RAM(PF_R1_MIN + (i * 2 + j) * 4, f_min);
                        EE_TO_RAM(PF_R1_MAX + (i * 2 + j) * 4, f_max);

                        if(f_curr_R[i * 2 + j] > f_max){
                            sprintf(pstr[j], "T%d<25.0", i * 2 + j + 1);
                        } else if(f_curr_R[i * 2 + j] < f_min){
                            sprintf(pstr[j], "T%d>80.0", i * 2 + j + 1);
                        } else {
                            sprintf(pstr[j], "T%d=", i * 2 + j + 1);
                            print_a_b(&pstr[j][3], f_curr_T[i * 2 + j], 1, 1);
                        }
                    }
                    sprintf(str, "%s%s%s%s", pstr[0], " ", pstr[1], " ");
                    lcd_goto(0, i);
                    lcd_puts_ex(str);
                }
                lcd_goto(5, 3);
                sprintf(str, "T, K  ");             
                lcd_puts_ex(str);
            } else {
                for(i = 0; i < 3; i ++){
                    for(j = 0; j < 2; j ++){
                        sprintf(pstr[j], "%d %05u ", i * 2 + j + 1, (WORD)f_curr_R[i * 2 + j]);
                        //print_a_b(&pstr[j][2], f_curr_T[i * 2 + j], 4, 1);
                    }
                    sprintf(str, "%s%s", pstr[0], pstr[1]);
                    lcd_goto(0, i);
                    lcd_puts_ex(str);
                }
                lcd_goto(5, 3);
                sprintf(str, "R, Ohm");                
                lcd_puts_ex(str);
                
            }

            
            lcd_goto(15, 3);
            (++ i_blink & 1) ? lcd_putc('.') : lcd_putc(' ');

            break;
    }
}

/******************************************************************************************/
void ch_setup(UCHAR ch){

    TRISB3 = 0;
    TRISB4 = 0;
    TRISB5 = 0;
    if TESTBIT(ch, 0) SETBIT(LATB, 3);
    else CLRBIT(LATB, 3);
    if TESTBIT(ch, 1) SETBIT(LATB, 4);
    else CLRBIT(LATB, 4);
    if TESTBIT(ch, 2) SETBIT(LATB, 5);
    else CLRBIT(LATB, 5);

}

/******************************************************************************************/
void main(void){

    LATA = 0;
    LATB = 0;
    LATC = 0;

    // internal ADC off
#if defined(_18F452)
    //452
    ADCON0 = 0;
    ADCON1 = 0x06;
#else
    //4520
    ADCON0 = 0;
    ADCON1 = 0b00001111;
    ADCON2 = 0b00001111;
#endif

    // set rs232
    uart_init();

    TRISA = 0b00110010;
    TRISB = 0b01000011;
    TRISC = 0b10010000;

    ch_setup(7);
    // кнопки
    RBPU = 0;

    INTEDG0 = 0;
    INTEDG1 = 0;
    INT1IP = 1;
    INT1IE = 0;
    INT0IE = 0;
    INT0IF = 0;
    INT1IF = 0;

    ////////////////SPI////////////////
    SSPSTAT = 0;
    SSPCON1 = 0x31;

    // Timer T0
    ///T0CON = 0b10000110; // 40MHz
    T0CON = 0b10000011; // 10MHz 1:4
    TMR0IP = 0;
    TMR0IE = 1;

    // int
    PEIE = 1;
    RCIE = 1;
    RCIP = 1;
    IPEN = 1;


    lcd_init();
    LCD_CLS();
    lcd_prog();
    LCD_CLS();

    lcd_goto(0, 0);
    lcd_puts(CVER);
    //EE_TO_RAM(PB_SENS_NO, sens_no);
    //lcd_goto(0, 2);
    //lcd_puts_ex(sensors[sens_no].s_name);
    DelayS(1);
    adc_init(BIAS_DISABLE | BURNOUT_CURRENT_OFF | BIPOLAR | BOOST_OFF | GAIN_1,
            EXT_REF | BUFFER_ON | CH0, ARATE_240_MODE_L, 0);

    DelayS(1);

    cmd_begin = 1;
    cmd_adc = 1;

    InitMessages();

    //SWDTEN = 1;
    //putstr(__DATE__);

    ei();

    while(1){

        //putbyte(0x55);
        TX_EN = 0;

        CLRWDT();
        menu_task();

        mesure_task();

        display_task();

        // рутина сообщений
        ProcessMessages();

    }

}

/******************************************************************************************/
void mesure_task(void){

    static BYTE ch;
    double f_z, f_Zero, f_U_Ref, f_I_Ref, f_temp;
    DWORD code;

    //EE_TO_RAM(PF_U_REF, f_U_Ref);
    //EE_TO_RAM(PF_ZERO, f_Zero);
    f_U_Ref = 2.49;
    f_Zero = 0.0;
    f_z = 0.0;
    f_I_Ref = 100E-6;

    cmd_adc = 1;
    if(cmd_adc){

        if(ch == 0){
            //adc_init(BIAS_DISABLE | BURNOUT_CURRENT_OFF | BIPOLAR | BOOST_OFF | GAIN_1, INT_REF | BUFFER_ON | CH0, ARATE_240_MODE_L, 0);
        }

        ch_setup(ch);
        //EE_TO_RAM((PF_Z0 + ch * 4), f_z);
        DelayMs(150);

        adc_start();
        code = adc_get_ex(BIAS_DISABLE | BURNOUT_CURRENT_OFF | BIPOLAR | BOOST_OFF | GAIN_1,
                EXT_REF | BUFFER_ON | CH0, ARATE_240_MODE_L | INT_CLK_PIN_MODE_L);

        f_temp = ((double)code - 0x7fffff) * 2.0 * f_U_Ref / f_I_Ref / 0xffffff + f_Zero + f_z;
        adc_stop();

        //f_curr_TW[ch] = eval_poly(f_temp, sensors[sens_no].coeff, sensors[sens_no].n - 1);
        //f_curr_R[ch] = f_temp;

#ifdef USE_SLIDE_FILTER
        //if (cmd_begin) filter_ini(f_curr_TW[ch], ch);
        filter(&f_temp, ch, cmd_begin);
#endif
        // Запись данных в основные переменные
        di();
        f_curr_R[ch] = f_temp;
        ei();
        f_temp = R2T(ch, f_temp);
        di();
        f_curr_T[ch] = f_temp;
        ei();

        (ch < 5) ? ch ++ : ch = 0;

        if(ch == 0) cmd_begin = 0;

        cmd_adc = 0;
        cmd_screen = 1;

    }//end if(b_adc)
}


/******************************************************************************************/
/******************************************************************************************/
/******************************************************************************************/
#define MENU_POS_COUNT	4 // позиций для меню на экране
#define MENU_SENS_MAX	6 // количество пунктов основного меню
#define dI				1E-8
#define dZ				0.001

/******************************************************************************************/
BYTE get_first_string_menu(BYTE menu_pos){
    if(menu_pos < MENU_POS_COUNT) return 0;
    else return (menu_pos - MENU_POS_COUNT + 1);
}

/******************************************************************************************/
BYTE get_arrow_pos(BYTE menu_pos){
    if(menu_pos < MENU_POS_COUNT) return menu_pos;
    else return (MENU_POS_COUNT - 1);
}

/******************************************************************************************/
void disp_menu(void){
    BYTE i;
    LCD_CLS();
    for(i = 0; i < 4; i ++){
        lcd_goto(0, i);
        //lcd_puts_ex(sensors[get_first_string_menu(sens_no) + i].s_name);
    }
    lcd_goto(0, get_arrow_pos(sens_no));
    lcd_putc('*');
}

/******************************************************************************************/
void menu_task(void){
    WORD curr_adr;
    static int prev_tick;
    double f_val;

    switch(curr_state){
        case ST_INIT:
            curr_state = ST_NORM;
            prev_tick = sys_tick;
            break;

        case ST_NORM:
            if(GetMessage(MSG_KEY_LONG_PRESSED)){
                // если перемычка установлена
                if(PORTBbits.RB7){
                    curr_state = ST_SENS;
                    disp_menu();
                } else {
                    /*
                                        if(sensors[sens_no].gain == 2){
                                            curr_adr = PF_I_REF1;
                                        } else if(sensors[sens_no].gain == 16){
                                            curr_adr = PF_I_REF2;
                                        }
                     */

                    if(g_mode_coeff == 0){
                        g_mode_coeff = 1;
                    } else if(g_mode_coeff == 1){
                        g_mode_coeff = 0;
                    }
                }
            }

            if((GetMessage(MSG_KEY_P_PRESSED))){
                if(PORTBbits.RB7){
                    disp_info(0);
                    DelayS(2);
                } else {
                    if(g_mode_coeff == 0){
                        // ток
                        EE_TO_RAM(curr_adr, f_val);
                        f_val = f_val + dI;
                        RAM_TO_EE(curr_adr, f_val);
                        f_val = f_val * 1000000.0;
                    } else if(g_mode_coeff == 1){
                        // zero
                        EE_TO_RAM(PF_ZERO, f_val);
                        f_val = f_val + dZ;
                        RAM_TO_EE(PF_ZERO, f_val);
                        f_val = f_val * 1000.0;
                    }
                    lcd_goto(0, 0);
                    sprintf(str, " %3.2f   ", f_val);
                    lcd_puts_ex(str);
                    DelayMs(250);
                }
            }

            if((GetMessage(MSG_KEY_M_PRESSED))){
                if(PORTBbits.RB7){
                    disp_info(1);
                    DelayS(4);
                } else {
                    if(g_mode_coeff == 0){
                        // ток
                        EE_TO_RAM(curr_adr, f_val);
                        f_val = f_val - dI;
                        RAM_TO_EE(curr_adr, f_val);
                        f_val = f_val * 1000000.0;
                    } else if(g_mode_coeff == 1){
                        // zero
                        EE_TO_RAM(PF_ZERO, f_val);
                        f_val = f_val - dZ;
                        RAM_TO_EE(PF_ZERO, f_val);
                        f_val = f_val * 1000.0;
                    }
                    lcd_goto(0, 0);
                    sprintf(str, " %3.2f   ", f_val);
                    lcd_puts_ex(str);
                    DelayMs(250);
                }
            }

            break;

        case ST_SENS:
            if(GetMessage(MSG_KEY_LONG_PRESSED)){
                /*                
                curr_state = ST_NORM;
                RAM_TO_EE(PB_SENS_NO, sens_no);
                LCD_CLS();

                // коэфф усиления	

                if(sensors[sens_no].gain == 2){
                    adc_init(BIAS_DISABLE | BURNOUT_CURRENT_OFF | BIPOLAR | BOOST_OFF | GAIN_2,
                            INT_REF | BUFFER_ON | CH0, ARATE_240_MODE_L, 0);
                } else if(sensors[sens_no].gain == 16){
                    adc_init(BIAS_DISABLE | BURNOUT_CURRENT_OFF | BIPOLAR | BOOST_OFF | GAIN_16,
                            INT_REF | BUFFER_ON | CH0, ARATE_240_MODE_L, 0);
                }
                 */
            }

            if(GetMessage(MSG_KEY_P_PRESSED)){
                if(sens_no < (MENU_SENS_MAX - 1)) sens_no ++;
                disp_menu();
            }

            if(GetMessage(MSG_KEY_M_PRESSED)){
                if(sens_no) sens_no --;
                disp_menu();
            }

            break;

    }

}

/******************************************************************************************/
// mode == 0 номер канала
// mode == 1 имя датчика

void disp_info(BYTE mode){

    LCD_CLS();
    if(mode == 0){
        lcd_goto(1, 0);
        lcd_putc('1');
        lcd_goto(9, 0);
        lcd_putc('2');
        lcd_goto(1, 1);
        lcd_putc('3');
        lcd_goto(9, 1);
        lcd_putc('4');
        lcd_goto(1, 2);
        lcd_putc('5');
        lcd_goto(9, 2);
        lcd_putc('6');
        lcd_goto(1, 3);
        lcd_putc('7');
        lcd_goto(9, 3);
        lcd_putc('8');
    } else {
        lcd_goto(0, 1);
        //lcd_puts_ex(sensors[sens_no].s_name);
    }

}

