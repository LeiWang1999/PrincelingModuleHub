`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/01/21 18:32:36
// Design Name: 
// Module Name: tubeDisplay
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tubeDisplay(
    input clk,
    input [3:0] data0,data1,data2,data3,
    input [3:0] dp_in,
    output reg[7:0] eight_seg,
    output reg seg0,seg1,seg2,seg3
    );// Basys3 用 100MHZ
    /*
    dp_in 四位数码管的小数点
    clk   100Mhz的时钟信号
    date  四个四位数据的输入
    eight_seg 八段数码管
    seg     四个代码段

    */
    reg[3:0]flg=0;
    integer delay_c = 0;
    localparam 
    zero	=	7'b100_0000,
    one		=	7'b111_1001,
    two     =	7'b010_0100,
    three   =	7'b011_0000,
    four    =	7'b001_1001,
    five    =	7'b001_0010,
    six     =	7'b000_0010,
    seven   =	7'b111_1000,
    eight   =	7'b000_0000,
    nine    =	7'b001_0000,
    a       =   7'b000_1000,
    b       =   7'b000_0011,
    c       =   7'b100_0110,
    d       =   7'b010_0001,
    e       =   7'b000_0110,
    f       =   7'b000_1110,
    nothing =   7'b111_1111;
    
    always@(posedge clk)
    begin
    if(delay_c==500000) // 100MZ 
        begin
            delay_c<=0;
            flg<=flg+1;
        end
        else delay_c<=delay_c+1;
    if(flg%4==0)
        begin
            seg0<=0;seg1<=1;seg2<=1;seg3<=1;   
            eight_seg[7] <= dp_in[0];
            case(data0)
                0:eight_seg[6:0]<= zero;
                1:eight_seg[6:0]<= one;
                2:eight_seg[6:0]<= two;
                3:eight_seg[6:0]<= three;
                4:eight_seg[6:0]<= four;
                5:eight_seg[6:0]<= five;
                6:eight_seg[6:0]<= six;
                7:eight_seg[6:0]<= seven;
                8:eight_seg[6:0]<= eight;
                9:eight_seg[6:0]<= nine;
                10:eight_seg[6:0]<= a;
                11:eight_seg[6:0]<= b;
                12:eight_seg[6:0]<= c;
                13:eight_seg[6:0]<= d;
                14:eight_seg[6:0]<= e;
                15:eight_seg[6:0]<= f;
                default:eight_seg[6:0]<= nothing;
            endcase
        end

    if(flg%4==1)
        begin
            seg0<=1;seg1<=0;seg2<=1;seg3<=1; 
            eight_seg[7] <= dp_in[1];   
            case(data1)
                0:eight_seg[6:0]<= zero;
                1:eight_seg[6:0]<= one;
                2:eight_seg[6:0]<= two;
                3:eight_seg[6:0]<= three;
                4:eight_seg[6:0]<= four;
                5:eight_seg[6:0]<= five;
                6:eight_seg[6:0]<= six;
                7:eight_seg[6:0]<= seven;
                8:eight_seg[6:0]<= eight;
                9:eight_seg[6:0]<= nine;
                10:eight_seg[6:0]<= a;
                11:eight_seg[6:0]<= b;
                12:eight_seg[6:0]<= c;
                13:eight_seg[6:0]<= d;
                14:eight_seg[6:0]<= e;
                15:eight_seg[6:0]<= f;
                default:eight_seg[6:0]<= nothing;
            endcase
        end

    if(flg%4==2)
        begin
            seg0<=1;seg1<=1;seg2<=0;seg3<=1;    
            eight_seg[7] <= dp_in[2];
            case(data2)
                0:eight_seg[6:0]<= zero;
                1:eight_seg[6:0]<= one;
                2:eight_seg[6:0]<= two;
                3:eight_seg[6:0]<= three;
                4:eight_seg[6:0]<= four;
                5:eight_seg[6:0]<= five;
                6:eight_seg[6:0]<= six;
                7:eight_seg[6:0]<= seven;
                8:eight_seg[6:0]<= eight;
                9:eight_seg[6:0]<= nine;
                10:eight_seg[6:0]<= a;
                11:eight_seg[6:0]<= b;
                12:eight_seg[6:0]<= c;
                13:eight_seg[6:0]<= d;
                14:eight_seg[6:0]<= e;
                15:eight_seg[6:0]<= f;
                default:eight_seg[6:0]<= nothing;
            endcase
        end

    if(flg%4==3)
        begin
            seg0<=1;seg1<=1;seg2<=1;seg3<=0;  
            eight_seg[7] <= dp_in[3]; 
            case(data3)
                0:eight_seg[6:0]<= zero;
                1:eight_seg[6:0]<= one;
                2:eight_seg[6:0]<= two;
                3:eight_seg[6:0]<= three;
                4:eight_seg[6:0]<= four;
                5:eight_seg[6:0]<= five;
                6:eight_seg[6:0]<= six;
                7:eight_seg[6:0]<= seven;
                8:eight_seg[6:0]<= eight;
                9:eight_seg[6:0]<= nine;
                10:eight_seg[6:0]<= a;
                11:eight_seg[6:0]<= b;
                12:eight_seg[6:0]<= c;
                13:eight_seg[6:0]<= d;
                14:eight_seg[6:0]<= e;
                15:eight_seg[6:0]<= f;
                default:eight_seg[6:0]<= nothing;
            endcase
        end

    end
endmodule
