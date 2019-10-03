-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2.1 (win64) Build 2288692 Thu Jul 26 18:24:02 MDT 2018
-- Date        : Sun Mar 17 19:25:24 2019
-- Host        : LAPTOP-LTO7EJI2 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               D:/EELab/FPGA/Digital-Design-Lab/Chapter_12/Digital_camera/digital_camera.srcs/sources_1/ip/vga_0/vga_0_sim_netlist.vhdl
-- Design      : vga_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity vga_0_vga is
  port (
    h_cnt : out STD_LOGIC_VECTOR ( 9 downto 0 );
    valid : out STD_LOGIC;
    v_cnt : out STD_LOGIC_VECTOR ( 8 downto 0 );
    hsync : out STD_LOGIC;
    vsync : out STD_LOGIC;
    pclk : in STD_LOGIC;
    reset : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of vga_0_vga : entity is "vga";
end vga_0_vga;

architecture STRUCTURE of vga_0_vga is
  signal hsync_i_i_1_n_0 : STD_LOGIC;
  signal hsync_i_i_2_n_0 : STD_LOGIC;
  signal hsync_i_i_3_n_0 : STD_LOGIC;
  signal hsync_i_i_4_n_0 : STD_LOGIC;
  signal hsync_i_i_5_n_0 : STD_LOGIC;
  signal \line_cnt[0]_i_1_n_0\ : STD_LOGIC;
  signal \line_cnt[10]_i_1_n_0\ : STD_LOGIC;
  signal \line_cnt[10]_i_2_n_0\ : STD_LOGIC;
  signal \line_cnt[10]_i_4_n_0\ : STD_LOGIC;
  signal \line_cnt[10]_i_5_n_0\ : STD_LOGIC;
  signal \line_cnt_reg__0\ : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal p_0_in : STD_LOGIC_VECTOR ( 10 downto 1 );
  signal \p_0_in__0\ : STD_LOGIC_VECTOR ( 10 downto 1 );
  signal \pixel_cnt[0]_i_1_n_0\ : STD_LOGIC;
  signal \pixel_cnt[10]_i_1_n_0\ : STD_LOGIC;
  signal \pixel_cnt[10]_i_3_n_0\ : STD_LOGIC;
  signal \pixel_cnt[2]_i_1_n_0\ : STD_LOGIC;
  signal \pixel_cnt[3]_i_1_n_0\ : STD_LOGIC;
  signal \pixel_cnt[4]_i_1_n_0\ : STD_LOGIC;
  signal \pixel_cnt_reg__0\ : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal valid_INST_0_i_1_n_0 : STD_LOGIC;
  signal valid_INST_0_i_2_n_0 : STD_LOGIC;
  signal vsync_i_i_1_n_0 : STD_LOGIC;
  signal vsync_i_i_2_n_0 : STD_LOGIC;
  signal vsync_i_i_3_n_0 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \h_cnt[0]_INST_0\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \h_cnt[1]_INST_0\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \h_cnt[2]_INST_0\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \h_cnt[3]_INST_0\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \h_cnt[5]_INST_0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \h_cnt[7]_INST_0\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \h_cnt[8]_INST_0\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \h_cnt[9]_INST_0\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of hsync_i_i_3 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of hsync_i_i_4 : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of hsync_i_i_5 : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \line_cnt[0]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \line_cnt[10]_i_3\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \line_cnt[10]_i_4\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \line_cnt[10]_i_5\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \line_cnt[1]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \line_cnt[2]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \line_cnt[3]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \line_cnt[4]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \line_cnt[6]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \line_cnt[7]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \line_cnt[8]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \pixel_cnt[10]_i_3\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \pixel_cnt[1]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \pixel_cnt[2]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \pixel_cnt[3]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \pixel_cnt[4]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \pixel_cnt[6]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \pixel_cnt[7]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \pixel_cnt[8]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of valid_INST_0_i_1 : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of valid_INST_0_i_2 : label is "soft_lutpair5";
begin
\h_cnt[0]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"01550000"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(10),
      I1 => \pixel_cnt_reg__0\(8),
      I2 => \pixel_cnt_reg__0\(7),
      I3 => \pixel_cnt_reg__0\(9),
      I4 => \pixel_cnt_reg__0\(0),
      O => h_cnt(0)
    );
