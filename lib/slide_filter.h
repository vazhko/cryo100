#ifndef _SLIDE_FLTR
#define _SLIDE_FLTR

#include	"HardwareProfile.h"
//#include	"GenericTypeDefs.h"
//#include 	"macro.h"

/******************************************************************************************/
// ”казать в HardwareProfile.h!!!
//#define	FLTR_DATA_COUNT		2		// количество каналов
//#define	FLTR_ERR_COUNT		1		// количество одиночных помех
//#define	FLTR_ERR_VALUE		50.0	// величина отклонени€, классифицируемое, как "одиночка"
//#define	FLTR_MODE2


#if FLTR_DATA_COUNT == 1
#define FLTR_DATA_INIT_VAL {0}
#elif FLTR_DATA_COUNT == 2
#define FLTR_DATA_INIT_VAL {0,0}
#elif FLTR_DATA_COUNT == 3
#define FLTR_DATA_INIT_VAL {0,0,0}
#elif FLTR_DATA_COUNT == 4
#define FLTR_DATA_INIT_VAL {0,0,0,0}
#elif FLTR_DATA_COUNT == 5
#define FLTR_DATA_INIT_VAL {0,0,0,0,0}
#elif FLTR_DATA_COUNT == 6
#define FLTR_DATA_INIT_VAL {0,0,0,0,0,0}
#elif FLTR_DATA_COUNT == 7
#define FLTR_DATA_INIT_VAL {0,0,0,0,0,0,0}
#elif FLTR_DATA_COUNT == 8
#define FLTR_DATA_INIT_VAL {0,0,0,0,0,0,0,0}
#else
	#error define FLTR_DATA_COUNT
#endif

/******************************************************************************************/

typedef struct tagFF{
	double  filter[5];
} FF;


/******************************************************************************************/
void filter(double *data, unsigned char ch, unsigned char do_init);
// функци€ с авто инициализацией
void filter_processor(double *data, unsigned char ch);

#endif