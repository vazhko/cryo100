#include 	<pic18.h>
#include 	<stdlib.h>
#include 	<stdio.h>
#include 	<math.h>

//#include "sensors.h"
#include "eeprom.h"
#include "sub18.h"

double R2T(BYTE ch, double r){
    double r0;


    r0 = log(r) - 7.0;
    return polynom(PF_M1_A0 + ch * 7 * 4, r0, 6);

}

