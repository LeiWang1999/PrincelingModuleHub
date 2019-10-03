`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/24 18:18:44
// Design Name: 
// Module Name: binary2bcd
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

//这是一个使用Verilog HDL编写的带使能端的8-bit二进制转BCD码程序，具有占用资源少、移植性好、扩展方便的特点。   
module  binary2bcd #(
    parameter B_SIZE=12 //B_SIZE为二进制数所占的位数，可根据需要进行扩展 
)(
    input wire rst_n,
    input wire [B_SIZE-1 : 0] binary,
    output reg [B_SIZE+3 : 0] bcd
    );   //rst_n为使能端，binary为待转换的二进制数，bcd为转换后的BCD码      
				
   
reg  [B_SIZE-1:0] bin;   
reg  [B_SIZE+3:0] result;   //result的长度=bcd的长度 
 
 
  
always@(binary or rst_n)
   begin      
      bin= binary;     
	  result = 0;         
   if(rst_n == 0) 
	  bcd = 0;      
else    
	begin         
repeat(B_SIZE-1)//使用repeat语句进行循环计算      
   begin            
	result[0] = bin[B_SIZE-1];                     
   if(result[3:0] > 4)            
    result[3:0]=result[3:0]+ 4'd3;      
   if(result[7:4] > 4)            
    result[7:4]=result[7:4]+4'd3;  
   if(result[11:8] > 4)   	   
	result[11:8] = result[11:8]+4'd3; //扩展时应参照此三条if语句续写   
   if(result[15:12] > 4)   	   
	result[15:12]= result[15:12]+ 4'd3;  
	result=result<<1;
	bin=bin<<1; end         
	result[0]= bin[B_SIZE-1]; 
	bcd<=result;   
   end  
   end   
endmodule