\h_cnt[1]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"01550000"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(10),
      I1 => \pixel_cnt_reg__0\(8),
      I2 => \pixel_cnt_reg__0\(7),
      I3 => \pixel_cnt_reg__0\(9),
      I4 => \pixel_cnt_reg__0\(1),
      O => h_cnt(1)
    );
\h_cnt[2]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"01550000"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(10),
      I1 => \pixel_cnt_reg__0\(8),
      I2 => \pixel_cnt_reg__0\(7),
      I3 => \pixel_cnt_reg__0\(9),
      I4 => \pixel_cnt_reg__0\(2),
      O => h_cnt(2)
    );
\h_cnt[3]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"01550000"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(10),
      I1 => \pixel_cnt_reg__0\(8),
      I2 => \pixel_cnt_reg__0\(7),
      I3 => \pixel_cnt_reg__0\(9),
      I4 => \pixel_cnt_reg__0\(3),
      O => h_cnt(3)
    );
\h_cnt[4]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"01550000"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(10),
      I1 => \pixel_cnt_reg__0\(8),
      I2 => \pixel_cnt_reg__0\(7),
      I3 => \pixel_cnt_reg__0\(9),
      I4 => \pixel_cnt_reg__0\(4),
      O => h_cnt(4)
    );
\h_cnt[5]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"01550000"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(10),
      I1 => \pixel_cnt_reg__0\(8),
      I2 => \pixel_cnt_reg__0\(7),
      I3 => \pixel_cnt_reg__0\(9),
      I4 => \pixel_cnt_reg__0\(5),
      O => h_cnt(5)
    );
\h_cnt[6]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"01550000"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(10),
      I1 => \pixel_cnt_reg__0\(8),
      I2 => \pixel_cnt_reg__0\(7),
      I3 => \pixel_cnt_reg__0\(9),
      I4 => \pixel_cnt_reg__0\(6),
      O => h_cnt(6)
    );
\h_cnt[7]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(10),
      I1 => \pixel_cnt_reg__0\(9),
      I2 => \pixel_cnt_reg__0\(7),
      O => h_cnt(7)
    );
\h_cnt[8]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(10),
      I1 => \pixel_cnt_reg__0\(9),
      I2 => \pixel_cnt_reg__0\(8),
      O => h_cnt(8)
    );
\h_cnt[9]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0100"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(8),
      I1 => \pixel_cnt_reg__0\(7),
      I2 => \pixel_cnt_reg__0\(10),
      I3 => \pixel_cnt_reg__0\(9),
      O => h_cnt(9)
    );
hsync_i_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => hsync_i_i_2_n_0,
      I1 => hsync_i_i_3_n_0,
      I2 => \pixel_cnt_reg__0\(6),
      I3 => reset,
      O => hsync_i_i_1_n_0
    );
hsync_i_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFDDFD"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(9),
      I1 => \pixel_cnt_reg__0\(10),
      I2 => hsync_i_i_4_n_0,
      I3 => \pixel_cnt_reg__0\(4),
      I4 => \pixel_cnt_reg__0\(8),
      I5 => hsync_i_i_5_n_0,
      O => hsync_i_i_2_n_0
    );
hsync_i_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80000000"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(4),
      I1 => \pixel_cnt_reg__0\(3),
      I2 => \pixel_cnt_reg__0\(1),
      I3 => \pixel_cnt_reg__0\(0),
      I4 => \pixel_cnt_reg__0\(2),
      O => hsync_i_i_3_n_0
    );
hsync_i_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(2),
      I1 => \pixel_cnt_reg__0\(0),
      I2 => \pixel_cnt_reg__0\(1),
      I3 => \pixel_cnt_reg__0\(3),
      O => hsync_i_i_4_n_0
    );
hsync_i_i_5: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(5),
      I1 => \pixel_cnt_reg__0\(7),
      O => hsync_i_i_5_n_0
    );
hsync_i_reg: unisim.vcomponents.FDRE
     port map (
      C => pclk,
      CE => '1',
      D => hsync_i_i_1_n_0,
      Q => hsync,
      R => '0'
    );
