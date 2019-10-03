`timescale 1ns / 1ps
/*
Module name:  binary_image_etch.v
Description:  binary image etch.
              
Data:         2017/12/22
Engineer:     lipu
e-mail:       137194782@qq.com 
微信公众号：    FPGA开源工作室
*/


module linebuffer#(
       parameter IMG_WIDTH_DATA = 24,
       parameter IMG_WIDTH_LINE = 800,
	   parameter LINE_N         = 3
	   )
       (
       input                       clk,
       input                       reset_n,
       input                       de,
       input  [IMG_WIDTH_DATA-1:0] din,
	   output                      o_line_de,
       output [IMG_WIDTH_DATA-1:0] dout,
       output [IMG_WIDTH_DATA-1:0] dout_r0,
       output [IMG_WIDTH_DATA-1:0] dout_r1,
       output [IMG_WIDTH_DATA-1:0] dout_r2
       );

wire [IMG_WIDTH_DATA-1:0] dout_r [0:2];
reg        de_r [0:2];
wire       o_de [0:2];
reg  [IMG_WIDTH_DATA-1:0] line [0:2];  

assign dout    = dout_r[0];
assign dout_r0 = dout_r[0];
assign dout_r1 = dout_r[1];
assign dout_r2 = dout_r[2];

assign o_line_de =  de;  
       
generate
  begin:HDL1
    genvar i;
    for(i = 0; i < LINE_N; i = i + 1) begin: buffer_inst
      //line 1
      if(i == 0) begin:MAP0
        always @(*) begin
          de_r[i] <= de;
          line[i] <= din;
        end
      end
      //line 2 3.....
      if(~(i == 0)) begin:MAP1
        always @(*) begin
          de_r[i] <= o_de[i-1];
          line[i] <= dout_r[i-1];
        end
      end
    
line #( 
      .IMG_WIDTH_DATA(IMG_WIDTH_DATA),
      .IMG_WIDTH_LINE(IMG_WIDTH_LINE)
      )line_inst(
           .clk(clk),//pixel clock
           .reset_n(reset_n),
           .i_de(de_r[i]),
           .o_de(o_de[i]),
           .din(line[i]),
           .dout(dout_r[i])
           );
        end
     end
endgenerate

endmodule
