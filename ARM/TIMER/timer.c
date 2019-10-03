#include "timer.h"


//  Tout（溢出时间）=（ARR+1)(PSC+1)/Tclk

//  Timer2 interrupt initial
void Timer2_IntInit(u16 ARR, u16 PSC){
    
    TIM_TimeBaseInitTypeDef TimInitStr;
    NVIC_InitTypeDef NVICInitStr;

    RCC_APB1PeriphClockCmd(RCC_APB1ENR_TIM2EN, ENABLE); //  使能APB1时钟


    TimInitStr.TIM_ClockDivision = TIM_CKD_DIV1; //输入捕获用设置时钟分割:TDTS = Tck_tim	
    TimInitStr.TIM_CounterMode = TIM_CounterMode_Up;    //TIM向上计数模式
    TimInitStr.TIM_Period = ARR;            //设置在下一个更新事件装入活动的自动重装载寄存器周期的值
    TimInitStr.TIM_Prescaler = PSC;         //设置用来作为TIMx时钟频率除数的预分频值

    TIM_TimeBaseInit(TIM2, &TimInitStr);    //  初始化定时器配置

    TIM_ITConfig(TIM2, TIM_IT_Update, ENABLE);

    NVICInitStr.NVIC_IRQChannel = TIM2_IRQn;    // 开定时器中断
    NVICInitStr.NVIC_IRQChannelCmd = ENABLE;
    NVICInitStr.NVIC_IRQChannelPreemptionPriority = 1;
    NVICInitStr.NVIC_IRQChannelSubPriority = 2;

    NVIC_Init(&NVICInitStr);    //  配置中断管理


    TIM_Cmd(TIM2, ENABLE);

}

//  定时器2溢出中断
void TIM2_IRQHandler(){
	
	if (TIM_GetITStatus(TIM2, TIM_IT_Update) != RESET)  //检查TIM3更新中断发生与否
	{
		TIM_ClearITPendingBit(TIM2, TIM_IT_Update  );  //清除TIMx更新中断标志 
		printf("Hello World \r\n");
	}
	
}


void Timer3_PWMInit(u16 ARR, u16 PSC){

    GPIO_InitTypeDef GPIOInitStr;
    TIM_TimeBaseInitTypeDef TimebaseInitStr;
    TIM_OCInitTypeDef TimOCInitStr;

    RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM3, ENABLE); //  使能定时器3时钟
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_AFIO, ENABLE); //  使能AFIO时钟
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOB, ENABLE); //  使能AFIO时钟

    //  GPIO TIM3 CH2 端口重映射
    GPIO_PinRemapConfig(GPIO_PartialRemap_TIM3, ENABLE);
    GPIOInitStr.GPIO_Mode = GPIO_Mode_AF_PP;
    GPIOInitStr.GPIO_Pin = GPIO_Pin_5;
    GPIOInitStr.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_Init(GPIOB, &GPIOInitStr);


    //  使能定时器3
    TimebaseInitStr.TIM_ClockDivision = 0;
    TimebaseInitStr.TIM_CounterMode = TIM_CounterMode_Up;
    TimebaseInitStr.TIM_Period = ARR;
    TimebaseInitStr.TIM_Prescaler = PSC;

    TIM_TimeBaseInit(TIM3, &TimebaseInitStr);


    //  初始化定时器3的通道二
    TimOCInitStr.TIM_OCMode = TIM_OCMode_PWM1;  //选择定时器模式:TIM脉冲宽度调制模式2
    TimOCInitStr.TIM_OutputState = TIM_OutputState_Enable;  //比较输出使能
    TimOCInitStr.TIM_OCPolarity = TIM_OCPolarity_High;  //输出极性:TIM输出比较极性高
    TIM_OC2Init(TIM3, &TimOCInitStr);

    TIM_OC2PreloadConfig(TIM3, TIM_OCPreload_Enable);   //使能TIM3在CCR2上的预装载寄存器

	TIM_Cmd(TIM3, ENABLE);  //使能TIM3

}

