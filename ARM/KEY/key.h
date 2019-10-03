/*
    KEY1    KEY0    是PE3 和 PE4    低电平有效
    KEYUP   WK_UP   PA0             高电平有效
    RST     不是IO
 */
#ifndef __KEY_H
#define __KEY_H
#include "sys.h"

#define KEY0	PEin(4) //PE4
#define KEY1	PEin(3)	//PE3  
#define WK_UP 	PAin(0)	//PA0  WK_UP KEY_UP

#define KEY0_PRES 	1	//KEY0
#define KEY1_PRES	2	//KEY1
#define WKUP_PRES   3	//KEY_UP



void KEY_Init(void);
u8 KEY_Scan(u8 mode);

#endif
