`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/22 16:49:32
// Design Name: 
// Module Name: top
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



module top #(
    parameter   ADDR_WIDTH  =   19,
    parameter   DATA_WIDTH  =   16
)(
    // system   signal
    input       wire        clk,
    input       wire        rst_n,
    
    // uart     signal
    input       wire        uart_rx,
    output      wire        uart_tx,

    //  Sram signal
    output      wire    [ADDR_WIDTH-1:0]        sram_addr,
    inout       wire    [DATA_WIDTH-1:0]        sram_data,
    output      wire                            sram_ce_n,      //  chip_enable
    output      wire                            sram_lb_n,      //  low_8_byte_enable
    output      wire                            sram_oe_n,      //  output_enable
    output      wire                            sram_ub_n,      //  high_8_byte_enable
    output      wire                            sram_we_n,      //  write_enable

    // other
    input       wire        button_write,
    input       wire        button_read,
    input       wire        button
    );
/*
        Paramerter  Define
*/
    localparam Baud_Rate = 9600;
    localparam div_num = 'd100_000_000 / Baud_Rate;

    wire button_write_true;   // 消抖后button
    wire button_write_pos;    // button上升沿
    wire button_read_true;
    wire button_read_pos;
    wire button_true;
    wire button_pos;
    wire    [DATA_WIDTH-1:0]    data_in     =  'h78;
    wire    [DATA_WIDTH-1:0]    data_out;
    reg     [DATA_WIDTH-1:0]    data_in_r;
    reg     [DATA_WIDTH-1:0]    data_out_r;
    wire    [ADDR_WIDTH-1:0]    addr_in     =  'hfac;
/*
        Main Code
*/




    //  9600时钟信号分频
    counter_mod_m #(.M(div_num+1), .N(20)) counter_mod_9600(
        .clk(clk),
        .m_out(clk_9600),
        .rst_n(rst_n)
    );

    // 消抖
    debounce button_write_debouce(
        .clk(clk),
        .rst_n(rst_n),
        .key_in(button_write),
        .key_out(button_write_true)
    );

    debounce button_read_debouce(
        .clk(clk),
        .rst_n(rst_n),
        .key_in(button_read),
        .key_out(button_read_true)
    );

    debounce button_debouce(
        .clk(clk),
        .rst_n(rst_n),
        .key_in(button),
        .key_out(button_true)
    );



    // 上升沿捕获
    edge_detect button_write_posedge(
        .clk(clk),
        .rst_n(rst_n),
        .signal(button_write_true),
        .pos_tick(button_write_pos)
    );

    edge_detect button_read_posedge(
        .clk(clk),
        .rst_n(rst_n),
        .signal(button_read_true),
        .pos_tick(button_read_pos)
    );
    edge_detect button_posedge(
        .clk(clk_9600),
        .rst_n(rst_n),
        .signal(button_true),
        .pos_tick(button_pos)
    );

    // uart_tx
    uart_tx U1_uart_tx(
        .clk(clk_9600),
        .txd(uart_tx),
        .rst(1),
        .data_o(data_out),
        .tx_trig(button_pos)
    );

    sram_ctr #(
    .ADDR_WIDTH ( ADDR_WIDTH ),
    .DATA_WIDTH ( DATA_WIDTH ))
 u_sram_ctr (
        .clk                     ( clk                          ),
        .rst_n                   ( rst_n                        ),
        .write_tick              ( button_write_pos             ),
        .read_tick               ( button_read_pos              ),
        .data_in                 ( data_in     [DATA_WIDTH-1:0] ),
        .addr_in                 ( addr_in     [ADDR_WIDTH-1:0] ),

        .sram_addr               ( sram_addr   [ADDR_WIDTH-1:0] ),
        .sram_ce_n               ( sram_ce_n                    ),
        .sram_lb_n               ( sram_lb_n                    ),
        .sram_oe_n               ( sram_oe_n                    ),
        .sram_ub_n               ( sram_ub_n                    ),
        .sram_we_n               ( sram_we_n                    ),
        .data_out                ( data_out    [DATA_WIDTH-1:0] ),

        .sram_data               ( sram_data   [DATA_WIDTH-1:0] )
);

    
    // 一次读写十六位数据
    assign      sram_ub_n  = 1'b0;
    assign      sram_lb_n  = 1'b0;
    // 只有一个芯片，所以片选总有效 
    assign      sram_ce_n  = 1'b0;

    
endmodule
