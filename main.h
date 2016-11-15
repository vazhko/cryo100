

#define RS232_ADR			0x55
#define UREF				2.5
#define	T1SEC				255
#define	T05SEC				128

//#define	USE_SLIDE_FILTER

/******************************************************************************************/
#include "GenericTypeDefs.h"
#include "macro.h"
#include "eeprom.h"
#include "delay.h"

#include "ad7793.h"
#include "lcd.h"
#include "sub18.h"
#include "usart.h"
#include "slide_filter.h"
//#include "buttons.h"
#include "sensors.h"
#include "messages.h"


#define	BTN1    (1 << 0)
#define	BTN2    (1 << 1)


typedef enum {
    MSG_KEY_NONE = 0,
    MSG_KEY,
    MSG_KEY_P_PRESSED,
    MSG_KEY_M_PRESSED,
    MSG_KEY_LONG_PRESSED,
} MSG;


typedef enum {
   ST_INIT = 0,
   ST_NORM,
   ST_SENS,
   ST_CALIBR,
} ST;

typedef struct {
    double f_curr_T[8]; 
    double f_curr_R[8];
    DWORD d_curr_T[8];
    DWORD d_curr_R[8];
    DWORD d_curr_D[8];
    WORD w_curr_T[8]; 
    WORD w_curr_R[8];
    WORD w_curr_D[8];
} DATA;

