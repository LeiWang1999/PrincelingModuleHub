/**********************************************************
single character recognition
***********************************************************/

`define hcount15 ((hcount_r-hcount_l)  /5 + hcount_l)
`define hcount25 ((hcount_r-hcount_l)*2/5 + hcount_l)
`define hcount35 ((hcount_r-hcount_l)*3/5 + hcount_l)
`define hcount45 ((hcount_r-hcount_l)*4/5 + hcount_l)

`define vcount18 ((vcount_r-vcount_l)  /8 + vcount_l)
`define vcount28 ((vcount_r-vcount_l)*2/8 + vcount_l)
`define vcount38 ((vcount_r-vcount_l)*3/8 + vcount_l)
`define vcount48 ((vcount_r-vcount_l)*4/8 + vcount_l)
`define vcount58 ((vcount_r-vcount_l)*5/8 + vcount_l)
`define vcount68 ((vcount_r-vcount_l)*6/8 + vcount_l)
`define vcount78 ((vcount_r-vcount_l)*7/8 + vcount_l)

`define w (`hcount15 - hcount_l)
`define h (`vcount18 - vcount_l)
`define area (`w*`h)
`define area2 (`area/2)

module character_recognition(
       input						    pixelclk,
	   input                            reset_n,
	   input          [2:0]            frame_cnt,//1230

  	   input          [23:0]            i_rgb,
	   input						    i_hsync,
	   input							i_vsync,
	   input							i_de,
	   
	   input [11:0]                     hcount,
       input [11:0]                     vcount,
	   
	   input          [11:0]            hcount_l,
       input          [11:0]            hcount_r,
       input          [11:0]            vcount_l,
       input          [11:0]            vcount_r,
       output         [39:0]            char	   
	   );
	   
reg i_vsync_r;
reg i_vsync_r1;
wire i_vsync_pos;
wire i_vsync_pos1; 

wire      wb;//white '1' 
assign wb = (i_rgb == 24'hfff_fff)?1'b1:1'b0;

always @(posedge pixelclk)begin 
  i_vsync_r <= i_vsync;
  i_vsync_r1 <= i_vsync_r; 
end

assign i_vsync_pos = (i_vsync &(!i_vsync_r));
assign i_vsync_pos1 = (i_vsync_r &(!i_vsync_r1));

//-------------------------------------------------------------
//statistics 1
//-------------------------------------------------------------
reg [11:0] area11_cnt;
reg [11:0] area12_cnt;
reg [11:0] area13_cnt;
reg [11:0] area14_cnt;
reg [11:0] area15_cnt;

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area11_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > vcount_l && vcount < `vcount18 && hcount > hcount_l && hcount < `hcount15))
     if(wb == 1'b0)
	   area11_cnt <= area11_cnt +1;
   else
     area11_cnt <= area11_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area12_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > vcount_l && vcount < `vcount18 && hcount > `hcount15 && hcount < `hcount25))
     if(wb == 1'b0)
	   area12_cnt <= area12_cnt +1;
   else
     area12_cnt <= area12_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area13_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > vcount_l && vcount < `vcount18 && hcount > `hcount25 && hcount < `hcount35))
     if(wb == 1'b0)
	   area13_cnt <= area13_cnt +1;
   else
     area13_cnt <= area13_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area14_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > vcount_l && vcount < `vcount18 && hcount > `hcount35 && hcount < `hcount45))
     if(wb == 1'b0)
	   area14_cnt <= area14_cnt +1;
   else
     area14_cnt <= area14_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area15_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > vcount_l && vcount < `vcount18 && hcount > `hcount45 && hcount < hcount_r))
     if(wb == 1'b0)
	   area15_cnt <= area15_cnt +1;
   else
     area15_cnt <= area15_cnt;
end

//-------------------------------------------------------------
//statistics 2
//-------------------------------------------------------------
reg [11:0] area21_cnt;
reg [11:0] area22_cnt;
reg [11:0] area23_cnt;
reg [11:0] area24_cnt;
reg [11:0] area25_cnt;


always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area21_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount18 && vcount < `vcount28 && hcount > hcount_l && hcount < `hcount15))
     if(wb == 1'b0)
	   area21_cnt <= area21_cnt +1;
   else
     area21_cnt <= area21_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area22_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount18 && vcount < `vcount28 && hcount > `hcount15 && hcount < `hcount25))
     if(wb == 1'b0)
	   area22_cnt <= area22_cnt +1;
   else
     area22_cnt <= area22_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area23_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount18 && vcount < `vcount28 && hcount > `hcount25 && hcount < `hcount35))
     if(wb == 1'b0)
	   area23_cnt <= area23_cnt +1;
   else
     area23_cnt <= area23_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area24_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount18 && vcount < `vcount28 && hcount > `hcount35 && hcount < `hcount45))
     if(wb == 1'b0)
	   area24_cnt <= area24_cnt +1;
   else
     area24_cnt <= area24_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area25_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount18 && vcount < `vcount28 && hcount > `hcount45 && hcount < hcount_r))
     if(wb == 1'b0)
	   area25_cnt <= area25_cnt +1;
   else
     area25_cnt <= area25_cnt;
end

//-------------------------------------------------------------
//statistics 3
//-------------------------------------------------------------
reg [11:0] area31_cnt;
reg [11:0] area32_cnt;
reg [11:0] area33_cnt;
reg [11:0] area34_cnt;
reg [11:0] area35_cnt;


always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area31_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount28 && vcount < `vcount38 && hcount > hcount_l && hcount < `hcount15))
     if(wb == 1'b0)
	   area31_cnt <= area31_cnt +1;
   else
     area31_cnt <= area31_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area32_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount28 && vcount < `vcount38 && hcount > `hcount15 && hcount < `hcount25))
     if(wb == 1'b0)
	   area32_cnt <= area32_cnt +1;
   else
     area32_cnt <= area32_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area33_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount28 && vcount < `vcount38 && hcount > `hcount25 && hcount < `hcount35))
     if(wb == 1'b0)
	   area33_cnt <= area33_cnt +1;
   else
     area33_cnt <= area33_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area34_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount28 && vcount < `vcount38 && hcount > `hcount35 && hcount < `hcount45))
     if(wb == 1'b0)
	   area34_cnt <= area34_cnt +1;
   else
     area34_cnt <= area34_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area35_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount28 && vcount < `vcount38 && hcount > `hcount45 && hcount < hcount_r))
     if(wb == 1'b0)
	   area35_cnt <= area35_cnt +1;
   else
     area35_cnt <= area35_cnt;
end

//-------------------------------------------------------------
//statistics 4
//-------------------------------------------------------------
reg [11:0] area41_cnt;
reg [11:0] area42_cnt;
reg [11:0] area43_cnt;
reg [11:0] area44_cnt;
reg [11:0] area45_cnt;

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area41_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount38 && vcount < `vcount48 && hcount > hcount_l && hcount < `hcount15))
     if(wb == 1'b0)
	   area41_cnt <= area41_cnt +1;
   else
     area41_cnt <= area41_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area42_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount38 && vcount < `vcount48 && hcount > `hcount15 && hcount < `hcount25))
     if(wb == 1'b0)
	   area42_cnt <= area42_cnt +1;
   else
     area42_cnt <= area42_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area43_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount38 && vcount < `vcount48 && hcount > `hcount25 && hcount < `hcount35))
     if(wb == 1'b0)
	   area43_cnt <= area43_cnt +1;
   else
     area43_cnt <= area43_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area44_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount38 && vcount < `vcount48 && hcount > `hcount35 && hcount < `hcount45))
     if(wb == 1'b0)
	   area44_cnt <= area44_cnt +1;
   else
     area44_cnt <= area44_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area45_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount38 && vcount < `vcount48 && hcount > `hcount45 && hcount < hcount_r))
     if(wb == 1'b0)
	   area45_cnt <= area45_cnt +1;
   else
     area45_cnt <= area45_cnt;
end
//-------------------------------------------------------------
//statistics 5
//-------------------------------------------------------------
reg [11:0] area51_cnt;
reg [11:0] area52_cnt;
reg [11:0] area53_cnt;
reg [11:0] area54_cnt;
reg [11:0] area55_cnt;

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area51_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount48 && vcount < `vcount58 && hcount > hcount_l && hcount < `hcount15))
     if(wb == 1'b0)
	   area51_cnt <= area51_cnt +1;
   else
     area51_cnt <= area51_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area52_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount48 && vcount < `vcount58 && hcount > `hcount15 && hcount < `hcount25))
     if(wb == 1'b0)
	   area52_cnt <= area52_cnt +1;
   else
     area52_cnt <= area52_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area53_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount48 && vcount < `vcount58 && hcount > `hcount25 && hcount < `hcount35))
     if(wb == 1'b0)
	   area53_cnt <= area53_cnt +1;
   else
     area53_cnt <= area53_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area54_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount48 && vcount < `vcount58 && hcount > `hcount35 && hcount < `hcount45))
     if(wb == 1'b0)
	   area54_cnt <= area54_cnt +1;
   else
     area54_cnt <= area54_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area55_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount48 && vcount < `vcount58 && hcount > `hcount45 && hcount < hcount_r))
     if(wb == 1'b0)
	   area55_cnt <= area55_cnt +1;
   else
     area55_cnt <= area55_cnt;
end

//-------------------------------------------------------------
//statistics 6
//-------------------------------------------------------------
reg [11:0] area61_cnt;
reg [11:0] area62_cnt;
reg [11:0] area63_cnt;
reg [11:0] area64_cnt;
reg [11:0] area65_cnt;


always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area61_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount58 && vcount < `vcount68 && hcount > hcount_l && hcount < `hcount15))
     if(wb == 1'b0)
	   area61_cnt <= area61_cnt +1;
   else
     area61_cnt <= area61_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area62_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount58 && vcount < `vcount68 && hcount > `hcount15 && hcount < `hcount25))
     if(wb == 1'b0)
	   area62_cnt <= area62_cnt +1;
   else
     area62_cnt <= area62_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area63_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount58 && vcount < `vcount68 && hcount > `hcount25 && hcount < `hcount35))
     if(wb == 1'b0)
	   area63_cnt <= area63_cnt +1;
   else
     area63_cnt <= area63_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area64_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount58 && vcount < `vcount68 && hcount > `hcount35 && hcount < `hcount45))
     if(wb == 1'b0)
	   area64_cnt <= area64_cnt +1;
   else
     area64_cnt <= area64_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area65_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount58 && vcount < `vcount68 && hcount > `hcount45 && hcount < hcount_r))
     if(wb == 1'b0)
	   area65_cnt <= area65_cnt +1;
   else
     area65_cnt <= area65_cnt;
end

//-------------------------------------------------------------
//statistics 7
//-------------------------------------------------------------
reg [11:0] area71_cnt;
reg [11:0] area72_cnt;
reg [11:0] area73_cnt;
reg [11:0] area74_cnt;
reg [11:0] area75_cnt;


always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area71_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount68 && vcount < `vcount78 && hcount > hcount_l && hcount < `hcount15))
     if(wb == 1'b0)
	   area71_cnt <= area71_cnt +1;
   else
     area71_cnt <= area71_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area72_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount68 && vcount < `vcount78 && hcount > `hcount15 && hcount < `hcount25))
     if(wb == 1'b0)
	   area72_cnt <= area72_cnt +1;
   else
     area72_cnt <= area72_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area73_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount68 && vcount < `vcount78 && hcount > `hcount25 && hcount < `hcount35))
     if(wb == 1'b0)
	   area73_cnt <= area73_cnt +1;
   else
     area73_cnt <= area73_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area74_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount68 && vcount < `vcount78 && hcount > `hcount35 && hcount < `hcount45))
     if(wb == 1'b0)
	   area74_cnt <= area74_cnt +1;
   else
     area74_cnt <= area74_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area75_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount68 && vcount < `vcount78 && hcount > `hcount45 && hcount < hcount_r))
     if(wb == 1'b0)
	   area75_cnt <= area75_cnt +1;
   else
     area75_cnt <= area75_cnt;
end

//-------------------------------------------------------------
//statistics 8
//-------------------------------------------------------------
reg [11:0] area81_cnt;
reg [11:0] area82_cnt;
reg [11:0] area83_cnt;
reg [11:0] area84_cnt;
reg [11:0] area85_cnt;

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area81_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount78 && vcount < vcount_r && hcount > hcount_l && hcount < `hcount15))
     if(wb == 1'b0)
	   area81_cnt <= area81_cnt +1;
   else
     area81_cnt <= area81_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area82_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount78 && vcount < vcount_r && hcount > `hcount15 && hcount < `hcount25))
     if(wb == 1'b0)
	   area82_cnt <= area82_cnt +1;
   else
     area82_cnt <= area82_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area83_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount78 && vcount < vcount_r && hcount > `hcount25 && hcount < `hcount35))
     if(wb == 1'b0)
	   area83_cnt <= area83_cnt +1;
   else
     area83_cnt <= area83_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area84_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount78 && vcount < vcount_r && hcount > `hcount35 && hcount < `hcount45))
     if(wb == 1'b0)
	   area84_cnt <= area84_cnt +1;
   else
     area84_cnt <= area84_cnt;
end

always @(posedge pixelclk or negedge reset_n) begin
   if(!reset_n)
     area85_cnt <= 10'd0;
   else if(frame_cnt == 1 && (vcount > `vcount78 && vcount < vcount_r && hcount > `hcount45 && hcount < hcount_r))
     if(wb == 1'b0)
	   area85_cnt <= area85_cnt +1;
   else
     area85_cnt <= area85_cnt;
end
//--------------------------------------------------------------
// analyze
//--------------------------------------------------------------
/*
wire  area11_wb = (area11_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area12_wb = (area12_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area13_wb = (area13_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area14_wb = (area14_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area15_wb = (area15_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;

wire  area21_wb = (area21_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area22_wb = (area22_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area23_wb = (area23_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area24_wb = (area24_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area25_wb = (area25_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;

wire  area31_wb = (area31_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area32_wb = (area32_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area33_wb = (area33_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area34_wb = (area34_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area35_wb = (area35_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;

wire  area41_wb = (area41_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area42_wb = (area42_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area43_wb = (area43_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area44_wb = (area44_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area45_wb = (area45_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;

wire  area51_wb = (area51_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area52_wb = (area52_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area53_wb = (area53_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area54_wb = (area54_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area55_wb = (area55_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;

wire  area61_wb = (area61_cnt > `area2  && frame_cnt == 1)?1'b1:1'b0;
wire  area62_wb = (area62_cnt > `area2  && frame_cnt == 1)?1'b1:1'b0;
wire  area63_wb = (area63_cnt > `area2  && frame_cnt == 1)?1'b1:1'b0;
wire  area64_wb = (area64_cnt > `area2  && frame_cnt == 1)?1'b1:1'b0;
wire  area65_wb = (area65_cnt > `area2  && frame_cnt == 1)?1'b1:1'b0;

wire  area71_wb = (area71_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area72_wb = (area72_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area73_wb = (area73_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area74_wb = (area74_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area75_wb = (area75_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;

wire  area81_wb = (area81_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area82_wb = (area82_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area83_wb = (area83_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area84_wb = (area84_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
wire  area85_wb = (area85_cnt > `area2  && frame_cnt == 2 && i_vsync_pos == 1'b1)?1'b1:1'b0;
*/
reg  area11_wb;
reg  area12_wb;
reg  area13_wb;
reg  area14_wb;
reg  area15_wb;

always @(posedge pixelclk or  negedge reset_n) begin
  if(reset_n == 1'b0) begin
    area11_wb <= 1'b0;
	area12_wb <= 1'b0;
	area13_wb <= 1'b0;
	area14_wb <= 1'b0;
	area15_wb <= 1'b0;
  end
  else if(frame_cnt == 2 && i_vsync_pos == 1'b1)begin
    area11_wb <=(area11_cnt > `area2)?1'b1:1'b0;
	area12_wb <=(area12_cnt > `area2)?1'b1:1'b0;
	area13_wb <=(area13_cnt > `area2)?1'b1:1'b0;
	area14_wb <=(area14_cnt > `area2)?1'b1:1'b0;
	area15_wb <=(area15_cnt > `area2)?1'b1:1'b0;
  end
end

reg  area21_wb;
reg  area22_wb;
reg  area23_wb;
reg  area24_wb;
reg  area25_wb;

always @(posedge pixelclk or  negedge reset_n) begin
  if(reset_n == 1'b0) begin
    area21_wb <= 1'b0;
	area22_wb <= 1'b0;
	area23_wb <= 1'b0;
	area24_wb <= 1'b0;
	area25_wb <= 1'b0;
  end
  else if(frame_cnt == 2 && i_vsync_pos == 1'b1)begin
    area21_wb <=(area21_cnt > `area2)?1'b1:1'b0;
	area22_wb <=(area22_cnt > `area2)?1'b1:1'b0;
	area23_wb <=(area23_cnt > `area2)?1'b1:1'b0;
	area24_wb <=(area24_cnt > `area2)?1'b1:1'b0;
	area25_wb <=(area25_cnt > `area2)?1'b1:1'b0;
  end
end

reg  area31_wb;
reg  area32_wb;
reg  area33_wb;
reg  area34_wb;
reg  area35_wb;

always @(posedge pixelclk or  negedge reset_n) begin
  if(reset_n == 1'b0) begin
    area31_wb <= 1'b0;
	area32_wb <= 1'b0;
	area33_wb <= 1'b0;
	area34_wb <= 1'b0;
	area35_wb <= 1'b0;
  end
  else if(frame_cnt == 2 && i_vsync_pos == 1'b1)begin
    area31_wb <=(area31_cnt > `area2)?1'b1:1'b0;
	area32_wb <=(area32_cnt > `area2)?1'b1:1'b0;
	area33_wb <=(area33_cnt > `area2)?1'b1:1'b0;
	area34_wb <=(area34_cnt > `area2)?1'b1:1'b0;
	area35_wb <=(area35_cnt > `area2)?1'b1:1'b0;
  end
end

reg  area41_wb;
reg  area42_wb;
reg  area43_wb;
reg  area44_wb;
reg  area45_wb;

always @(posedge pixelclk or  negedge reset_n) begin
  if(reset_n == 1'b0) begin
    area41_wb <= 1'b0;
	area42_wb <= 1'b0;
	area43_wb <= 1'b0;
	area44_wb <= 1'b0;
	area45_wb <= 1'b0;
  end
  else if(frame_cnt == 2 && i_vsync_pos == 1'b1)begin
    area41_wb <=(area41_cnt > `area2)?1'b1:1'b0;
	area42_wb <=(area42_cnt > `area2)?1'b1:1'b0;
	area43_wb <=(area43_cnt > `area2)?1'b1:1'b0;
	area44_wb <=(area44_cnt > `area2)?1'b1:1'b0;
	area45_wb <=(area45_cnt > `area2)?1'b1:1'b0;
  end
end

reg  area51_wb;
reg  area52_wb;
reg  area53_wb;
reg  area54_wb;
reg  area55_wb;

always @(posedge pixelclk or  negedge reset_n) begin
  if(reset_n == 1'b0) begin
    area51_wb <= 1'b0;
	area52_wb <= 1'b0;
	area53_wb <= 1'b0;
	area54_wb <= 1'b0;
	area55_wb <= 1'b0;
  end
  else if(frame_cnt == 2 && i_vsync_pos == 1'b1)begin
    area51_wb <=(area51_cnt > `area2)?1'b1:1'b0;
	area52_wb <=(area52_cnt > `area2)?1'b1:1'b0;
	area53_wb <=(area53_cnt > `area2)?1'b1:1'b0;
	area54_wb <=(area54_cnt > `area2)?1'b1:1'b0;
	area55_wb <=(area55_cnt > `area2)?1'b1:1'b0;
  end
end

reg  area61_wb;
reg  area62_wb;
reg  area63_wb;
reg  area64_wb;
reg  area65_wb;

always @(posedge pixelclk or  negedge reset_n) begin
  if(reset_n == 1'b0) begin
    area61_wb <= 1'b0;
	area62_wb <= 1'b0;
	area63_wb <= 1'b0;
	area64_wb <= 1'b0;
	area65_wb <= 1'b0;
  end
  else if(frame_cnt == 2 && i_vsync_pos == 1'b1)begin
    area61_wb <=(area61_cnt > `area2)?1'b1:1'b0;
	area62_wb <=(area62_cnt > `area2)?1'b1:1'b0;
	area63_wb <=(area63_cnt > `area2)?1'b1:1'b0;
	area64_wb <=(area64_cnt > `area2)?1'b1:1'b0;
	area65_wb <=(area65_cnt > `area2)?1'b1:1'b0;
  end
end

reg  area71_wb;
reg  area72_wb;
reg  area73_wb;
reg  area74_wb;
reg  area75_wb;

always @(posedge pixelclk or  negedge reset_n) begin
  if(reset_n == 1'b0) begin
    area71_wb <= 1'b0;
	area72_wb <= 1'b0;
	area73_wb <= 1'b0;
	area74_wb <= 1'b0;
	area75_wb <= 1'b0;
  end
  else if(frame_cnt == 2 && i_vsync_pos == 1'b1)begin
    area71_wb <=(area71_cnt > `area2)?1'b1:1'b0;
	area72_wb <=(area72_cnt > `area2)?1'b1:1'b0;
	area73_wb <=(area73_cnt > `area2)?1'b1:1'b0;
	area74_wb <=(area74_cnt > `area2)?1'b1:1'b0;
	area75_wb <=(area75_cnt > `area2)?1'b1:1'b0;
  end
end

reg  area81_wb;
reg  area82_wb;
reg  area83_wb;
reg  area84_wb;
reg  area85_wb;

always @(posedge pixelclk or  negedge reset_n) begin
  if(reset_n == 1'b0) begin
    area81_wb <= 1'b0;
	area82_wb <= 1'b0;
	area83_wb <= 1'b0;
	area84_wb <= 1'b0;
	area85_wb <= 1'b0;
  end
  else if(frame_cnt == 2 && i_vsync_pos == 1'b1)begin
    area81_wb <=(area81_cnt > `area2)?1'b1:1'b0;
	area82_wb <=(area82_cnt > `area2)?1'b1:1'b0;
	area83_wb <=(area83_cnt > `area2)?1'b1:1'b0;
	area84_wb <=(area84_cnt > `area2)?1'b1:1'b0;
	area85_wb <=(area85_cnt > `area2)?1'b1:1'b0;
  end
end

//-------------------------------------------------------------
// result
//-------------------------------------------------------------
reg [39:0] char_r;
assign  char = char_r;



always @(posedge pixelclk or negedge reset_n) begin
  if(reset_n == 1'b0)
    char_r <= 40'b0;
  else if( frame_cnt == 2 && i_vsync_pos1 == 1'b1)
    char_r <= {area11_wb,area12_wb,area13_wb,area14_wb,area15_wb,
	           area21_wb,area22_wb,area23_wb,area24_wb,area25_wb,
			   area31_wb,area32_wb,area33_wb,area34_wb,area35_wb,
			   area41_wb,area42_wb,area43_wb,area44_wb,area45_wb,
			   area51_wb,area52_wb,area53_wb,area54_wb,area55_wb,
			   area61_wb,area62_wb,area63_wb,area64_wb,area65_wb,
			   area71_wb,area72_wb,area73_wb,area74_wb,area75_wb,
			   area81_wb,area82_wb,area83_wb,area84_wb,area85_wb};
			   			   
end

/*
wire [4:0] char1 = {area11_wb,area12_wb,area13_wb,area14_wb,area15_wb};
wire [4:0] char2 = {area21_wb,area22_wb,area23_wb,area24_wb,area25_wb};
wire [4:0] char3 = {area31_wb,area32_wb,area33_wb,area34_wb,area35_wb};
wire [4:0] char4 = {area41_wb,area42_wb,area43_wb,area44_wb,area45_wb};
wire [4:0] char5 = {area51_wb,area52_wb,area53_wb,area54_wb,area55_wb};
wire [4:0] char6 = {area61_wb,area62_wb,area63_wb,area64_wb,area65_wb};
wire [4:0] char7 = {area71_wb,area72_wb,area73_wb,area74_wb,area75_wb};
wire [4:0] char8 = {area81_wb,area82_wb,area83_wb,area84_wb,area85_wb};
*/

endmodule
`undef hcount15 
`undef hcount25 
`undef hcount35 
`undef hcount45 

`undef vcount18 
`undef vcount28 
`undef vcount38 
`undef vcount48 
`undef vcount58 
`undef vcount68 
`undef vcount78 

`undef w 
`undef h 
`undef area 
`undef area2 