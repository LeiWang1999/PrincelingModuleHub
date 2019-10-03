#include "beep.h"
#include "stm32f10x.h"
#include "sys.h"

void BEEP_Init(){

    RCC->APB2ENR |= 1<<3;   //   使能GPIOB的时钟


    // 设置GPIOB.8
    GPIOB->CRH &= 0xFFFFFFF0;
    GPIOB->CRH |= 0x00000003;
	BEEP = 0;		//  初始的时候要拉低
}

