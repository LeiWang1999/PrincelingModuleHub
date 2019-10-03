#include "key.h"
#include "stm32f10x.h"
#include "delay.h"

void KEY_Init(void){

    //  开启GPIOE、GOUIA的时钟
    RCC->APB2ENR|=1<<2;
    RCC->APB2ENR|=1<<6;

    //  开启PA0, 设置为下拉输入
	GPIOA->CRL&=0XFFFFFFF0;	//PA0设置成输入，默认下拉	  
	GPIOA->CRL|=0X00000008; //10_00
    
    GPIOE->CRL&=0XFFF00FFF;	//PE3/4设置成输入	  
	GPIOE->CRL|=0X00088000;

	//	精英的按键低电平有效 上拉输入
	GPIOE->ODR|=1<<3;
    GPIOE->ODR|=1<<4;  

}

//按键处理函数
//返回按键值
//mode:0,不支持连续按;1,支持连续按;
//返回值:
//0，没有任何按键按下
//1，KEY0按下
//2，KEY1按下 
//3，KEY_UP按下 即WK_UP
//注意此函数有响应优先级,KEY0>KEY1>KEY_UP!!
u8 KEY_Scan(u8 mode)
{	 
	static u8 key_up=1;//按键按松开标志
	if(mode)key_up=1;  //支持连按		  
	if(key_up&&(KEY0==0||KEY1==0||WK_UP==1))
	{
		delay_ms(10);//去抖动 
		key_up=0;
		if(KEY0==0)return 1;
		else if(KEY1==0)return 2; 
		else if(WK_UP==1)return 3;
	}else if(KEY0==1&&KEY1==1&&WK_UP==0)key_up=1; 	    
 	return 0;// 无按键按下
}

