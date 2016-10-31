/* 
 * File:   sensors.h
 * Author: Vlad
 *
 * Created on 4 Май 2014 г., 20:56
 */

#ifndef SENSORS_H
#define	SENSORS_H

typedef struct tagSens {
    const char *s_name; // указатель на строку краткого названия термометра    
    const char *s_units; // указатель на строку единиц отображения
    const double *coeff; // указатель на полином
    unsigned char n; // количество коэффициентов
    unsigned char gain; // коэфф усиления
    unsigned char z; // знаков после запятой
    double min; // минимальное значение выходного аргумента для определения выхода за пределы
    double max; // максимальное значение выходного аргумента для определения выхода за пределы
} Sensors;



extern const Sensors sensors[];

#include "ad7793.h"

#endif	/* SENSORS_H */

