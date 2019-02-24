# PrincelingModuleHub

## Description

​	这里存放的是我写的一些模块

### ModuleIntroduction

**counter_mod_m** 模m计数器

```verilog
    counter_mod_m #(.M(4), .N(2)) counter_mod_p_tick(
        .clk(clk),
        .rst_n(rst_n),
        .m_out(p_tick_w)
    );
// M 为 模数   N 为 Log(2,n)向上取整
```

**debounce** 一位的按键消抖，状态机实现

**posedge_detect** 上升沿检测

**uart**	8位数据位，1位起始位，1位结束位的串口通信，其中包括，串口接受uart_rx , 串口发送uart_tx

**digitaltubedisplay**	十六进制的数码管显示，段位选都是共阳 特别注意使用共阴时得把段选也取反

**VGA** 	基本的 VGA 同步驱动 vga_sync  （理解了我好久） 下面是例化的示范代码

```verilog
    vga_sync u1_vga_sync(
        .clk(clk),
        .rst_n(rst_n),
        .hsync(hsync),
        .vsync(vsync),
        .pixel_x(pixel_x),
        .pixel_y(pixel_y),
        .video_on(video_on),
        .p_tick(p_tick)
    );   // VGA 640*480
/*------------------------ in and out ports description ----------------
          clk 输入100Mhz时钟
            rst_n 复位
            hsync h:horizontal 行同步信号
            vsync v:vertical 垂直同步信号
            video_on 显示使能
            p_tick 经过分频后与显示器适配的时钟, 这里取 25Mhz  外部电路利用此信号可以和
VGA显示同步
            pixel_x,pixel_y  像素点的坐标        对显示器，左上角为00 右下角为左边的边界, 如 		[639,479]
*/
```

**binary2bcd**     可扩展（扩展功能并不完善,需要自己手动添加循环）的任意二进制转换成bcd码的电路，默认12位以下可以转换 

```verilog
module  binary2bcd #(
    parameter B_SIZE=12 //B_SIZE为二进制数所占的位数，可根据需要进行扩展 
)(
    input wire rst_n,
    input wire [B_SIZE-1 : 0] binary,
    output reg [B_SIZE+3 : 0] bcd
    );   //rst_n为使能端，binary为待转换的二进制数，bcd为转换后的BCD码      
// 如果需要扩展 B_SIZE 的值需要改变
// 并且扩展时需要参照以下三条语句续写
   if(result[3:0] > 4)            
    result[3:0]=result[3:0]+ 4'd3;      
   if(result[7:4] > 4)            
    result[7:4]=result[7:4]+4'd3;  
   if(result[11:8] > 4)   	   
	result[11:8] = result[11:8]+4'd3;
//比如
   if(result[15:12] > 4) result[15:12] = result[15:12] + 4'd3;
 
```

