`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/01/22 13:27:24
// Design Name: 
// Module Name: uart_rx
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


module uart_rx(
    input wire clk,
    input wire rxd,
    output wire receive_ack,
    output reg [7:0] data_i
    );

    //----------------receive_ack will be set once receive a 8bit data 


    // 串口接受状态机
    localparam  IDLE=2'b00,             //等待
                RECEIVE = 2'b01,        //接受
                RECEIVE_END = 3'b10,    //接收完成
                Date_Size = 8; //接收数据的大小
    
    reg [1:0] current_state, next_state;
    reg [2:0] count;
    always @(posedge clk) begin
        current_state <= next_state;
    end

    //状态转换
    always @(*) begin
      next_state = current_state;
      case (current_state)
        IDLE: if(!rxd)  next_state = RECEIVE;          // 0 为起始位
        RECEIVE: if(count==Date_Size-1) next_state = RECEIVE_END; // 开始接收数据
        RECEIVE_END:  next_state = IDLE;   // 接收完毕
        default: next_state = IDLE;
      endcase
    end

    // 接收数据计数器
    always @(posedge clk) begin
      if (current_state == RECEIVE) begin
        count <= count + 1;
      end
      else if (current_state == IDLE || current_state == RECEIVE_END) begin
        count <= 0;
      end
    end

    always @(posedge clk) begin
      if (current_state == RECEIVE) begin
        data_i[6:0] <= data_i[7:1];
        data_i[7] <= rxd;
      end
    end

    assign receive_ack = (current_state == RECEIVE_END)?1:0;   //------------When receive data done. receive_ack set.

endmodule
