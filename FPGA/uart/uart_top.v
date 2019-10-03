`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/01/22 13:25:01
// Design Name: 
// Module Name: uart_top
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


module uart_top(
    input wire rxd,
    input wire clk,
    output wire txd,
    output wire [3:0] test
    );

    localparam Baud_Rate = 9600;
    localparam div_num = 'd100_000_000 / Baud_Rate;

    wire clk_9600;        
    wire receive_ack;
    wire [7:0] data;

    //  9600时钟信号分频
    counter_mod_m #(.M(div_num+1), .N(20)) counter_mod_9600(
        .clk(clk),
        .m_out(clk_9600),
        .rst_n(1)
    );

/*    clk_div clk_div(
        .clk(clk),
        .clk_out(clk_9600)
    );
*/
    uart_tx uart_tx(
        .clk(clk_9600),
        .txd(txd),
        .data_o(data),
        .receive_ack(receive_ack)
    );
    // receive_ack : whick mean............

    uart_rx uart_rx(
        .clk(clk_9600),
        .rxd(rxd),
        .data_i(data),
        .receive_ack(receive_ack)
    );
    
    assign test[0] = clk_9600;
    assign test[1] = receive_ack;
    assign test[2] = txd;
    assign test[3] = rxd;

endmodule
