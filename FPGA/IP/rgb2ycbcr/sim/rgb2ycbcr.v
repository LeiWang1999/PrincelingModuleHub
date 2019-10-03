`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/11 18:35:18
// Design Name: 
// Module Name: rgb2ycbcr
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


/* 
    RGB转YUV算法
	计算公式：	Y  =  0.183R + 0.614G + 0.062B + 16;
							CB = -0.101R - 0.338G + 0.439B + 128; 
							CR =  0.439R - 0.399G - 0.040B + 128;
	其中，时序在计算过程中完全没有用到
	输入到输出有三个clock的时延。
	第一级流水线计算所有乘法；
	第二级流水线计算所有加法，把正的和负的分开进行加法；
	第三级流水线计算最终的和，若为负数取0；
	仿真通过

	Y 亮度 Cb 蓝色 Cr 红色

*/
`timescale 1ns/1ps
module	rgb2ycbcr(
input						     clk,

input          [23:0]            i_rgb,
input                            i_h_sync,
input                            i_v_sync,
input                            i_data_en,

output            [23:0]         o_rgb,
output            [23:0]         o_ycbcr,
output            [23:0]         o_gray,
output                           o_h_sync,
output                           o_v_sync,                                                                                                  
output                           o_data_en                                                                                                
						);

/***************************************parameters*******************************************/
//multiply 256
parameter	para_0183_10b = 10'd47;    //0.183 定点数
parameter	para_0614_10b = 10'd157;
parameter	para_0062_10b = 10'd16;
parameter	para_0101_10b = 10'd26;
parameter	para_0338_10b = 10'd86;
parameter	para_0439_10b = 10'd112;
parameter	para_0399_10b = 10'd102;
parameter	para_0040_10b = 10'd10;
parameter	para_16_18b = 18'd4096;
parameter	para_128_18b = 18'd32768;
/********************************************************************************************/
wire				[7 : 0]		   i_r_8b;
wire                [7 : 0]        i_g_8b;
wire                [7 : 0]        i_b_8b;
                        
wire			    [7 : 0]		    o_y_8b;
wire                [7 : 0]         o_cb_8b;
wire                [7 : 0]         o_cr_8b;

reg [23:0] o_rgb_delay_1;
reg [23:0] o_rgb_delay_2;
reg [23:0] o_rgb_delay_3;


assign i_r_8b = i_rgb[23:16];
assign i_g_8b = i_rgb[15:8];
assign i_b_8b = i_rgb[7:0];

assign o_ycbcr = {o_y_8b,o_cb_8b,o_cr_8b};
assign o_gray  = {o_y_8b,o_y_8b,o_y_8b};
assign o_rgb   = o_rgb_delay_3;
/***************************************signals**********************************************/
wire				sign_cb;
wire				sign_cr;
reg[17: 0]	mult_r_for_y_18b;
reg[17: 0]	mult_r_for_cb_18b;
reg[17: 0]	mult_r_for_cr_18b;

reg[17: 0]	mult_g_for_y_18b;
reg[17: 0]	mult_g_for_cb_18b;
reg[17: 0]	mult_g_for_cr_18b;

reg[17: 0]	mult_b_for_y_18b;
reg[17: 0]	mult_b_for_cb_18b;
reg[17: 0]	mult_b_for_cr_18b;

reg[17: 0]	add_y_0_18b;
reg[17: 0]	add_cb_0_18b;
reg[17: 0]	add_cr_0_18b;

reg[17: 0]	add_y_1_18b;
reg[17: 0]	add_cb_1_18b;
reg[17: 0]	add_cr_1_18b;

reg[17: 0] 	result_y_18b;
reg[17: 0]	result_cb_18b;
reg[17: 0]	result_cr_18b;

reg[9:0] y_tmp;
reg[9:0] cb_tmp;
reg[9:0] cr_tmp;

reg					i_h_sync_delay_1;
reg					i_v_sync_delay_1;
reg					i_data_en_delay_1;

reg					i_h_sync_delay_2;
reg					i_v_sync_delay_2;
reg					i_data_en_delay_2;

reg					i_h_sync_delay_3;
reg					i_v_sync_delay_3;
reg					i_data_en_delay_3;
/********************************************************************************************/

