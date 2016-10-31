/* 
 * File:   sensors.h
 * Author: Vlad
 *
 * Created on 4 ��� 2014 �., 20:56
 */

#ifndef SENSORS_H
#define	SENSORS_H

typedef struct tagSens {
    const char *s_name; // ��������� �� ������ �������� �������� ����������    
    const char *s_units; // ��������� �� ������ ������ �����������
    const double *coeff; // ��������� �� �������
    unsigned char n; // ���������� �������������
    unsigned char gain; // ����� ��������
    unsigned char z; // ������ ����� �������
    double min; // ����������� �������� ��������� ��������� ��� ����������� ������ �� �������
    double max; // ������������ �������� ��������� ��������� ��� ����������� ������ �� �������
} Sensors;



extern const Sensors sensors[];

#include "ad7793.h"

#endif	/* SENSORS_H */

