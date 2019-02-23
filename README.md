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

**vga** 	基本的 VGA 同步驱动 vga_sync  （理解了我好久） 下面是例化的示范代码

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