/***************************************initial**********************************************/
initial
begin
	mult_r_for_y_18b <= 18'd0;
	mult_r_for_cb_18b <= 18'd0;
	mult_r_for_cr_18b <= 18'd0;
	
	mult_g_for_y_18b <= 18'd0;
	mult_g_for_cb_18b <= 18'd0;
	mult_g_for_cr_18b <= 18'd0;
	
	mult_b_for_y_18b <= 18'd0;
	mult_g_for_cb_18b <= 18'd0;
	mult_b_for_cr_18b <= 18'd0;

	
	add_y_0_18b <= 18'd0;
	add_cb_0_18b <= 18'd0;
	add_cr_0_18b <= 18'd0;
	
	add_y_1_18b <= 18'd0;
	add_cb_1_18b <= 18'd0;
	add_cr_1_18b <= 18'd0;
	
	result_y_18b <= 18'd0;
	result_cb_18b <= 18'd0;
	result_cr_18b <= 18'd0;
	
	i_h_sync_delay_1 <= 1'd0;
	i_v_sync_delay_1 <= 1'd0;
	i_data_en_delay_1 <= 1'd0;
	
	i_h_sync_delay_2 <= 1'd0;
	i_v_sync_delay_2 <= 1'd0;
	i_data_en_delay_2 <= 1'd0;
                                          	
end 
/********************************************************************************************/
    
/***************************************arithmetic*******************************************/
//LV1 pipeline : mult
always @ (posedge	clk)
begin
	mult_r_for_y_18b <= i_r_8b * para_0183_10b;
	mult_r_for_cb_18b <= i_r_8b * para_0101_10b;
	mult_r_for_cr_18b <= i_r_8b * para_0439_10b;
end

always @ (posedge	clk)
begin
	mult_g_for_y_18b <= i_g_8b * para_0614_10b;
	mult_g_for_cb_18b <= i_g_8b * para_0338_10b;
	mult_g_for_cr_18b <= i_g_8b * para_0399_10b;
end

always @ (posedge	clk)
begin
	mult_b_for_y_18b <= i_b_8b * para_0062_10b;
	mult_b_for_cb_18b <= i_b_8b * para_0439_10b;
	mult_b_for_cr_18b <= i_b_8b * para_0040_10b;
end
//LV2 pipeline : add
always @ (posedge	clk)
begin
	add_y_0_18b <= mult_r_for_y_18b + mult_g_for_y_18b;
	add_y_1_18b <= mult_b_for_y_18b + para_16_18b;
	
	add_cb_0_18b <= mult_b_for_cb_18b + para_128_18b;
	add_cb_1_18b <= mult_r_for_cb_18b + mult_g_for_cb_18b;
	
	add_cr_0_18b <= mult_r_for_cr_18b + para_128_18b;
	add_cr_1_18b <= mult_g_for_cr_18b + mult_b_for_cr_18b;
end
//LV3 pipeline : y + cb + cr

assign	sign_cb = (add_cb_0_18b >= add_cb_1_18b);
assign	sign_cr = (add_cr_0_18b >= add_cr_1_18b);
always @ (posedge	clk)
begin
	result_y_18b <= add_y_0_18b + add_y_1_18b;
	result_cb_18b <= sign_cb ? (add_cb_0_18b - add_cb_1_18b) : 18'd0;
	result_cr_18b <= sign_cr ? (add_cr_0_18b - add_cr_1_18b) : 18'd0;
end

always @ (posedge	clk)
begin
	y_tmp <= result_y_18b[17:8] + {9'd0,result_y_18b[7]};
	cb_tmp <= result_cb_18b[17:8] + {9'd0,result_cb_18b[7]};
	cr_tmp <= result_cr_18b[17:8] + {9'd0,result_cr_18b[7]};
end

//output
assign	o_y_8b 	= (y_tmp[9:8] == 2'b00) ? y_tmp[7 : 0] : 8'hFF;
assign	o_cb_8b 	= (cb_tmp[9:8] == 2'b00) ? cb_tmp[7 : 0] : 8'hFF;
assign	o_cr_8b 	= (cr_tmp[9:8] == 2'b00) ? cr_tmp[7 : 0] : 8'hFF;
/********************************************************************************************/

/***************************************timing***********************************************/
always @ (posedge	clk)
begin
	i_h_sync_delay_1 <= i_h_sync;
	i_v_sync_delay_1 <= i_v_sync;
	i_data_en_delay_1 <= i_data_en;
	o_rgb_delay_1    <= i_rgb;
	
	i_h_sync_delay_2 <= i_h_sync_delay_1;
	i_v_sync_delay_2 <= i_v_sync_delay_1;
	i_data_en_delay_2 <= i_data_en_delay_1;
	o_rgb_delay_2    <= o_rgb_delay_1;
	
	i_h_sync_delay_3 <= i_h_sync_delay_2;
	i_v_sync_delay_3 <= i_v_sync_delay_2;
	i_data_en_delay_3 <= i_data_en_delay_2;
	o_rgb_delay_3    <= o_rgb_delay_2;
end	
//--------------------------------------
//timing
//--------------------------------------	
assign	o_h_sync = i_h_sync_delay_3;
assign	o_v_sync = i_v_sync_delay_3;
assign 	o_data_en = i_data_en_delay_3;

/********************************************************************************************/
endmodule 