\line_cnt[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \line_cnt_reg__0\(0),
      O => \line_cnt[0]_i_1_n_0\
    );
\line_cnt[10]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FAEAEAEA"
    )
        port map (
      I0 => reset,
      I1 => \line_cnt_reg__0\(10),
      I2 => \line_cnt[10]_i_2_n_0\,
      I3 => \line_cnt_reg__0\(9),
      I4 => vsync_i_i_2_n_0,
      O => \line_cnt[10]_i_1_n_0\
    );
\line_cnt[10]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"10000000"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(10),
      I1 => \pixel_cnt[10]_i_3_n_0\,
      I2 => hsync_i_i_3_n_0,
      I3 => \pixel_cnt_reg__0\(8),
      I4 => \pixel_cnt_reg__0\(9),
      O => \line_cnt[10]_i_2_n_0\
    );
\line_cnt[10]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F708"
    )
        port map (
      I0 => \line_cnt[10]_i_4_n_0\,
      I1 => \line_cnt_reg__0\(9),
      I2 => \line_cnt[10]_i_5_n_0\,
      I3 => \line_cnt_reg__0\(10),
      O => \p_0_in__0\(10)
    );
\line_cnt[10]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80000000"
    )
        port map (
      I0 => \line_cnt_reg__0\(0),
      I1 => \line_cnt_reg__0\(1),
      I2 => \line_cnt_reg__0\(2),
      I3 => \line_cnt_reg__0\(3),
      I4 => \line_cnt_reg__0\(4),
      O => \line_cnt[10]_i_4_n_0\
    );
\line_cnt[10]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => \line_cnt_reg__0\(8),
      I1 => \line_cnt_reg__0\(7),
      I2 => \line_cnt_reg__0\(6),
      I3 => \line_cnt_reg__0\(5),
      O => \line_cnt[10]_i_5_n_0\
    );
\line_cnt[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \line_cnt_reg__0\(0),
      I1 => \line_cnt_reg__0\(1),
      O => \p_0_in__0\(1)
    );
\line_cnt[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \line_cnt_reg__0\(1),
      I1 => \line_cnt_reg__0\(0),
      I2 => \line_cnt_reg__0\(2),
      O => \p_0_in__0\(2)
    );
\line_cnt[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \line_cnt_reg__0\(2),
      I1 => \line_cnt_reg__0\(0),
      I2 => \line_cnt_reg__0\(1),
      I3 => \line_cnt_reg__0\(3),
      O => \p_0_in__0\(3)
    );
\line_cnt[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => \line_cnt_reg__0\(0),
      I1 => \line_cnt_reg__0\(1),
      I2 => \line_cnt_reg__0\(2),
      I3 => \line_cnt_reg__0\(3),
      I4 => \line_cnt_reg__0\(4),
      O => \p_0_in__0\(4)
    );
\line_cnt[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFF80000000"
    )
        port map (
      I0 => \line_cnt_reg__0\(4),
      I1 => \line_cnt_reg__0\(3),
      I2 => \line_cnt_reg__0\(2),
      I3 => \line_cnt_reg__0\(1),
      I4 => \line_cnt_reg__0\(0),
      I5 => \line_cnt_reg__0\(5),
      O => \p_0_in__0\(5)
    );
\line_cnt[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \line_cnt_reg__0\(5),
      I1 => \line_cnt[10]_i_4_n_0\,
      I2 => \line_cnt_reg__0\(6),
      O => \p_0_in__0\(6)
    );
\line_cnt[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \line_cnt_reg__0\(5),
      I1 => \line_cnt_reg__0\(6),
      I2 => \line_cnt[10]_i_4_n_0\,
      I3 => \line_cnt_reg__0\(7),
      O => \p_0_in__0\(7)
    );
\line_cnt[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => \line_cnt_reg__0\(6),
      I1 => \line_cnt_reg__0\(5),
      I2 => \line_cnt_reg__0\(7),
      I3 => \line_cnt[10]_i_4_n_0\,
      I4 => \line_cnt_reg__0\(8),
      O => \p_0_in__0\(8)
    );
