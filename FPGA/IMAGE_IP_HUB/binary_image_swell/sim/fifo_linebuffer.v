`timescale 1ps/1ps
module fifo_linebuffer#(
       parameter IMG_WIDTH_DATA = 24,
	   parameter IMG_WIDTH_LINE = 800
       )(
       input clk,
	   input reset_n,
	   input we,
	   input rd,
	   input  [IMG_WIDTH_DATA-1:0] din,
       output [IMG_WIDTH_DATA-1:0] dout	 
	   );

reg  [10:0]               waddr;
reg  [10:0]               raddr;

always @(posedge clk or negedge reset_n) begin
  if(!reset_n) begin
    waddr <= 11'b0;
	raddr <= 11'b0;
  end
  else begin
    if(we == 1'b1)
	  if(waddr == IMG_WIDTH_LINE -1)
	    waddr <= 11'b0;
      else
        waddr <= waddr + 11'b1;
    
    if(rd == 1'b1)
	  if(raddr == IMG_WIDTH_LINE -1)
	    raddr <= 11'b0;
      else
        raddr <= raddr + 11'b1;	
  end
end

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
img_ram U_img_ram (
  .clka(clk),    // input wire clka
  .wea(we),      // input wire [0 : 0] wea
  .addra(waddr),  // input wire [10 : 0] addra
  .dina(din),    // input wire [23 : 0] dina
  .clkb(clk),    // input wire clkb
  .addrb(raddr),  // input wire [10 : 0] addrb
  .doutb(dout)  // output wire [23 : 0] doutb
);
	   
endmodule