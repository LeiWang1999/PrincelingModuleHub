
`timescale 1ns / 1ps

module line#(
       parameter IMG_WIDTH_DATA = 24,
       parameter IMG_WIDTH_LINE = 800
       )(
       input         clk,//pixel clock
       input         reset_n,
       input         i_de,
       output        o_de,
       input  [IMG_WIDTH_DATA-1:0]  din,
       output [IMG_WIDTH_DATA-1:0]  dout
       );

   
reg [10:0] cnt;
wire rd_en;

always @(posedge clk or negedge reset_n) begin
  if(!reset_n)
    cnt <= 10'd0;
  else if(cnt == IMG_WIDTH_LINE-1)
    cnt <= IMG_WIDTH_LINE-1;
  else if(i_de)
    cnt <= cnt + 10'd1;
  else
    cnt <= cnt;
end

assign rd_en = ((cnt == IMG_WIDTH_LINE-1) && (i_de == 1'b1)) ? 1'b1:1'b0;
assign o_de = rd_en;
       
fifo_linebuffer#(
       .IMG_WIDTH_DATA(IMG_WIDTH_DATA),
	   .IMG_WIDTH_LINE(IMG_WIDTH_LINE)
       )fifo_linebuffer(
       .clk(clk),
	   .reset_n(reset_n),
	   .we(i_de),
	   .rd(rd_en),
	   .din(din),
       .dout(dout)	 
	   );

endmodule