\line_cnt[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFF80000000"
    )
        port map (
      I0 => \line_cnt_reg__0\(8),
      I1 => \line_cnt_reg__0\(7),
      I2 => \line_cnt_reg__0\(6),
      I3 => \line_cnt_reg__0\(5),
      I4 => \line_cnt[10]_i_4_n_0\,
      I5 => \line_cnt_reg__0\(9),
      O => \p_0_in__0\(9)
    );
\line_cnt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => pclk,
      CE => \line_cnt[10]_i_2_n_0\,
      D => \line_cnt[0]_i_1_n_0\,
      Q => \line_cnt_reg__0\(0),
      R => \line_cnt[10]_i_1_n_0\
    );
\line_cnt_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => pclk,
      CE => \line_cnt[10]_i_2_n_0\,
      D => \p_0_in__0\(10),
      Q => \line_cnt_reg__0\(10),
      R => \line_cnt[10]_i_1_n_0\
    );
\line_cnt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => pclk,
      CE => \line_cnt[10]_i_2_n_0\,
      D => \p_0_in__0\(1),
      Q => \line_cnt_reg__0\(1),
      R => \line_cnt[10]_i_1_n_0\
    );
\line_cnt_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => pclk,
      CE => \line_cnt[10]_i_2_n_0\,
      D => \p_0_in__0\(2),
      Q => \line_cnt_reg__0\(2),
      R => \line_cnt[10]_i_1_n_0\
    );
\line_cnt_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => pclk,
      CE => \line_cnt[10]_i_2_n_0\,
      D => \p_0_in__0\(3),
      Q => \line_cnt_reg__0\(3),
      R => \line_cnt[10]_i_1_n_0\
    );
\line_cnt_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => pclk,
      CE => \line_cnt[10]_i_2_n_0\,
      D => \p_0_in__0\(4),
      Q => \line_cnt_reg__0\(4),
      R => \line_cnt[10]_i_1_n_0\
    );
\line_cnt_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => pclk,
      CE => \line_cnt[10]_i_2_n_0\,
      D => \p_0_in__0\(5),
      Q => \line_cnt_reg__0\(5),
      R => \line_cnt[10]_i_1_n_0\
    );
\line_cnt_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => pclk,
      CE => \line_cnt[10]_i_2_n_0\,
      D => \p_0_in__0\(6),
      Q => \line_cnt_reg__0\(6),
      R => \line_cnt[10]_i_1_n_0\
    );
\line_cnt_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => pclk,
      CE => \line_cnt[10]_i_2_n_0\,
      D => \p_0_in__0\(7),
      Q => \line_cnt_reg__0\(7),
      R => \line_cnt[10]_i_1_n_0\
    );
\line_cnt_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => pclk,
      CE => \line_cnt[10]_i_2_n_0\,
      D => \p_0_in__0\(8),
      Q => \line_cnt_reg__0\(8),
      R => \line_cnt[10]_i_1_n_0\
    );
\line_cnt_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => pclk,
      CE => \line_cnt[10]_i_2_n_0\,
      D => \p_0_in__0\(9),
      Q => \line_cnt_reg__0\(9),
      R => \line_cnt[10]_i_1_n_0\
    );
\pixel_cnt[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(0),
      O => \pixel_cnt[0]_i_1_n_0\
    );
\pixel_cnt[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF8880"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(9),
      I1 => \pixel_cnt_reg__0\(8),
      I2 => hsync_i_i_3_n_0,
      I3 => \pixel_cnt[10]_i_3_n_0\,
      I4 => reset,
      I5 => \pixel_cnt_reg__0\(10),
      O => \pixel_cnt[10]_i_1_n_0\
    );
\pixel_cnt[10]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(9),
      I1 => \pixel_cnt_reg__0\(8),
      I2 => hsync_i_i_3_n_0,
      I3 => \pixel_cnt_reg__0\(6),
      I4 => \pixel_cnt_reg__0\(7),
      I5 => \pixel_cnt_reg__0\(5),
      O => p_0_in(10)
    );
\pixel_cnt[10]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(7),
      I1 => \pixel_cnt_reg__0\(6),
      I2 => \pixel_cnt_reg__0\(5),
      O => \pixel_cnt[10]_i_3_n_0\
    );
