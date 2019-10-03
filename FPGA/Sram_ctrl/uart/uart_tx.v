`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/01/22 13:27:24
// Design Name: 
// Module Name: uart_tx
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


module uart_tx(
    input wire [7:0] data_o,
    output reg txd,
    input wire clk,
    input wire rst,
    input wire tx_trig
    );

    // tx_trig : 串口输入触发信号 高电平有效

    localparam  IDLE = 2'b00,
                SEND_START = 2'b01,
                SEND_DATA = 2'b10,
                SEND_END = 2'b11;
    reg [1:0] current_state,next_state;
    reg [4:0] count;
    reg [7:0] data_o_tmp;
   // 状态机
    always @(posedge clk) begin
        current_state <= next_state;
    end


    always @(*) begin
        next_state = current_state;
        case (current_state)
          IDLE: if(tx_trig) next_state = SEND_START; 
          SEND_START:   next_state = SEND_DATA;
          SEND_DATA:    if (count == 7) begin
            next_state = SEND_END;
          end
          SEND_END:  if (tx_trig)   next_state = SEND_START;
          default: next_state = IDLE;
        endcase
    end

    always @(posedge clk) begin
      if (current_state == SEND_DATA) begin
        count <= count + 1;
      end
      else if (current_state==IDLE || current_state == SEND_END)
        count <= 0;
    end

    always @(posedge clk) begin
      if (current_state == SEND_START) begin
        data_o_tmp <= data_o;
      end
      else if (current_state == SEND_DATA)
        data_o_tmp[6:0] <= data_o_tmp[7:1]; //将数据右移，依次送往最低位
    end

    always @(posedge clk) begin
      if (current_state == SEND_START) begin
        txd <= 0;
      end
      else if (current_state == SEND_DATA) begin
        txd <= data_o_tmp[0];
      end
      else if(current_state == SEND_END)
        txd <= 1;
    end


endmodule
