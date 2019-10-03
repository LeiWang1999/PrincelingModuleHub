// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2.1 (win64) Build 2288692 Thu Jul 26 18:24:02 MDT 2018
// Date        : Sun May 19 15:08:13 2019
// Host        : LAPTOP-LTO7EJI2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub d:/EELab/FPGA/PrincelingModuleHub/IP/v_ram/v_ram_stub.v
// Design      : v_ram
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2018.2.1" *)
module v_ram(clka, wea, addra, dina, clkb, enb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[10:0],dina[0:0],clkb,enb,addrb[10:0],doutb[0:0]" */;
  input clka;
  input [0:0]wea;
  input [10:0]addra;
  input [0:0]dina;
  input clkb;
  input enb;
  input [10:0]addrb;
  output [0:0]doutb;
endmodule