\pixel_cnt[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(0),
      I1 => \pixel_cnt_reg__0\(1),
      O => p_0_in(1)
    );
\pixel_cnt[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(1),
      I1 => \pixel_cnt_reg__0\(0),
      I2 => \pixel_cnt_reg__0\(2),
      O => \pixel_cnt[2]_i_1_n_0\
    );
\pixel_cnt[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(2),
      I1 => \pixel_cnt_reg__0\(0),
      I2 => \pixel_cnt_reg__0\(1),
      I3 => \pixel_cnt_reg__0\(3),
      O => \pixel_cnt[3]_i_1_n_0\
    );
\pixel_cnt[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(3),
      I1 => \pixel_cnt_reg__0\(1),
      I2 => \pixel_cnt_reg__0\(0),
      I3 => \pixel_cnt_reg__0\(2),
      I4 => \pixel_cnt_reg__0\(4),
      O => \pixel_cnt[4]_i_1_n_0\
    );
\pixel_cnt[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFF80000000"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(2),
      I1 => \pixel_cnt_reg__0\(0),
      I2 => \pixel_cnt_reg__0\(1),
      I3 => \pixel_cnt_reg__0\(3),
      I4 => \pixel_cnt_reg__0\(4),
      I5 => \pixel_cnt_reg__0\(5),
      O => p_0_in(5)
    );
\pixel_cnt[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(5),
      I1 => hsync_i_i_3_n_0,
      I2 => \pixel_cnt_reg__0\(6),
      O => p_0_in(6)
    );
\pixel_cnt[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => hsync_i_i_3_n_0,
      I1 => \pixel_cnt_reg__0\(5),
      I2 => \pixel_cnt_reg__0\(6),
      I3 => \pixel_cnt_reg__0\(7),
      O => p_0_in(7)
    );
\pixel_cnt[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => hsync_i_i_3_n_0,
      I1 => \pixel_cnt_reg__0\(6),
      I2 => \pixel_cnt_reg__0\(7),
      I3 => \pixel_cnt_reg__0\(5),
      I4 => \pixel_cnt_reg__0\(8),
      O => p_0_in(8)
    );
\pixel_cnt[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFF80000000"
    )
        port map (
      I0 => hsync_i_i_3_n_0,
      I1 => \pixel_cnt_reg__0\(8),
      I2 => \pixel_cnt_reg__0\(6),
      I3 => \pixel_cnt_reg__0\(7),
      I4 => \pixel_cnt_reg__0\(5),
      I5 => \pixel_cnt_reg__0\(9),
      O => p_0_in(9)
    );
\pixel_cnt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => pclk,
      CE => '1',
      D => \pixel_cnt[0]_i_1_n_0\,
      Q => \pixel_cnt_reg__0\(0),
      R => \pixel_cnt[10]_i_1_n_0\
    );
\pixel_cnt_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => pclk,
      CE => '1',
      D => p_0_in(10),
      Q => \pixel_cnt_reg__0\(10),
      R => \pixel_cnt[10]_i_1_n_0\
    );
\pixel_cnt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => pclk,
      CE => '1',
      D => p_0_in(1),
      Q => \pixel_cnt_reg__0\(1),
      R => \pixel_cnt[10]_i_1_n_0\
    );
\pixel_cnt_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => pclk,
      CE => '1',
      D => \pixel_cnt[2]_i_1_n_0\,
      Q => \pixel_cnt_reg__0\(2),
      R => \pixel_cnt[10]_i_1_n_0\
    );
\pixel_cnt_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => pclk,
      CE => '1',
      D => \pixel_cnt[3]_i_1_n_0\,
      Q => \pixel_cnt_reg__0\(3),
      R => \pixel_cnt[10]_i_1_n_0\
    );
\pixel_cnt_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => pclk,
      CE => '1',
      D => \pixel_cnt[4]_i_1_n_0\,
      Q => \pixel_cnt_reg__0\(4),
      R => \pixel_cnt[10]_i_1_n_0\
    );
