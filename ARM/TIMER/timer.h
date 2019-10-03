#ifndef __TIMER_H
#define __TIMER_H

#include "stm32f10x_rcc.h"
#include "stm32f10x_tim.h"
#include "stm32f10x_gpio.h"
#include "stm32f10x.h"
#include "misc.h"
#include "usart.h"

//  timer2 interrupt Init
//  ARR 自动重装载值
//  PSC 分频系数
//  Tout（溢出时间）=（ARR+1)(PSC+1)/Tclk
void Timer2_IntInit(u16 ARR, u16 PSC);

//  timer3 PWM Init
//  ARR 自动重装载值
//  PSC 分频系数
//  Tout（溢出时间）=（ARR+1)(PSC+1)/Tclk
void Timer3_PWMInit(u16 ARR, u16 PSC);

//  timer3 PWM Init
//  ARR 自动重装载值
//  PSC 分频系数
//  Tout（溢出时间）=（ARR+1)(PSC+1)/Tclk
void Timer5_CapInit(u16 ARR, u16 PSC);


#endif