void Timer5_CapInit(u16 ARR, u16 PSC){

    GPIO_InitTypeDef GpioInitStr;
    TIM_TimeBaseInitTypeDef TimebaseInitStr;
    TIM_ICInitTypeDef TimeICInitStr;
    NVIC_InitTypeDef NVICInitStr;

    RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM5, ENABLE);
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA, ENABLE);


    GpioInitStr.GPIO_Mode = GPIO_Mode_IPD;
    GpioInitStr.GPIO_Pin = GPIO_Pin_0;
    GPIO_Init(GPIOA, &GpioInitStr);
    GPIO_ResetBits(GPIOA,GPIO_Pin_0);						 //PA0 下拉

    TimebaseInitStr.TIM_ClockDivision = TIM_CKD_DIV1;       //设置时钟分割:TDTS = Tck_tim
    TimebaseInitStr.TIM_CounterMode = TIM_CounterMode_Up;
    TimebaseInitStr.TIM_Period = ARR;
    TimebaseInitStr.TIM_Prescaler = PSC;
    TIM_TimeBaseInit(TIM5, &TimebaseInitStr);

	//初始化TIM5输入捕获参数
	TimeICInitStr.TIM_Channel = TIM_Channel_1; //CC1S=01 	选择输入端 IC1映射到TI1上
  	TimeICInitStr.TIM_ICPolarity = TIM_ICPolarity_Rising;	//上升沿捕获
  	TimeICInitStr.TIM_ICSelection = TIM_ICSelection_DirectTI; //映射到TI1上
  	TimeICInitStr.TIM_ICPrescaler = TIM_ICPSC_DIV1;	 //配置输入分频,不分频 
  	TimeICInitStr.TIM_ICFilter = 0x00;//IC1F=0000 配置输入滤波器 不滤波
    TIM_ICInit(TIM5, &TimeICInitStr);

    // 使能CC1中断-当检测到边沿时进入中断
    // 使能update中断-当计数器溢出则产生溢出中断  用来延长计时的时间。
    TIM_ITConfig(TIM5, TIM_IT_Update|TIM_IT_CC1, ENABLE);
    
    NVICInitStr.NVIC_IRQChannel = TIM5_IRQn;
    NVICInitStr.NVIC_IRQChannelCmd = ENABLE;
    NVICInitStr.NVIC_IRQChannelPreemptionPriority = 2;
    NVICInitStr.NVIC_IRQChannelSubPriority = 3;
    NVIC_Init(&NVICInitStr);

    TIM_Cmd(TIM5, ENABLE); // 使能定时器5

}


u8  TIM5CH1_CAPTURE_STA=0;	//输入捕获状态		    				
u16	TIM5CH1_CAPTURE_VAL;	//输入捕获值

//定时器5中断服务程序	 
void TIM5_IRQHandler(void)
{ 

 	if((TIM5CH1_CAPTURE_STA&0X80)==0)//还未成功捕获	
	{	  
		if (TIM_GetITStatus(TIM5, TIM_IT_Update) != RESET)
		{	    
			if(TIM5CH1_CAPTURE_STA&0X40)//已经捕获到高电平了
			{
				if((TIM5CH1_CAPTURE_STA&0X3F)==0X3F)//高电平太长了
				{
					TIM5CH1_CAPTURE_STA|=0X80;//标记成功捕获了一次
					TIM5CH1_CAPTURE_VAL=0XFFFF;
				}else TIM5CH1_CAPTURE_STA++;
			}	 
		}
	if (TIM_GetITStatus(TIM5, TIM_IT_CC1) != RESET)//捕获1发生捕获事件
		{	
			if(TIM5CH1_CAPTURE_STA&0X40)		//捕获到一个下降沿 		
			{	  			
				TIM5CH1_CAPTURE_STA|=0X80;		//标记成功捕获到一次上升沿
				TIM5CH1_CAPTURE_VAL=TIM_GetCapture1(TIM5);
		   		TIM_OC1PolarityConfig(TIM5,TIM_ICPolarity_Rising); //CC1P=0 设置为上升沿捕获
			}else  								//还未开始,第一次捕获上升沿
			{
				TIM5CH1_CAPTURE_STA=0;			//清空
				TIM5CH1_CAPTURE_VAL=0;
	 			TIM_SetCounter(TIM5,0);
				TIM5CH1_CAPTURE_STA|=0X40;		//标记捕获到了上升沿
		   		TIM_OC1PolarityConfig(TIM5,TIM_ICPolarity_Falling);		//CC1P=1 设置为下降沿捕获
			}		    
		}			     	    					   
 	}
 
    TIM_ClearITPendingBit(TIM5, TIM_IT_CC1|TIM_IT_Update); //清除中断标志位
 
}
