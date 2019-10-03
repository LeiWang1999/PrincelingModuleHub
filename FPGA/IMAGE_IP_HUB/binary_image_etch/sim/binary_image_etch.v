/*
Module name:  binary_image_etch.v
Description:  binary image etch.
              
Data:         2017/12/22
Engineer:     lipu
e-mail:       137194782@qq.com 
微信公众号：    FPGA开源工作室
*/
`timescale 1ns/1ps

module binary_image_etch#(
       parameter IMG_WIDTH_DATA = 24,
       parameter IMG_WIDTH_LINE = 640,
       parameter LINE_N         = 3
        )(
    	input             clk,  //pixel clk
		 	input             rst_n, 
			input       		[IMG_WIDTH_DATA-1:0]    data_in,
		 	input             data_in_en,
			output      reg	[IMG_WIDTH_DATA-1:0]    data_out,
			output            data_out_en
		 );
		 
wire [IMG_WIDTH_DATA-1:0] line0;
wire [IMG_WIDTH_DATA-1:0] line1;
wire [IMG_WIDTH_DATA-1:0] line2;

reg [IMG_WIDTH_DATA-1:0] line0_data0;
reg [IMG_WIDTH_DATA-1:0] line0_data1;
reg [IMG_WIDTH_DATA-1:0] line0_data2;

reg [IMG_WIDTH_DATA-1:0] line1_data0;
reg [IMG_WIDTH_DATA-1:0] line1_data1;
reg [IMG_WIDTH_DATA-1:0] line1_data2;

reg [IMG_WIDTH_DATA-1:0] line2_data0;
reg [IMG_WIDTH_DATA-1:0] line2_data1;
reg [IMG_WIDTH_DATA-1:0] line2_data2;

reg        data_out_en0;
reg        data_out_en1;
reg        data_out_en2;

wire	[18:0]  result_data;
wire            o_de;

assign data_out_en = o_de;
		  		  

linebuffer#(
       .IMG_WIDTH_DATA(IMG_WIDTH_DATA),
       .IMG_WIDTH_LINE(IMG_WIDTH_LINE),
	   .LINE_N(LINE_N)
	   )U_LINE3X3(
       .clk(clk),
       .reset_n(rst_n),
       .de(data_in_en),
       .din(data_in),
	   .o_line_de(o_de),
       .dout(),
       .dout_r0(line0),
       .dout_r1(line1),
       .dout_r2(line2)
       );
//----------------------------------------------------
// Form an image matrix of three multiplied by three
//----------------------------------------------------
always @(posedge clk or negedge rst_n) begin
  if(!rst_n) begin
    line0_data0 <= 0;
	 line0_data1 <= 0;
	 line0_data2 <= 0;
	 
	 line1_data0 <= 0;
	 line1_data1 <= 0;
	 line1_data2 <= 0;
	 
	 line2_data0 <= 0;
	 line2_data1 <= 0;
	 line2_data2 <= 0;
	 
	 data_out_en0 <= 1'b0;
	 data_out_en1 <= 1'b0;
	 data_out_en2 <= 1'b0;
  end
  else if(data_in_en) begin
    line0_data0 <= data_in;
	 line0_data1 <= line0_data0;
	 line0_data2 <= line0_data1;
	 
	 line1_data0 <= line0;
	 line1_data1 <= line1_data0;
	 line1_data2 <= line1_data1;
	 
	 line2_data0 <= line1;
	 line2_data1 <= line2_data0;
	 line2_data2 <= line2_data1;

	 data_out_en0 <= data_in_en;
	 data_out_en1 <= data_out_en0;
	 data_out_en2 <= data_out_en1;	 
  end
end

//-------------------------------------------
// line0_data0   line0_data1   line0_data2
// line1_data0   line1_data1   line1_data2
// line2_data0   line2_data1   line2_data2
//-------------------------------------------

// assign data_out = ((line0_data0 == 0) && (line0_data1 == 0) && (line0_data2 == 0) && (line1_data0 == 0) && (line1_data1 == 0) && (line1_data2 == 0) && (line2_data0 == 0) && (line2_data1 == 0) && (line2_data2 == 0))?24'h000000:24'hffffff;



always @(posedge clk or negedge rst_n) begin
  if(!rst_n)
    data_out <= 24'h000000;
  else if(data_out_en0)
    if((line0_data0 == 24'h00000) && (line0_data1 == 24'h00000)&& (line1_data0 == 24'h00000) && (line1_data1 == 24'h00000))
      data_out <= line0_data0;
    else if((line0_data0 == 24'hffffff) && (line0_data1 == 24'hffffff)  && (line1_data0 == 24'hffffff) && (line1_data1 == 24'hffffff) )
      data_out <= line0_data0;
    else 
      data_out <= 24'hffffff;	 
end

endmodule 
