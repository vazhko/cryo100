
#include <pic18.h>
#include "ad7793.h"


/**************************************************************************************************/
void adc_delay(void) {
	DWORD del_count;
	del_count = 50000;
	while(-- del_count) Nop();
}
/**************************************************************************************************/

char spi_read(char DATA) {
	static BYTE _gie;
	static BYTE _databuf;

	_gie = (BYTE) GIE;
	GIE = 0;
	SSPBUF = DATA;
	do NOP(); while (!BF);
	_databuf = SSPBUF;
	GIE = (bit)_gie;

	return _databuf;
}

/**************************************************************************************************/
void adc_wait_ready(void) {

	//Переконфигурация на стандартный вход
	SSPEN = 0;
	ADC_CS = 0;
	
	do NOP(); while (ADC_RDY);

	SSPEN = 1;
	NOP();
}

/**************************************************************************************************/
void adc_start(void) {
	SSPEN = 1;
	ADC_CS = 0;
}

/**************************************************************************************************/
void adc_set(BYTE param_gain, BYTE param_rbc, BYTE param_filter) {
	
	SSPEN = 1;
	ADC_CS = 0;
	
	spi_read(RG_WR | RG_CONF);
	spi_read(param_gain);
	spi_read(param_rbc);

	spi_read(RG_WR | RG_MODE);
	spi_read(SINGLE_CONV_MODE_H);
	spi_read(param_filter);
	
	ADC_CS = 1;
	

}

/**************************************************************************************************/
DWORD adc_read(void) {
	DWORD_VAL data;
	
	SSPEN = 1;
	ADC_CS = 0;	

	spi_read(RG_RD | RG_DATA);
	data.Val = 0;
#ifndef USE_AD7792	
	data.v[2] = spi_read(0);
#endif	
	data.v[1] = spi_read(0);
	data.v[0] = spi_read(0);
	
	ADC_CS = 1;

	return data.Val;
}

/**************************************************************************************************/
void adc_stop(void) {	
	ADC_CS = 1;
}

/**************************************************************************************************/
void adc_sleep(void) {

	SSPEN = 1;
	ADC_CS = 0;
	NOP();

	// pwdn mode
	spi_read(RG_WR | RG_MODE);
	spi_read(POWER_DOWN_MODE_H);
	spi_read(ARATE___4_MODE_L | INT_CLK_PIN_MODE_L);

	ADC_CS = 1;
}


/**************************************************************************************************/

BYTE adc_init(BYTE param_gain, BYTE param_rbc, BYTE param_filter, BYTE param_current) {

	return adc_init_ex(param_gain, param_rbc, param_filter, param_current, IZS_CALIBR_MODE_H, IFS_CALIBR_MODE_H);

}

/**************************************************************************************************/
BYTE adc_init_ex(BYTE param_gain, BYTE param_rbc, BYTE param_filter, BYTE param_current, BYTE param_z, BYTE param_s) {
	
	BYTE adc_id = 0;

	ADC_CLK = 1;
	ADC_DOUT = 1;
	ADC_RDY_TRIS = 1;
	ADC_DOUT_TRIS = 0;
	ADC_CLK_TRIS = 0;
	ADC_CS_TRIS = 0;

	adc_start();

	adc_delay();
	spi_read(0xff);
	spi_read(0xff);
	spi_read(0xff);
	spi_read(0xff);
	adc_delay();

	// ID
	spi_read(RG_RD | RG_ID);
	adc_id = spi_read(0);
	
	//if(((adc_id & 0x0f) != AD7792_ID) || ((adc_id & 0x0f) != AD7792_ID)) return 0;	
	//return (adc_id & 0x0f);
	
	//IO Ток
	spi_read(RG_WR | RG_IO);
	spi_read(param_current);
	//CONF
	spi_read(RG_WR | RG_CONF);
	spi_read(param_gain);
	//INT_REF | BUFFER_ON | CH0
	spi_read(param_rbc);
	// MODE CALIBR ZERO
	spi_read(RG_WR | RG_MODE);
	spi_read(param_z);
	spi_read(param_filter | INT_CLK_PIN_MODE_L);
	adc_wait_ready();
	// MODE CALIBR SCALE
	spi_read(RG_WR | RG_MODE);
	spi_read(param_s);
	spi_read(param_filter | INT_CLK_PIN_MODE_L);
	adc_wait_ready();

	adc_stop();

	return (adc_id & 0x0f);

}


/**************************************************************************************************/
// для совместимости
/*
DWORD adc_get(BYTE ch) {
	static DWORD_VAL data;

	spi_read(RG_WR | RG_CONF);
	spi_read(BIAS_DISABLE | BIPOLAR | BOOST_OFF | GAIN_1);
	spi_read(INT_REF | BUFFER_ON | ch);

	spi_read(RG_WR | RG_MODE);
	spi_read(SINGLE_CONV_MODE_H);
	spi_read(ARATE_240_MODE_L | INT_CLK_PIN_MODE_L);

	adc_wait_ready();

	data.Val = adc_read();

	return data.Val;

}
*/

/**************************************************************************************************/
DWORD adc_get_ex(BYTE param_gain, BYTE param_rbc, BYTE param_filter) {
	static DWORD_VAL data;
	
	adc_set(param_gain, param_rbc, param_filter);

	adc_wait_ready();
	
	data.Val = adc_read();

	return data.Val;
}


/**************************************************************************************************/
// Процедуры для state machine
/**************************************************************************************************/
void AD779x_start(BYTE param_gain, BYTE param_rbc, BYTE param_filter) {
	
	adc_set(param_gain, param_rbc, param_filter);	

}

/**************************************************************************************************/
BYTE AD779x_conv_done(void) {
	BYTE state;

	SSPEN = 0;
	ADC_CS = 0;
	NOP();

	if (ADC_RDY) state = 0;	else state = 1;
	NOP();

	SSPEN = 1;
	ADC_CS = 1;

	return state;
}

/**************************************************************************************************/
DWORD AD779x_read_and_stop(void) {
	DWORD_VAL data;
	
	data.Val = adc_read();	
		
	// pwdn mode
	adc_sleep();

	return data.Val;
}

/**************************************************************************************************/
BYTE adc_get_gain(BYTE param){
	switch(param){
		default: 
		case GAIN_1: return 1;
		case GAIN_2: return 2;
		case GAIN_4: return 4;
		case GAIN_8: return 8;
		case GAIN_16: return 16;
		case GAIN_32: return 32;
		case GAIN_64: return 64;
		case GAIN_128: return 128;
	}
}
