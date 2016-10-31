
#ifndef HARDWARE_PROFILE_H
#define HARDWARE_PROFILE_H


#define CLOCK_FREQ                  40000000
//#define GetSystemClock()            CLOCK_FREQ
//#define GetInstructionClock()       CLOCK_FREQ
#define _XTAL_FREQ                  CLOCK_FREQ
#define PIC_CLK                     CLOCK_FREQ

//#define USE_BRGH16
#define BRGH_VAL                        1
#define BAUD				115200
#if BRGH_VAL == 0
#define UART_DIVIDER 			((int)(CLOCK_FREQ/(64UL * BAUD) -1))
#else
#define UART_DIVIDER 			((int)(CLOCK_FREQ/(16UL * BAUD) -1))
#endif



#define INPUT_PIN 1
#define OUTPUT_PIN 0


// SST25VF016
#define  USE_SST25VF016
#define  SST25_CS_LAT       LATA4
#define  SST25_CS_TRIS      TRISA4

#define  SST25_SCK_TRIS     TRISC3
#define  SST25_SDO_TRIS     TRISC5
#define  SST25_SDI_TRIS     TRISC4

#define SST25_SPISTAT       SSPSTAT

#define SST25_SPICON1       SSPCON1	

#define SST25_SPIBUF        SSPBUF	
#define SST25_SPI_IF        SSPIF



// AD7793
#define		ADC_CS			LATB2
#define		ADC_CS_TRIS		TRISB2

#define		ADC_RDY			PORTCbits.RC4
#define		ADC_RDY_TRIS		TRISC4

#define		ADC_CLK			LATC3
#define		ADC_CLK_TRIS		TRISC3

#define		ADC_DOUT		LATC5
#define		ADC_DOUT_TRIS		TRISC5


#define     LCD_TRIS_DATA               TRISD
#define     LCD_DATA                    LATD
#define     LCD_DATA_IN                 PORTD

#define     LCD_TRIS_RW                 TRISE0
#define     LCD_TRIS_RS 		TRISE1
#define     LCD_TRIS_EN 		TRISE2

#define     LCD_RW			LATE0
#define     LCD_RS			LATE1
#define     LCD_EN			LATE2



#define	FLTR_DATA_COUNT             8       // количество каналов
#define	FLTR_ERR_COUNT              1       // количество одиночных помех
#define	FLTR_ERR_VALUE              2.0     // величина отклонения, классифицируемое, как "одиночка"
#define	FLTR_MODE2                  1



#define	LIGHT_ON			LATC1
#define	DCDC_ON				LATA2
#define	CHARGE_ON			LATC2
#define	LCD_ON				LATC0
#define	USB_RES				LATA3
#define	USB_DETECT			RA4
#define	LBO				RA5

#define pin_BUTTON0             PORTBbits.RB0
#define pin_BUTTON1             PORTBbits.RB1



#endif  //HARDWARE_PROFILE_H