\pixel_cnt_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => pclk,
      CE => '1',
      D => p_0_in(5),
      Q => \pixel_cnt_reg__0\(5),
      R => \pixel_cnt[10]_i_1_n_0\
    );
\pixel_cnt_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => pclk,
      CE => '1',
      D => p_0_in(6),
      Q => \pixel_cnt_reg__0\(6),
      R => \pixel_cnt[10]_i_1_n_0\
    );
\pixel_cnt_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => pclk,
      CE => '1',
      D => p_0_in(7),
      Q => \pixel_cnt_reg__0\(7),
      R => \pixel_cnt[10]_i_1_n_0\
    );
\pixel_cnt_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => pclk,
      CE => '1',
      D => p_0_in(8),
      Q => \pixel_cnt_reg__0\(8),
      R => \pixel_cnt[10]_i_1_n_0\
    );
\pixel_cnt_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => pclk,
      CE => '1',
      D => p_0_in(9),
      Q => \pixel_cnt_reg__0\(9),
      R => \pixel_cnt[10]_i_1_n_0\
    );
\v_cnt[0]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF000000000000"
    )
        port map (
      I0 => \line_cnt_reg__0\(8),
      I1 => \line_cnt_reg__0\(7),
      I2 => \line_cnt_reg__0\(6),
      I3 => \line_cnt_reg__0\(5),
      I4 => valid_INST_0_i_1_n_0,
      I5 => \line_cnt_reg__0\(0),
      O => v_cnt(0)
    );
\v_cnt[1]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF000000000000"
    )
        port map (
      I0 => \line_cnt_reg__0\(8),
      I1 => \line_cnt_reg__0\(7),
      I2 => \line_cnt_reg__0\(6),
      I3 => \line_cnt_reg__0\(5),
      I4 => valid_INST_0_i_1_n_0,
      I5 => \line_cnt_reg__0\(1),
      O => v_cnt(1)
    );
\v_cnt[2]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF000000000000"
    )
        port map (
      I0 => \line_cnt_reg__0\(8),
      I1 => \line_cnt_reg__0\(7),
      I2 => \line_cnt_reg__0\(6),
      I3 => \line_cnt_reg__0\(5),
      I4 => valid_INST_0_i_1_n_0,
      I5 => \line_cnt_reg__0\(2),
      O => v_cnt(2)
    );
\v_cnt[3]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF000000000000"
    )
        port map (
      I0 => \line_cnt_reg__0\(8),
      I1 => \line_cnt_reg__0\(7),
      I2 => \line_cnt_reg__0\(6),
      I3 => \line_cnt_reg__0\(5),
      I4 => valid_INST_0_i_1_n_0,
      I5 => \line_cnt_reg__0\(3),
      O => v_cnt(3)
    );
\v_cnt[4]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF000000000000"
    )
        port map (
      I0 => \line_cnt_reg__0\(8),
      I1 => \line_cnt_reg__0\(7),
      I2 => \line_cnt_reg__0\(6),
      I3 => \line_cnt_reg__0\(5),
      I4 => valid_INST_0_i_1_n_0,
      I5 => \line_cnt_reg__0\(4),
      O => v_cnt(4)
    );
\v_cnt[5]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0002020202020202"
    )
        port map (
      I0 => \line_cnt_reg__0\(5),
      I1 => \line_cnt_reg__0\(9),
      I2 => \line_cnt_reg__0\(10),
      I3 => \line_cnt_reg__0\(6),
      I4 => \line_cnt_reg__0\(7),
      I5 => \line_cnt_reg__0\(8),
      O => v_cnt(5)
    );
\v_cnt[6]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0002020202020202"
    )
        port map (
      I0 => \line_cnt_reg__0\(6),
      I1 => \line_cnt_reg__0\(9),
      I2 => \line_cnt_reg__0\(10),
      I3 => \line_cnt_reg__0\(5),
      I4 => \line_cnt_reg__0\(7),
      I5 => \line_cnt_reg__0\(8),
      O => v_cnt(6)
    );
