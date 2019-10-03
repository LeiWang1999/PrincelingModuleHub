#include "exti.h"
#include "key.h"
#include "stm32f10x_rcc.h"
#include "stm32f10x_gpio.h"
#include "stm32f10x_exti.h"
#include "misc.h"
#include "usart.h"
#include "delay.h"

void KeyEXTI_Init(void){

    EXTI_InitTypeDef EXTI_InitStr;
    NVIC_InitTypeDef NVIC_InitStr;

    KEY_Init(); //  初始化GPIO
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_AFIO, ENABLE);    //  初始化AFIO时钟

    //  WK_UP 触发中断
    GPIO_EXTILineConfig(GPIO_PortSourceGPIOA, GPIO_PinSource0); //  设置GPIO中断线

    EXTI_InitStr.EXTI_Line=EXTI_Line0;
    EXTI_InitStr.EXTI_LineCmd=ENABLE;
    EXTI_InitStr.EXTI_Mode=EXTI_Mode_Interrupt;
    EXTI_InitStr.EXTI_Trigger=EXTI_Trigger_Rising;
    EXTI_Init(&EXTI_InitStr);    //  外部中断初始化
	
	
    NVIC_InitStr.NVIC_IRQChannel = EXTI0_IRQn;
    NVIC_InitStr.NVIC_IRQChannelCmd=ENABLE;
    NVIC_InitStr.NVIC_IRQChannelPreemptionPriority = 1;
    NVIC_InitStr.NVIC_IRQChannelSubPriority = 1;
    NVIC_Init(&NVIC_InitStr);   //  配置中断管理
	
	//	KEY0 触发中断
    GPIO_EXTILineConfig(GPIO_PortSourceGPIOE, GPIO_PinSource4); //  设置GPIO中断线

    EXTI_InitStr.EXTI_Line=EXTI_Line4;
    EXTI_InitStr.EXTI_LineCmd=ENABLE;
    EXTI_InitStr.EXTI_Mode=EXTI_Mode_Interrupt;
    EXTI_InitStr.EXTI_Trigger=EXTI_Trigger_Falling;
    EXTI_Init(&EXTI_InitStr);    //  外部中断初始化
	
	
    NVIC_InitStr.NVIC_IRQChannel = EXTI4_IRQn;
    NVIC_InitStr.NVIC_IRQChannelCmd=ENABLE;
    NVIC_InitStr.NVIC_IRQChannelPreemptionPriority = 2;
    NVIC_InitStr.NVIC_IRQChannelSubPriority = 1;
    NVIC_Init(&NVIC_InitStr);   //  配置中断管理
	
	//	KEY1 触发中断
    GPIO_EXTILineConfig(GPIO_PortSourceGPIOE, GPIO_PinSource3); //  设置GPIO中断线

    EXTI_InitStr.EXTI_Line=EXTI_Line3;
    EXTI_InitStr.EXTI_LineCmd=ENABLE;
    EXTI_InitStr.EXTI_Mode=EXTI_Mode_Interrupt;
    EXTI_InitStr.EXTI_Trigger=EXTI_Trigger_Falling;
    EXTI_Init(&EXTI_InitStr);    //  外部中断初始化
	
	
    NVIC_InitStr.NVIC_IRQChannel = EXTI3_IRQn;
    NVIC_InitStr.NVIC_IRQChannelCmd=ENABLE;
    NVIC_InitStr.NVIC_IRQChannelPreemptionPriority = 3;
    NVIC_InitStr.NVIC_IRQChannelSubPriority = 1;
    NVIC_Init(&NVIC_InitStr);   //  配置中断管理
	

}


//  中断服务程序0
void EXTI0_IRQHandler(){
	
	delay_ms(10);
    if(WK_UP)
    printf("Key WK_UP has been pressed by interrupt \r\n");
	
    EXTI_ClearITPendingBit(EXTI_Line0);
}

//  中断服务程序3
void EXTI3_IRQHandler(){
	
	delay_ms(10);
    if(!KEY1)
    printf("Key KEY1 has been pressed by interrupt \r\n");
	
    EXTI_ClearITPendingBit(EXTI_Line3);
}

//  中断服务程序4
void EXTI4_IRQHandler(){
	
	delay_ms(10);
    if(!KEY0)
    printf("Key KEY0 has been pressed by interrupt \r\n");
	
    EXTI_ClearITPendingBit(EXTI_Line4);
}


