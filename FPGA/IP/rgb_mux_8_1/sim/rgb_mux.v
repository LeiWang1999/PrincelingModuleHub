`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/08 21:04:05
// Design Name: 
// Module Name: rgb_mux
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


module rgb_mux(
        input       [23:0]      i_rgb_0,
        input       [23:0]      i_rgb_1,
        input       [23:0]      i_rgb_2,
        input       [23:0]      i_rgb_3,
        input       [23:0]      i_rgb_4,
        input       [23:0]      i_rgb_5,
        input       [23:0]      i_rgb_6,
        input       [23:0]      i_rgb_7,
        
        input       [ 2:0]          switch,

        output      [23:0]          o_rgb
    );

    reg         [23:0]      o_rgb_r;

    always @(*) begin
        case (switch)
            3'b000:
                o_rgb_r =   i_rgb_0;
            3'b001:
                o_rgb_r =   i_rgb_1;
            3'b010:
                o_rgb_r =   i_rgb_2;
            3'b011:
                o_rgb_r =   i_rgb_3;
            3'b100:
                o_rgb_r =   i_rgb_4;
            3'b101:
                o_rgb_r =   i_rgb_5;
            3'b110:
                o_rgb_r =   i_rgb_6;
            3'b111:
                o_rgb_r =   i_rgb_7; 
            default: 
                o_rgb_r =   i_rgb_0;
        endcase
    end

    assign  o_rgb   =   o_rgb_r;
endmodule