\v_cnt[7]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0002020202020202"
    )
        port map (
      I0 => \line_cnt_reg__0\(7),
      I1 => \line_cnt_reg__0\(9),
      I2 => \line_cnt_reg__0\(10),
      I3 => \line_cnt_reg__0\(8),
      I4 => \line_cnt_reg__0\(5),
      I5 => \line_cnt_reg__0\(6),
      O => v_cnt(7)
    );
\v_cnt[8]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0002020202020202"
    )
        port map (
      I0 => \line_cnt_reg__0\(8),
      I1 => \line_cnt_reg__0\(9),
      I2 => \line_cnt_reg__0\(10),
      I3 => \line_cnt_reg__0\(7),
      I4 => \line_cnt_reg__0\(5),
      I5 => \line_cnt_reg__0\(6),
      O => v_cnt(8)
    );
valid_INST_0: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2AAAAAAA00000000"
    )
        port map (
      I0 => valid_INST_0_i_1_n_0,
      I1 => \line_cnt_reg__0\(8),
      I2 => \line_cnt_reg__0\(7),
      I3 => \line_cnt_reg__0\(6),
      I4 => \line_cnt_reg__0\(5),
      I5 => valid_INST_0_i_2_n_0,
      O => valid
    );
valid_INST_0_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \line_cnt_reg__0\(9),
      I1 => \line_cnt_reg__0\(10),
      O => valid_INST_0_i_1_n_0
    );
valid_INST_0_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0057"
    )
        port map (
      I0 => \pixel_cnt_reg__0\(9),
      I1 => \pixel_cnt_reg__0\(7),
      I2 => \pixel_cnt_reg__0\(8),
      I3 => \pixel_cnt_reg__0\(10),
      O => valid_INST_0_i_2_n_0
    );
vsync_i_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFBBB"
    )
        port map (
      I0 => \line_cnt_reg__0\(10),
      I1 => \line_cnt_reg__0\(9),
      I2 => \line_cnt_reg__0\(3),
      I3 => \line_cnt_reg__0\(1),
      I4 => vsync_i_i_2_n_0,
      I5 => reset,
      O => vsync_i_i_1_n_0
    );
vsync_i_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \line_cnt_reg__0\(7),
      I1 => \line_cnt_reg__0\(8),
      I2 => \line_cnt_reg__0\(5),
      I3 => \line_cnt_reg__0\(6),
      I4 => \line_cnt_reg__0\(4),
      I5 => vsync_i_i_3_n_0,
      O => vsync_i_i_2_n_0
    );
vsync_i_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \line_cnt_reg__0\(2),
      I1 => \line_cnt_reg__0\(3),
      O => vsync_i_i_3_n_0
    );
vsync_i_reg: unisim.vcomponents.FDRE
     port map (
      C => pclk,
      CE => '1',
      D => vsync_i_i_1_n_0,
      Q => vsync,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity vga_0 is
  port (
    pclk : in STD_LOGIC;
    reset : in STD_LOGIC;
    hsync : out STD_LOGIC;
    vsync : out STD_LOGIC;
    valid : out STD_LOGIC;
    h_cnt : out STD_LOGIC_VECTOR ( 10 downto 0 );
    v_cnt : out STD_LOGIC_VECTOR ( 9 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of vga_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of vga_0 : entity is "vga_0,vga,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of vga_0 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of vga_0 : entity is "vga,Vivado 2018.2.1";
end vga_0;

architecture STRUCTURE of vga_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \^h_cnt\ : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal \^v_cnt\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of reset : signal is "xilinx.com:signal:reset:1.0 signal_reset RST";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of reset : signal is "XIL_INTERFACENAME signal_reset, POLARITY ACTIVE_LOW";
begin
  h_cnt(10) <= \<const0>\;
  h_cnt(9 downto 0) <= \^h_cnt\(9 downto 0);
  v_cnt(9) <= \<const0>\;
  v_cnt(8 downto 0) <= \^v_cnt\(8 downto 0);
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
inst: entity work.vga_0_vga
     port map (
      h_cnt(9 downto 0) => \^h_cnt\(9 downto 0),
      hsync => hsync,
      pclk => pclk,
      reset => reset,
      v_cnt(8 downto 0) => \^v_cnt\(8 downto 0),
      valid => valid,
      vsync => vsync
    );
end STRUCTURE;
