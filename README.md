# PrincelingModuleHub

## Description

- 最后一次更新日期：2019年9月24日
- 这里是我写的一些FPGA模块

## IP Log

@2019年4月19日

- 添加了VGA 的 IP

@2019年10月3日

- 整理了一下、把图像处理的IP也增加进来了。
- 由于关注过https://github.com/Digilent/vivado-library 添加gitignore，取消该文件的上传
- 决定把ARM的IP也放进来。

@2019年10月25日

- 把powershell的配置文件添加进来
- 删除LearnGit仓库

### Powershell-ModuleIntroduction

- code_ps_profile_windows.ps1

  用于在windows下vscode和vivado结合，自动生成testbench脚本

  博文地址:  https://blog.csdn.net/qq_39498701/article/details/84668833 

- code_ps_profile_linux.ps1

  用于在linux下vscode和vivado结合，自动生成testbench脚本

- Microsoft.PowerShell_profile.ps1

  powershell窗口配色方案

  效果如下

  ![1571989568054](C:\Users\Princeling\AppData\Roaming\Typora\typora-user-images\1571989568054.png)

  ![1571989544511](C:\Users\Princeling\AppData\Roaming\Typora\typora-user-images\1571989544511.png)

### FPGA-ModuleIntroduction

- **counter_mod_m** 模m计数器

```verilog
    counter_mod_m #(.M(4), .N(2)) counter_mod_p_tick(
        .clk(clk),
        .rst_n(rst_n),
        .m_out(p_tick_w)
    );
// M 为 模数   N 为 Log(2,n)向上取整
```

- **debounce** 一位的按键消抖，状态机实现

- **edge_detect** 上升沿检测

  - 双边沿检测电路

    ```verilog
    module edge_detect(
        input wire clk,
        input wire rst_n,
        input wire signal,
        output wire pos_tick,
        output wire neg_tick
    );
    ```

    

- **uart**	8位数据位，1位起始位，1位结束位的串口通信，其中包括，串口接受uart_rx , 串口发送uart_tx

  - uart_rx

    ```verilog
    module uart_rx(
        input wire clk,
        input wire rxd,
        output wire receive_ack,
        output reg [7:0] data_i
        );
        
        //----------------receive_ack will be set once receive a 8bit data 
        //串口在接受的时候，receive_ack 信号为低，串口接受模块空闲则为高
    ```

  - uart_tx

    ```verilog
    module uart_tx(
        input wire [7:0] data_o,
        output reg txd,
        input wire clk,
        input wire rst,
        input wire tx_trig,
        output wire transmit_done
        );
        
        // tx_trig : 串口输入触发信号 高电平有效
    ```

- **digitaltubedisplay**	十六进制的数码管显示，段位选都是共阳 特别注意使用共阴时得把段选也取反

- **VGA** 	基本的 VGA 同步驱动 vga_sync  （理解了我好久） 下面是例化的示范代码

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

- **binary2bcd**     可扩展（扩展功能并不完善,需要自己手动添加循环）的任意二进制转换成bcd码的电路，默认12位以下可以转换 

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

- Sram_ctr	读写Sram的模块

  ```verilog
  
   module sram_ctr #(
      parameter   ADDR_WIDTH  =   19,
      parameter   DATA_WIDTH  =   16
  )(
      // system   signal
      input       wire        clk,
      input       wire        rst_n,
  
      //  Sram    signal
      output      wire    [ADDR_WIDTH-1:0]        sram_addr,
      inout       wire    [DATA_WIDTH-1:0]        sram_data,
      output      wire                            sram_ce_n,      //  chip_enable
      output      wire                            sram_lb_n,      //  low_8_byte_enable
      output      wire                            sram_oe_n,      //  output_enable
      output      wire                            sram_ub_n,      //  high_8_byte_enable
      output      wire                            sram_we_n,      //  write_enable
  
      // input    signal
      input       wire                                write_tick,
      input       wire                                read_tick,
      input       wire        [DATA_WIDTH-1:0]        data_in,
      output      wire        [DATA_WIDTH-1:0]        data_out,
      input       wire        [ADDR_WIDTH-1:0]        addr_in
      );
  ```


