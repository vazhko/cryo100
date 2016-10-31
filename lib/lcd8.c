#include "lcd.h"
#include "delay.h"

/***************************************************************************************/
#define IOFF						uGIE=(BYTE)GIE,GIE=0
#define ION							if(uGIE)GIE=1

/***************************************************************************************/
//static WORD 	timeout;

/***************************************************************************************/
char const c_lcd_prog[] = {//0 - gradus

	//gradus
	0b00000110,
	0b00001001,
	0b00001001,
	0b00000110,
	0b10000000,
	0b10000000,
	0b10000000,
	0b10000000,

	// Ohm
	0b10000000,
	0b00001110,
	0b00010001,
	0b00010001,
	0b00001010,
	0b10011011,
	0b10000000,
	0b10000000,
	
	// rs-232
	0b00010101,     
	0b00011111,
	0b00011111,
	0b00000100,
	0b00001000,
	0b00001000,
	0b00000111,
	0b10000000,
	
	// квадрат
	0b11111111,     
	0b11111111,
	0b11111111,
	0b11111111,
	0b11111111,
	0b11111111,
	0b11111111,
	0b10000000,
	
	//серый квадрат
	0b01010101,     
	0b10101010,
	0b01010101,     
	0b10101010,
	0b01010101,     
	0b10101010,
	0b01010101,     
	0b10000000,
	
	//полу квадрат
	0b01010101,     
	0b10101010,
	0b01010101,     
	0b10101010,
	0b01111111,     
	0b11111111,
	0b01111111,     
	0b10000000,
	
	/*
	0b10000000,
	0b10000000,
	0b00000001,
	0b00000011,
	0b00000101,
	0b10001001,										
	0b11111111,
	0b10000000, 
	
	0b10000000,
	0b10000100,
	0b11111110,
	0b01111111,
	0b11111110,
	0b10000100,										
	0b10000000,
	0b10000000,
	 */

	0
};

/***************************************************************************************/
void _lcd_strobe(void) {

	LCD_EN = 1;
	DelayUs(1);
	NOP();
	NOP();
	NOP();
	NOP();
	LCD_EN = 0;
}

/****************************************************************************/
#ifdef USE_LCD4

void lcd_wr4(char data4){

	if (data4 & 1) LCD_LAT_BIT0 = 1; else LCD_LAT_BIT0 = 0;
	if (data4 & 2) LCD_LAT_BIT1 = 1; else LCD_LAT_BIT1 = 0;
	if (data4 & 4) LCD_LAT_BIT2 = 1; else LCD_LAT_BIT2 = 0;
	if (data4 & 8) LCD_LAT_BIT3 = 1; else LCD_LAT_BIT3 = 0;

	DelayUs(1);
}

#endif
/****************************************************************************/
void lcd_set_port_tris(char st){
	
#ifdef USE_LCD4
	if(st == 0){
		LCD_TRIS_BIT0 = 0;
		LCD_TRIS_BIT1 = 0;
		LCD_TRIS_BIT2 = 0;
		LCD_TRIS_BIT3 = 0;
	} else {
		LCD_TRIS_BIT0 = 1;
		LCD_TRIS_BIT1 = 1;
		LCD_TRIS_BIT2 = 1;
		LCD_TRIS_BIT3 = 1;	
	}

#else
	if(st == 0){
		LCD_TRIS_DATA = (0);
	} else {
		LCD_TRIS_DATA = (0xff);
	}	

#endif	
}
	
/****************************************************************************/
void lcd_wr_port(char data){
	
#ifdef USE_LCD4
	
	lcd_wr4(data >> 4);
	_lcd_strobe();
	lcd_wr4(data & 0xF);
	_lcd_strobe();
#else
	
	LCD_DATA = (data);
	_lcd_strobe();
#endif	
}

/***************************************************************************/
char lcd_read_cmd_nowait(void) {
	char c = 0;
	///BYTE lo, hi;
	BYTE fl = (BYTE) GIE;
	GIE = 0;	
	
	lcd_set_port_tris(1);
	
	LCD_EN = 0;	
	LCD_RW = 1;
	DelayUs(1);
	LCD_EN = 1;
	DelayUs(1);	
	
#ifdef USE_LCD4	

	if(LCD_PORT_BIT0 == 1) SETBIT(c, 4);
	if(LCD_PORT_BIT1 == 1) SETBIT(c, 5);
	if(LCD_PORT_BIT2 == 1) SETBIT(c, 6);
	if(LCD_PORT_BIT3 == 1) SETBIT(c, 7);
		
	LCD_EN = 0;
	DelayUs(1);
	LCD_EN = 1;	
	DelayUs(1);	

	if(LCD_PORT_BIT0 == 1) SETBIT(c, 0);
	if(LCD_PORT_BIT1 == 1) SETBIT(c, 1);
	if(LCD_PORT_BIT2 == 1) SETBIT(c, 2);
	if(LCD_PORT_BIT3 == 1) SETBIT(c, 3);	

#else
	
	c = LCD_DATA_IN;
	
#endif	

	NOP();
	LCD_EN = 0;
	LCD_RW = 0;
	lcd_set_port_tris(0);

	GIE = (bit)fl;

	return (c);
}

