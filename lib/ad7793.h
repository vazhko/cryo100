#include    <pic18.h>
#include    "GenericTypeDefs.h"
#include    "HardwareProfile.h"


#define		RG_WR						0x00
#define 	RG_RD						0x40

#define 	RG_MODE           		  	0x08
#define 	RG_CONF           		  	0x10
#define 	RG_DATA						0x18
#define 	RG_ID						0x20
#define 	RG_IO						0x28
#define 	RG_OFS						0x30
#define 	RG_FSC						0x38

//For MODE
#define  	CONTINUOUS_MODE_H			0x00
#define  	SINGLE_CONV_MODE_H          0x20
#define  	IDLE_MODE_H					0x40
#define  	POWER_DOWN_MODE_H			0x60
#define  	IZS_CALIBR_MODE_H			0x80
#define  	IFS_CALIBR_MODE_H			0xA0
#define  	SZS_CALIBR_MODE_H			0xC0
#define  	SFS_CALIBR_MODE_H			0xE0
#define  	INT_CLK_MODE_L              0x00
#define  	INT_CLK_PIN_MODE_L          0x40
#define  	ARATE___4_MODE_L			0x01
#define  	ARATE___8_MODE_L			0x02
#define  	ARATE__16_MODE_L			0x03
#define  	ARATE__32_MODE_L			0x04
#define  	ARATE__40_MODE_L			0x05
#define  	ARATE__48_MODE_L			0x06
#define  	ARATE__60_MODE_L			0x07
#define  	ARATE_101_MODE_L			0x08
#define  	ARATE_120_MODE_L			0x09
#define  	ARATE_121_MODE_L			0x0a
#define  	ARATE_160_MODE_L			0x0b
#define  	ARATE_200_MODE_L			0x0c
#define  	ARATE_240_MODE_L			0x0d
#define  	ARATE_320_MODE_L			0x0e
#define  	ARATE_480_MODE_L			0x0f

// for conf
// high
#define  	BIAS_DISABLE				0x00	//BIAS_TO_AIN1 | BURNOUT_CURRENT_ON | UNIPOLAR | BOOST_ON | GAIN_8
#define  	BIAS_TO_AIN1				0x40
#define  	BIAS_TO_AIN2				0x80
#define  	BURNOUT_CURRENT_ON			0x20
#define  	BURNOUT_CURRENT_OFF			0x00
#define  	BIPOLAR						0x00
#define  	UNIPOLAR					0x10
#define  	BOOST_ON					0x08
#define  	BOOST_OFF					0x00
#define  	GAIN_1						0x00
#define  	GAIN_2						0x01
#define  	GAIN_4						0x02
#define  	GAIN_8						0x03
#define  	GAIN_16						0x04
#define  	GAIN_32						0x05
#define  	GAIN_64						0x06
#define  	GAIN_128					0x07
//low
#define  	EXT_REF						0x00	// INT_REF | BUFFER_ON | CH0
#define  	INT_REF						0x80
#define  	BUFFER_ON					0x10
#define  	BUFFER_OFF					0x00

#define  	CH0							0x00
#define  	CH1							0x01
#define  	CH2							0x02

#define  	AD7792_ID					0x0a
#define  	AD7793_ID					0x0b



#if defined(__18F46K22)
#define  	SSPEN		SSPCON1bits.SSPEN1
#define  	BF			SSP1STATbits.BF1
#endif


/**************************************************************************************************/
char spi_read (char DATA);
BYTE adc_init(BYTE param_gain, BYTE param_rbc, BYTE param_filter, BYTE param_current);
BYTE adc_init_ex(BYTE param_gain, BYTE param_rbc, BYTE param_filter, BYTE param_current, BYTE param_z, BYTE param_s ); // zero / scale calibrete
void adc_start(void);
void adc_wait_ready(void);
void adc_set(BYTE param_gain, BYTE param_rbc, BYTE param_filter);
DWORD adc_read(void);
void adc_stop(void); 
void adc_sleep(void);
//DWORD adc_get(BYTE ch);
DWORD adc_get_ex(BYTE param_gain, BYTE param_rbc, BYTE param_filter);

// return gain from param
// adc_get_gain(GAIN_128);
BYTE adc_get_gain(BYTE param);
/**************************************************************************************************/
// state machine
void AD779x_start(BYTE param_gain, BYTE param_rbc, BYTE param_filter);
BYTE AD779x_conv_done(void);
DWORD AD779x_read_and_stop(void);

