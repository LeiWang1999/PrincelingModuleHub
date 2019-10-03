/*****************************************************
A row of 8 target
******************************************************/

`timescale 1ns / 1ps

module Vertical_Projection8#(
       parameter IMG_WIDTH_LINE = 640,
       parameter IMG_WIDTH_DATA = 8
	   )(
       input                          pixelclk,
	   input                          reset_n,    
	   input  [IMG_WIDTH_DATA-1:0]    i_binary,
	   input                          i_hs,
	   input                          i_vs,
	   input                          i_de,       

	   input [11:0]                   i_hcount,
	   input [11:0]                   i_vcount,
	   
	   output     reg  [2:0]          frame_cnt,//0123
	   
	   output            [11:0]       hcount_l1,
       output            [11:0]       hcount_r1,
	   output            [11:0]       hcount_l2,
       output            [11:0]       hcount_r2,
	   output            [11:0]       hcount_l3,
       output            [11:0]       hcount_r3,
	   output            [11:0]       hcount_l4,
       output            [11:0]       hcount_r4,
	   output            [11:0]       hcount_l5,
       output            [11:0]       hcount_r5,
	   output            [11:0]       hcount_l6,
       output            [11:0]       hcount_r6,
	   output            [11:0]       hcount_l7,
       output            [11:0]       hcount_r7,
	   output            [11:0]       hcount_l8,
       output            [11:0]       hcount_r8,
       output            [11:0]       vcount_l,
       output            [11:0]       vcount_r

		 );
		 
parameter IDLE =   5'b00001;
parameter FRAME1 = 5'b00010;
parameter FRAME2 = 5'b00100;
parameter FRAME3 = 5'b01000;
parameter FRAME4 = 5'b10000;

wire                 TFT_VS_fall;
wire                 th_flag;
wire [11:0]          hcount;
wire [11:0]          vcount;
//reg  [2:0]          frame_cnt;

reg          hs_r;
reg          vs_r;
reg          de_r;

assign o_hs = hs_r;
assign o_vs = vs_r;
assign o_de = de_r;

assign TFT_VS_fall = (!i_vs & (vs_r))?1'b1:1'b0;

assign th_flag = (i_binary == 24'h000000)?1'b0:1'b1;

assign hcount = i_hcount;
assign vcount = i_vcount;

reg [4:0] c_state;
reg [4:0] n_state;

//reg [1:0] frame_cnt;
reg [11:0] i;

 reg  [11:0] hcount_l1_r;
 reg  [11:0] hcount_r1_r;
 reg  [11:0] hcount_l2_r;
 reg  [11:0] hcount_r2_r;
 reg  [11:0] hcount_l3_r;
 reg  [11:0] hcount_r3_r;
 reg  [11:0] hcount_l4_r;
 reg  [11:0] hcount_r4_r;
 reg  [11:0] hcount_l5_r;
 reg  [11:0] hcount_r5_r;
 reg  [11:0] hcount_l6_r;
 reg  [11:0] hcount_r6_r;
 reg  [11:0] hcount_l7_r;
 reg  [11:0] hcount_r7_r;
 reg  [11:0] hcount_l8_r;
 reg  [11:0] hcount_r8_r;
 
 reg  [11:0] vcount_l1_r;
 reg  [11:0] vcount_r1_r;
 reg  [11:0] vcount_l2_r;
 reg  [11:0] vcount_r2_r;
 
assign       hcount_l1 = hcount_l1_r;
assign       hcount_r1 = hcount_r1_r;
assign       hcount_l2 = hcount_l2_r;
assign       hcount_r2 = hcount_r2_r;
assign       hcount_l3 = hcount_l3_r;
assign       hcount_r3 = hcount_r3_r;
assign       hcount_l4 = hcount_l4_r;
assign       hcount_r4 = hcount_r4_r;
assign       hcount_l5 = hcount_l5_r;
assign       hcount_r5 = hcount_r5_r;
assign       hcount_l6 = hcount_l6_r;
assign       hcount_r6 = hcount_r6_r;
assign       hcount_l7 = hcount_l7_r;
assign       hcount_r7 = hcount_r7_r;
assign       hcount_l8 = hcount_l8_r;
assign       hcount_r8 = hcount_r8_r;

assign       vcount_l  = vcount_l1_r;
assign       vcount_r  = vcount_r1_r;
	 
reg h_we;
reg [11:0] h_waddr;
reg [11:0] h_raddr;
reg  h_di;
wire h_dout;
reg  h_dout_r;
reg  v_we;
reg [11:0] v_waddr;
reg [11:0] v_raddr;
reg  v_di;
wire v_dout;
reg  v_dout_r;
 
wire h_pedge = (h_dout & (!h_dout_r));
wire h_nedge = ((!h_dout) & h_dout_r);
wire v_pedge = (v_dout & (!v_dout_r));
wire v_nedge = ((!v_dout) & v_dout_r);
reg h_pedge_r;
reg h_nedge_r;
reg v_pedge_r;
reg v_nedge_r;

reg h_pedge_r0;
reg h_nedge_r0;
reg v_pedge_r0;
reg v_nedge_r0;


reg  [3:0] h_pedge_cnt;
reg  [3:0] h_nedge_cnt;
reg  [3:0] v_pedge_cnt;
reg  [3:0] v_nedge_cnt;


always @(posedge pixelclk ) begin
  hs_r    <= i_hs;
  vs_r     <= i_vs;
  de_r    <= i_de;
  
  h_dout_r <= h_dout;
  v_dout_r <= v_dout;
  
  h_pedge_r <= h_pedge;
  h_nedge_r <= h_nedge;
  v_pedge_r <= v_pedge;
  v_nedge_r <= v_nedge;
  
  h_pedge_r0 <= h_pedge_r;
  h_nedge_r0 <= h_nedge_r;
  v_pedge_r0 <= v_pedge_r;
  v_nedge_r0 <= v_nedge_r;
end

//-------------------------------------------------------------
//frame counter 0 1 2 3 4   0 1 2 3 4 ...
//-------------------------------------------------------------
always @(posedge pixelclk or negedge reset_n) begin
  if(!reset_n) 
    frame_cnt <=3'd0;
  else if(frame_cnt == 3'd4)
    frame_cnt <=3'd0;
  else if(TFT_VS_fall== 1'b1) //falling edge
    frame_cnt <= frame_cnt + 3'd1;
  else
    frame_cnt <= frame_cnt;   
end 


//FSM1
always @(posedge pixelclk or negedge reset_n) begin
  if(!reset_n) 
    c_state <= IDLE;
  else
    c_state <= n_state;
end


//FSM2
always @(posedge pixelclk or negedge reset_n) begin
  if(!reset_n) 
     n_state <= IDLE;
  else case(c_state)
    IDLE:begin
	   if(i > (IMG_WIDTH_LINE-1))      // initial ram
		  n_state <= FRAME1;
		else 
		  n_state <= IDLE;
	 end
	 FRAME1:begin
	   if(frame_cnt == 3'd1)
		  n_state <= FRAME2;
		else
		  n_state <= FRAME1;
	 end
	 FRAME2:begin
	   if(frame_cnt == 3'd2)
		  n_state <= FRAME3;
		else
		  n_state <= FRAME2;
	 end
	 FRAME3:begin
	   if(frame_cnt == 3'd3)
		  n_state <= FRAME4;
		else
		  n_state <= FRAME3;
	 end
	 FRAME4:begin
	   if(frame_cnt == 3'd0)
		  n_state <= FRAME1;
		else
		  n_state <= FRAME4;
	 end
  endcase      
end

//FMS3
always @(posedge pixelclk or negedge reset_n) begin
  if(!reset_n) begin 
    h_we <= 1'b0;
	 h_waddr <= 12'b0;
	 h_raddr <= 12'b0;
	 h_di <= 0;
	 v_we <= 1'b0;
	 v_waddr <= 12'b0;
	 v_raddr <= 12'b0;
	 v_di <= 0;
	 i <= 12'd0;
	 hcount_l1_r<= 12'b0;
     hcount_r1_r<= 12'b0;
	 hcount_l2_r<= 12'b0;
     hcount_r2_r<= 12'b0;
	 hcount_l3_r<= 12'b0;
     hcount_r3_r<= 12'b0;
	 
	 hcount_l4_r<= 12'b0;
	 hcount_r4_r<= 12'b0;
	 hcount_l5_r<= 12'b0;
	 hcount_r5_r<= 12'b0;
	 hcount_l6_r<= 12'b0;
	 hcount_r6_r<= 12'b0;
	 hcount_l7_r<= 12'b0;
	 hcount_r7_r<= 12'b0;
	 hcount_l8_r<= 12'b0;
	 hcount_r8_r<= 12'b0;
	 
     vcount_l1_r<= 12'b0;
     vcount_r1_r<= 12'b0;
	 vcount_l2_r<= 12'b0;
     vcount_r2_r<= 12'b0;
    //vcount_l3_r<= 12'b0;
    //vcount_r3_r<= 12'b0;
    h_pedge_cnt<=4'b0;
    h_nedge_cnt<=4'b0;
    v_pedge_cnt<=4'b0;
    v_nedge_cnt<=4'b0;
  end	 
  else case(c_state)
    IDLE: begin
	   if(i > (IMG_WIDTH_LINE-1)) begin
		  i<=i;
		  h_we <= 0;
		  h_waddr <= 0;
		  h_di <= 0;
		  v_we <= 0;
		  v_waddr <= 0;
		  v_di <= 0;
		end  
		else begin
		  i <= i +1;
		  h_we <= 1;
		  h_waddr <= h_waddr +1;
		  h_di <= 0;
		  v_we <= 1;
		  v_waddr <= v_waddr +1;
		  v_di <= 0;
		end
	 end
    FRAME1:begin
	 	  //h_raddr <= 0;
	     //v_raddr <= 0;
		  //h_pedge_cnt <= 4'b0;
		  //h_nedge_cnt <= 4'b0;
		  //v_pedge_cnt <= 4'b0;
		  //v_nedge_cnt <= 4'b0;
	   if((hcount > 5)&& (vcount > 5)&& (!th_flag)) begin
		  h_we <= 1;
		  h_waddr <= hcount;
		  h_di <= 1;
		  v_we <= 1;
		  v_waddr <= vcount;
		  v_di <= 1;
		end
		else begin
		  h_we <= 0;
		  h_waddr <= 0;
		  h_di <= 0;
		  v_we <= 0;
		  v_waddr <= 0;
		  v_di <= 0;
		end
	 end
	 FRAME2:begin
	  if(h_raddr < (IMG_WIDTH_LINE-1)) begin 
	     i <= 0;
	     h_raddr <= h_raddr + 1;
		  v_raddr <= v_raddr + 1;
		  
	    if(h_pedge) h_pedge_cnt <= h_pedge_cnt +1;
	    if(h_pedge_r0 && h_pedge_cnt == 1) hcount_l1_r <= (h_raddr-2);
	    if(h_pedge_r0 && h_pedge_cnt == 2) hcount_l2_r <= (h_raddr-2);
	    if(h_pedge_r0 && h_pedge_cnt == 3) hcount_l3_r <= (h_raddr-2);
	    if(h_pedge_r0 && h_pedge_cnt == 4) hcount_l4_r <= (h_raddr-2);
	    if(h_pedge_r0 && h_pedge_cnt == 5) hcount_l5_r <= (h_raddr-2);
	    if(h_pedge_r0 && h_pedge_cnt == 6) hcount_l6_r <= (h_raddr-2);
	    if(h_pedge_r0 && h_pedge_cnt == 7) hcount_l7_r <= (h_raddr-2);
		if(h_pedge_r0 && h_pedge_cnt == 8) hcount_l8_r <= (h_raddr-2);
	  
	    if(h_nedge) h_nedge_cnt <= h_nedge_cnt +1;
	    if(h_nedge_r0 && h_nedge_cnt == 1) hcount_r1_r <= (h_raddr-3);
	    if(h_nedge_r0 && h_nedge_cnt == 2) hcount_r2_r <= (h_raddr-3);
	    if(h_nedge_r0 && h_nedge_cnt == 3) hcount_r3_r <= (h_raddr-3);
		if(h_nedge_r0 && h_nedge_cnt == 4) hcount_r4_r <= (h_raddr-3);
	    if(h_nedge_r0 && h_nedge_cnt == 5) hcount_r5_r <= (h_raddr-3);
	    if(h_nedge_r0 && h_nedge_cnt == 6) hcount_r6_r <= (h_raddr-3);
	    if(h_nedge_r0 && h_nedge_cnt == 7) hcount_r7_r <= (h_raddr-3);
		if(h_nedge_r0 && h_nedge_cnt == 8) hcount_r8_r <= (h_raddr-3);
		 
		if(v_pedge) v_pedge_cnt <= v_pedge_cnt +1;
	    if(v_pedge_r0 && v_pedge_cnt == 1) vcount_l1_r <= (v_raddr-2);
	    if(v_pedge_r0 && v_pedge_cnt == 2) vcount_l2_r <= v_raddr;
		//if(v_pedge_r0 && v_pedge_cnt == 3) vcount_l3_r <= v_raddr;
	  
	    if(v_nedge) v_nedge_cnt <= v_nedge_cnt +1;
	    if(v_nedge_r0 && v_nedge_cnt == 1) vcount_r1_r <= (v_raddr-3);
	    if(v_nedge_r0 && v_nedge_cnt == 2) vcount_r2_r <= v_raddr;
		//if(v_nedge_r0 && v_nedge_cnt == 3) vcount_r3_r <= v_raddr;
	  end
	  else begin
	     h_pedge_cnt <= h_pedge_cnt;
		 h_nedge_cnt <= h_nedge_cnt;
		  
		 v_pedge_cnt <= v_pedge_cnt;
		 v_nedge_cnt <= v_nedge_cnt;
		  
		 h_raddr <= h_raddr;
	     v_raddr <= v_raddr;
	    if(i < (IMG_WIDTH_LINE-1)) begin
		  i <= i + 1;
		  h_we <= 1;
		  h_waddr <= h_waddr +1;
		  h_di <= 0;
		  v_we <= 1;
		  v_waddr <= v_waddr +1;
		  v_di <= 0;
		 end	
		 else begin
		  i<=i;
		  h_we <= 0;
		  h_waddr <= 0;
		  h_di <= 0;
		  v_we <= 0;
		  v_waddr <= 0;
		  v_di <= 0;
		 end
	  end
	 end
	 FRAME3:begin
	   h_raddr <= 0;
	   v_raddr <= 0;
		h_pedge_cnt <= 4'b0;
		h_nedge_cnt <= 4'b0;
		v_pedge_cnt <= 4'b0;
		v_nedge_cnt <= 4'b0;
	 end
  endcase
end

		 
vp_ram h_ram_inst (
  .clka(pixelclk),    // input wire clka
  .wea(h_we),      // input wire [0 : 0] wea
  .addra(h_waddr),  // input wire [10 : 0] addra
  .dina(h_di),    // input wire [0 : 0] dina
  .clkb(pixelclk),    // input wire clkb
  .addrb(h_raddr),  // input wire [10 : 0] addrb
  .doutb(h_dout)  // output wire [0 : 0] doutb
);

vp_ram v_ram_inst (
  .clka(pixelclk),    // input wire clka
  .wea(v_we),      // input wire [0 : 0] wea
  .addra(v_waddr),  // input wire [10 : 0] addra
  .dina(v_di),    // input wire [0 : 0] dina
  .clkb(pixelclk),    // input wire clkb
  .addrb(v_raddr),  // input wire [10 : 0] addrb
  .doutb(v_dout)  // output wire [0 : 0] doutb
);
endmodule 