/******************************************************************************/
void _lcd_ready(void) {

	unsigned int retry;
	char c;

	for (retry = 1000; retry-- > 0;) {		
		c = lcd_read_cmd_nowait();
		if (0 == (c & 0x80)) break; // Check busy bit.  If zero, no longer busy
	}

}

/***************************************************************************************/
void lcd_send_cmd(char data) {

	BYTE fl = (BYTE) GIE;	
	GIE = 0;
	
	_lcd_ready();
	
	lcd_set_port_tris(0);
	LCD_RS = 0;
	LCD_EN = 0;
	LCD_RW = 0;
	lcd_wr_port(data);
		

	GIE = (bit)fl;
}

/***************************************************************************************/
void lcd_putc(char c) {

	BYTE fl = (BYTE) GIE;	
	GIE = 0;	

	_lcd_ready();
	
	lcd_set_port_tris(0);
	LCD_RS = 1;
	LCD_EN = 0;
	LCD_RW = 0;
	
	lcd_wr_port(c);
	
	LCD_RS = 0;	

	GIE = (bit)fl;
	NOP();
}

/***************************************************************************************/
void lcd_init(void) {
	BYTE i;

	LCD_TRIS_RW = 0;
	LCD_TRIS_RS = 0;
	LCD_TRIS_EN = 0;

	LCD_RS = 0;
	LCD_EN = 0;
	LCD_RW = 0;
	
	lcd_set_port_tris(0);

#ifdef USE_LCD4
	lcd_wr4(3);
#else
	LCD_DATA = (INI);
#endif

	for (i = 0; i <= 10; i++) {
		DelayMs(200);
		_lcd_strobe();
	}
	
#ifdef USE_LCD4	

	lcd_wr4(2);
	_lcd_strobe();
	
	lcd_send_cmd(0x28);
	//lcd_send_cmd(0xc);	//Display On, Cursor On, Cursor Blink
	//lcd_send_cmd(1);		//Display Clear
	//lcd_send_cmd(6);		//Entry Mode
	//lcd_send_cmd(0x80);	//Initialize DDRAM address to zero
	//lcd_send_cmd(0x80);	//Initialize DDRAM address to zero
	//lcd_putc(' ');
	//lcd_putc(' ');
	//lcd_putc(' ');
	//lcd_putc(' ');
	
#else

	lcd_send_cmd(0x38);

#endif	

	lcd_send_cmd(0x06);
	lcd_send_cmd(0x0c);
	lcd_send_cmd(0x01);	
	//lcd_send_cmd(0x80);	//Initialize DDRAM address to zero
	//lcd_send_cmd(0x80);	//Initialize DDRAM address to zero
}

/***************************************************************************************/
void lcd_goto(BYTE x, BYTE y) { //todo: отладить!!!
	BYTE fl = (BYTE) GIE;
	GIE = 0;

	switch (y) {
		case 0:
			lcd_send_cmd(0x80 + x);
			break;
		case 1:
			lcd_send_cmd(0xC0 + x);
			break;
		case 2:
			lcd_send_cmd(0x90 + x + LCD20);
			break;
		case 3:
			lcd_send_cmd(0xD0 + x + LCD20);
			break;
	}
	GIE = (bit)fl;
}


/***************************************************************************************/
void lcd_puts(const char *s) {
	while (*s) lcd_putc(*s++);
}

/***************************************************************************************/
// печать 0 или 1
void lcd_puts_ex(const char *s) {
	while (*s) {

		switch (*s) {
				// gradus
			case '@':
				lcd_putc(1);
				break;
				// Ohm
			case '^':
				lcd_putc(2);
				break;

			default:
				lcd_putc(*s);
				break;
		}
		s++;

	}

}

/***************************************************************************************/
void lcd_prog(void) {
	BYTE i_char, i = 0;

	i_char = 0b01001000;

	do {
		lcd_send_cmd(i_char++);
		DelayUs(20);
		lcd_putc(c_lcd_prog[i++]);
		DelayUs(20);
	} while (c_lcd_prog[i]);

}


