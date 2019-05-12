// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2.1 (win64) Build 2288692 Thu Jul 26 18:24:02 MDT 2018
// Date        : Fri Apr 19 14:39:58 2019
// Host        : LAPTOP-LTO7EJI2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub d:/EELab/FPGA/PrincelingModuleHub/IP/pll/pll_stub.v
// Design      : pll
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module pll(clk_vga, reset, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_vga,reset,locked,clk_in1" */;
  output clk_vga;
  input reset;
  output locked;
  input clk_in1;
endmodule
