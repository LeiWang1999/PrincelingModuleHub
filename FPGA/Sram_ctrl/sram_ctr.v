`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/21 17:23:05
// Design Name: 
// Module Name: sram_ctr
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


module sram_ctr #(
    parameter   ADDR_WIDTH  =   19,
    parameter   DATA_WIDTH  =   16
)(
    // system   signal
    input       wire        clk,
    input       wire        rst_n,

    //  Sram    signal
    output      wire    [ADDR_WIDTH-1:0]        sram_addr,
    inout       wire    [DATA_WIDTH-1:0]        sram_data,
    output      wire                            sram_ce_n,      //  chip_enable
    output      wire                            sram_lb_n,      //  low_8_byte_enable
    output      wire                            sram_oe_n,      //  output_enable
    output      wire                            sram_ub_n,      //  high_8_byte_enable
    output      wire                            sram_we_n,      //  write_enable

    // input    signal
    input       wire                                write_tick,
    input       wire                                read_tick,
    input       wire        [DATA_WIDTH-1:0]        data_in,
    output      wire        [DATA_WIDTH-1:0]        data_out,
    input       wire        [ADDR_WIDTH-1:0]        addr_in
    );

/*
        Parameter   Define
*/
    localparam  IDLE        =   'b0000,
                // read signal
                READ_SEND_ADDR  =   'b0001,
                READ_INIT       =   'b0010,
                READ            =   'b0011,
                READ_END        =   'b0100,
                // write signal
                WRITE_SEND_ADDR =   'b0101,
                WRITE_INIT      =   'b0110,
                WRITE           =   'b0111,
                WRITE_END       =   'b1000;

    reg     [DATA_WIDTH-1:0]        sram_data_r;
    reg     [ADDR_WIDTH-1:0]        sram_addr_r;
    reg                             sram_we_n_r;
    reg                             sram_oe_n_r;
    reg     [DATA_WIDTH-1:0]        data_out_r;

    reg     [3:0]   current_state;
    reg     [3:0]   next_state;

/*
        Main    Code
*/

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= IDLE;
        end
        else    begin
            current_state <= next_state;
        end
    end

    // 状态转换

    always @(*) begin
        next_state = current_state;
        case (current_state)
            IDLE:   
                begin
                    if(write_tick) next_state = WRITE_SEND_ADDR;
                    else if (read_tick) next_state = READ_SEND_ADDR;
                end
            WRITE_SEND_ADDR:
                begin
                    next_state = WRITE_INIT;
                end
            WRITE_INIT:
                begin
                    next_state = WRITE;
                end
            WRITE:
                begin
                    next_state = WRITE_END;
                end
            WRITE_END:
                begin
                    next_state = IDLE;
                end
            READ_SEND_ADDR:
                begin
                    next_state = READ_INIT;
                end
            READ_INIT:
                begin
                    next_state = READ;
                end
            READ:
                begin
                    next_state = READ_END;
                end
            READ_END:
                begin
                    next_state = IDLE;
                end
        default: next_state = IDLE;
        endcase
    end

    //  sram_addr
    always @(*) begin
        if(!rst_n)
            sram_addr_r = 'hz;
        else if (current_state == READ_SEND_ADDR || current_state == WRITE_SEND_ADDR) begin
            sram_addr_r = addr_in;
        end
        else    sram_addr_r = sram_addr;
    end

    //  sram_we_n
    always @(*) begin
        if(current_state == IDLE) begin
            sram_we_n_r = 'b1;
        end
        else if(current_state == WRITE_INIT) begin
            sram_we_n_r = 'b0;
        end
        else if(current_state == READ_INIT) begin
            sram_we_n_r = 'b1;
        end
    end

    //  sram_oe_n
    always @(*) begin
        if (current_state == IDLE) begin
            sram_oe_n_r = 'b1;
        end
        else if (current_state == WRITE_SEND_ADDR) begin
            sram_oe_n_r = 'b1;
        end
        else if (current_state == READ_SEND_ADDR) begin
            sram_oe_n_r = 'b0;
        end
        else if (current_state == READ_END) begin
            sram_oe_n_r = 'b1;
        end
    end


    //  sram_data
    always @(*) begin
        if (current_state == WRITE) begin
            sram_data_r = data_in;
        end
    end

    //  data_out
    always @(*) begin
        if (current_state == READ) begin
            data_out_r = sram_data;
        end
    end

    assign  sram_data = (sram_oe_n == 'b1)? sram_data_r:'hz;
    assign  sram_we_n = sram_we_n_r;
    assign  sram_oe_n = sram_oe_n_r;
    assign  sram_addr = sram_addr_r;

    assign  data_out  = data_out_r;

    // 一次读写十六位数据
    assign      sram_ub_n  = 1'b0;
    assign      sram_lb_n  = 1'b0;
    // 只有一个芯片，所以片选总有效 
    assign      sram_ce_n  = 1'b0;

endmodule
