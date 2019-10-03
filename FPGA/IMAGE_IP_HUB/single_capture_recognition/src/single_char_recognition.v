`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/28 11:27:17
// Design Name: 
// Module Name: single_char_recognition
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


module single_char_recognition(
    input   wire            pixel_clk,
    input   wire            reset_n,

    input   wire    [2:0]   frame_cnt,

    input   wire    [23:0]  i_rgb,
    input   wire            i_hsync,
    input   wire            i_vsync,
    input   wire            i_de,

    input   wire    [11:0]  hcount,
    input   wire    [11:0]  vcount,
    
	   
	input   wire    [11:0]  hcount_l,
    input   wire    [11:0]  hcount_r,
    input   wire    [11:0]  vcount_l,
    input   wire    [11:0]  vcount_r,

    output  wire    [39:0]  char
    

    );

wire ds_o_hsync;
wire ds_o_vsync;
wire ds_o_de;
wire [23:0] ds_dout;	

capture_single U_capture_single(
       .pixelclk(pixel_clk),
	   .reset_n(reset_n),
       
  	   .i_rgb(i_rgb),
	   .i_hsync(i_hsync),
	   .i_vsync(i_vsync),
	   .i_de(i_de),
	   
	   .hcount(hcount),
       .vcount(vcount),
	   
	   .hcount_l(hcount_l),
       .hcount_r(hcount_r),
       .vcount_l(vcount_l),
       .vcount_r(vcount_r),
	   
       .o_rgb(ds_dout),
	   .o_hsync(ds_o_hsync),
	   .o_vsync(ds_o_vsync),                                                                                                  
	   .o_de(ds_o_de)                                                                                               
	   );
	   
wire dsp_o_hsync;
wire dsp_o_vsync;
wire dsp_o_de;
wire [23:0] dsp_dout;
wire         [39:0]            char1;
   
character_recognition U_character_recognition(
       .pixelclk(pixel_clk),
	   .reset_n(reset_n),
	   .frame_cnt(frame_cnt),

  	   .i_rgb(ds_dout),
	   .i_hsync(ds_o_hsync),
	   .i_vsync(ds_o_vsync),
	   .i_de(ds_o_de),
	   
	   .hcount(hcount),
       .vcount(vcount),
	   
	   .hcount_l(hcount_l),
       .hcount_r(hcount_r),
       .vcount_l(vcount_l),
       .vcount_r(vcount_r),
       .char(char)                                                                                               
	   );


endmodule
