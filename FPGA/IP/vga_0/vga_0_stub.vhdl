-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2.1 (win64) Build 2288692 Thu Jul 26 18:24:02 MDT 2018
-- Date        : Sun Mar 17 19:25:24 2019
-- Host        : LAPTOP-LTO7EJI2 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               D:/EELab/FPGA/Digital-Design-Lab/Chapter_12/Digital_camera/digital_camera.srcs/sources_1/ip/vga_0/vga_0_stub.vhdl
-- Design      : vga_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vga_0 is
  Port ( 
    pclk : in STD_LOGIC;
    reset : in STD_LOGIC;
    hsync : out STD_LOGIC;
    vsync : out STD_LOGIC;
    valid : out STD_LOGIC;
    h_cnt : out STD_LOGIC_VECTOR ( 10 downto 0 );
    v_cnt : out STD_LOGIC_VECTOR ( 9 downto 0 )
  );

end vga_0;

architecture stub of vga_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "pclk,reset,hsync,vsync,valid,h_cnt[10:0],v_cnt[9:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "vga,Vivado 2018.2.1";
begin
end;
