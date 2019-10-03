//~ `New testbench
`timescale  1ns / 1ps

module tb_clk_div;

// clk_div Parameters
parameter PERIOD  = 10;


// clk_div Inputs
reg   clk                                  = 0 ;

// clk_div Outputs
wire  clk_out                              ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

clk_div  u_clk_div (
    .clk                     ( clk       ),

    .clk_out                 ( clk_out   )
);

initial
begin

    $finish;
end

endmodule
