/************************************************************************************************
 *
 *  File:           buttons.h
 *
 *  Compilers:      HT-PICC STD
 *                  HT-PICC18 STD
 *
 *  Programmer:     Timofeev Victor
 *                  osa@pic24.ru, testerplus@mail.ru
 *
 *  Description:    Header for Task_Buttons
 *
 ************************************************************************************************/

#ifndef _TASK_BUTTONS_H
#define _TASK_BUTTONS_H


//******************************************************************************
//  
//      Constants
// 
//******************************************************************************

//------------------------------------------------------------------------------
//  Buttons pins definitions (up to 8 pins)
//------------------------------------------------------------------------------
/*
 * in HardwareProfile.h sample:
 *#define pin_BUTTON0     RB0
 *#define pin_BUTTON1     RB1
 *#define pin_BUTTON2     RB2
 *#define pin_BUTTON3     RB3
 *#define pin_BUTTON4     RB4
 *#define pin_BUTTON5     RB5
 *#define pin_BUTTON6     RB6
 *#define pin_BUTTON7     RB7
 *
 */
#include "HardwareProfile.h"

//------------------------------------------------------------------------------
//  Needed information
//  (Make unneded definitions commented)
//------------------------------------------------------------------------------

#define BUTTONS_ENABLE_JUST_PRESSED     // We need info about just pressed buttons
#define BUTTONS_ENABLE_JUST_RELEASED    // We need info about just released buttons
#define BUTTONS_ENABLE_CHANGED          // We need info about state changing
#define BUTTONS_ENABLE_SHORT_HOLD       // We need info about short and long presses

//------------------------------------------------------------------------------
//  Timings (in milliseconds)
//------------------------------------------------------------------------------

#define BUTTONS_TASK_INTERVAL     20    // Period of Task_Button() execution
#define BUTTONS_HOLD_TIME       1200    // Holding time.
// Note: relation HOLD_TIME/TASK_INTERVAL
// must be less than 64.
// (see definition of TBUTTONS.ucCounter)

//******************************************************************************
//  
//      Types
// 
//******************************************************************************

//------------------------------------------------------------------------------
//  Buttons type definition
//------------------------------------------------------------------------------

typedef struct {
    unsigned char ucPressed; // Current buttons state
    unsigned char ucJitter : 2; // Counter for debouncing
    unsigned char ucCounter : 6; // Counter forchecking hold buttons

    //------------------------------------------------------------------------------
#ifdef  BUTTONS_ENABLE_SHORT_HOLD

    unsigned char ucHold; // Hold buttons.
    unsigned char ucShort; // Event (must be cleared in software):
    // After releasing set to "1" if
    // there was not holding.
#endif
    //------------------------------------------------------------------------------
#ifdef  BUTTONS_ENABLE_JUST_PRESSED

    unsigned char ucJustPressed; // Event (must be cleared in software):
    // button was just pressed
#endif
    //------------------------------------------------------------------------------
#ifdef  BUTTONS_ENABLE_JUST_RELEASED

    unsigned char ucJustReleased; // Event (must be cleared in software):
    // button was just released
#endif
    //------------------------------------------------------------------------------
#ifdef  BUTTONS_ENABLE_CHANGED

    unsigned char ucChanged; // Event (must be cleared in software):
    // button state was just changed
    // (pressed, released or hold)
#endif
    //------------------------------------------------------------------------------

} TBUTTONS;

//******************************************************************************
//  
//      Variables
// 
//******************************************************************************

extern volatile TBUTTONS m_Buttons;

//******************************************************************************
//  
//      Function prototypes
// 
//******************************************************************************
/*
 * Функция вызывается раз в 20 мс.
 * Следует отметить, что макси JustPressed, JustReleased, Short и Changed - это события,
 * а не состояния, и их нужно обнулять вручную после обработки.
 *
 */
extern void Task_Buttons(void);




#endif

//******************************************************************************
// 
//      THE END (buttons.h)
// 
//******************************************************************************

