
`timescale 1ns/1ps
module fifo_y(
       input clock,
	   input reset_n,
	   input data,
	   input rdreq,
	   input wrreq,
	   output empty,
	   output full,
	   output q,
	   output usedw
	   );

reg  [10:0]               waddr;
reg  [10:0]               raddr;

always @(posedge clock or negedge reset_n) begin
  if(!reset_n) begin
    waddr <= 11'b0;
	raddr <= 11'b0;
  end
  else begin
    if(wrreq == 1'b1)
	  if(waddr == 599)
	    waddr <= 11'b0;
      else
        waddr <= waddr + 11'b1;
    
    if(rdreq == 1'b1)
	  if(raddr == 599)
	    raddr <= 11'b0;
      else
        raddr <= raddr + 11'b1;	
  end
end
	   
//image line buffer ram

digital_ram fifo_y_ram (
  .clka(clock),    // input wire clka
  .wea(wrreq),      // input wire [0 : 0] wea
  .addra(waddr),  // input wire [10 : 0] addra
  .dina(data),    // input wire [0 : 0] dina
  .clkb(clock),    // input wire clkb
  .addrb(raddr),  // input wire [10 : 0] addrb
  .doutb(q)  // output wire [0 : 0] doutb
);

endmodule
