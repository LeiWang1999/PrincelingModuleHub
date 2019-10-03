
`timescale 1ns/1ps

module digital_recognition(
       input               pixel_clk,
	   input               reset_n,
	   input     [23:0]    din,//binary 
       input               i_vsync,		
	   input     [11:0]    hcount,
       input     [11:0]    vcount,
	   input     [11:0]    hcount_l,//左边界
       input     [11:0]    hcount_r,//右边界
       input     [11:0]    vcount_l,//上边界
       input     [11:0]    vcount_r,//下边界
	   input               i_de,
	   input     [2:0]     frame_cnt,
	   
	   output reg          x1_l, //x1左
	   output reg          x1_r, //x1右
	   output reg          x2_l, 
	   output reg          x2_r,
	   output reg [3:0]    y,
	   output reg [3:0]    x1,
	   output reg [3:0]    x2,
	   
	   output  [11:0]      h2,
	   output  [11:0]      v5,
	   output  [11:0]      v3
	   );

parameter P_1_3 = 6'b010101;//1/3 0.333
parameter P_2_3 = 6'b101011;//2/3 0.667
parameter P_2_5 = 6'b010101;//2/5 0.4
parameter P_3_5 = 6'b101010;//3/5 0.6
		 
wire       y_flag;
reg        y_flag_r0;
reg        y_flag_r1;
wire       y_flag_fall;
reg        wr_y_en;
reg        rd_y_en;
reg [11:0] y_cnt;

reg TFT_VS_rise_r0;
reg TFT_VS_rise_r1;
reg TFT_VS_rise_r2;

reg     [17:0]    hcount_l_r;
reg     [17:0]    hcount_r_r;
reg     [17:0]    vcount_l_r;
reg     [17:0]    vcount_r_r;

reg [11:0] h_2; //(hcount_l + hcount_r)/2
reg [11:0] v_5; // (vcount_r - vcount_l)*2/5 + vcount_l
reg [11:0] v_3; // (vcount_r - vcount_l)*2/3 + vcount_l

reg [17:0] h_2_r; //(hcount_l + hcount_r)/2
reg [23:0] v_5_r; // (vcount_r - vcount_l)*2/5 + vcount_l
reg [23:0] v_3_r; // (vcount_r - vcount_l)*2/3 + vcount_l

wire              th_flag;  //threshold value
wire              th_flag_rise;
wire              th_flag_fall;
wire              TFT_VS_rise;
wire              TFT_VS_fall;
reg               th_flag_r0;
reg               vsync_r;

assign th_flag = (din == 24'hfff_fff)?1'b1:1'b0;
assign th_flag_rise = (th_flag & (!th_flag_r0));
assign th_flag_fall = ((!th_flag) & th_flag_r0);
assign TFT_VS_rise = (i_vsync & (!vsync_r));
assign TFT_VS_fall = ((!i_vsync) & vsync_r);
//pipiline
always @(posedge pixel_clk ) begin
  vsync_r <= i_vsync;
  th_flag_r0 <= th_flag;
  TFT_VS_rise_r0 <= TFT_VS_rise;
  TFT_VS_rise_r1 <= TFT_VS_rise_r0;
  TFT_VS_rise_r2 <= TFT_VS_rise_r1;
end
//-------------------------------------------------
// 1/2 x            2/5 y             2/3 y
//-------------------------------------------------
always @(posedge pixel_clk or negedge reset_n) begin  
  if(!reset_n) begin
    h_2 <= 12'd0;
	 v_5 <= 12'd0;
	 v_3 <= 12'd0;
	 h_2_r <= 18'd0;
	 v_5_r <= 23'd0;
	 v_3_r <= 23'd0;
    hcount_l_r <= 18'b0;
    hcount_r_r <= 18'b0;
    vcount_l_r <= 18'b0;
    vcount_r_r <= 18'b0;
  end
  else if(frame_cnt == 3'd2) begin
     if(TFT_VS_rise) begin
	    hcount_l_r <= {hcount_l,6'b0};//位扩展
       hcount_r_r <= {hcount_r,6'b0};
       vcount_l_r <= {vcount_l,6'b0};
       vcount_r_r <= {vcount_r,6'b0};
	  end
	  if(TFT_VS_rise_r0) begin
		 h_2_r <=  (hcount_r_r + hcount_l_r)>>1;       // y 线
		 //v_5_r <=  vcount_r_r*P_2_5 + vcount_l_r*P_3_5;//x1 线
		 //v_5_r <=  (vcount_r_r - vcount_l_r)*P_2_5 + vcount_l_r;
		 v_5_r <=  vcount_r_r*P_2_5 + vcount_l_r*P_3_5;//x1 线
		 v_3_r <=  vcount_r_r*P_2_3 + vcount_l_r*P_1_3;//x2 线
	  end
	  if(TFT_VS_rise_r1) begin
	      h_2 <= h_2_r[17:6]; //bit位还原
		 	v_5 <= v_5_r[23:12];
	      v_3 <= v_3_r[23:12];
	  end
  end
  else 
    ;
end


//------------------------------------------------------
// test
//------------------------------------------------------
assign h2 = h_2;
assign v5 = v_5;
assign v3 = v_3;

//----------------------------------------------------
// x1  x1_l x1_r
//----------------------------------------------------
always @(posedge pixel_clk or negedge reset_n) begin
  if(!reset_n)
    x1 <= 4'd0;
  else if(frame_cnt == 3'd2) begin
   if(TFT_VS_rise)//TFT_VS rising edge 
     x1 <= 4'd0;
   else if(vcount == v_5) 
    if(th_flag_fall && (hcount < hcount_r &&  hcount > hcount_l))
	   x1 <= x1 + 4'd1;
	 else
	   x1 <= x1;
  end
  else
     x1 <= x1;
end

always @(posedge pixel_clk or negedge reset_n) begin
  if(!reset_n)
    x1_l <= 1'b0;
  else if(frame_cnt == 3'd2) begin
   if(TFT_VS_rise)//TFT_VS rising edge 
    x1_l <= 1'b0;
   else if(vcount == v_5) //left
    if(th_flag_fall && (hcount > hcount_l) && (hcount < h_2))
	   x1_l <= 1'b1;
	 else
	   x1_l <= x1_l;
  end
  else
    x1_l <= x1_l;
end

always @(posedge pixel_clk or negedge reset_n) begin
  if(!reset_n)
    x1_r <= 1'b0;
  else if(frame_cnt == 3'd2) begin
   if(TFT_VS_rise)//TFT_VS rising edge 
     x1_r <= 1'b0;
   else if(vcount == v_5) 
     if(th_flag_fall && (hcount < hcount_r) && (hcount > h_2))
	    x1_r <= 1'b1;
	  else
	    x1_r <= x1_r;
  end
  else
    x1_r <= x1_r;
end

//----------------------------------------------------
// x2  x2_l x2_r
//----------------------------------------------------

always @(posedge pixel_clk or negedge reset_n) begin
  if(!reset_n)
    x2 <= 4'd0;
  else if(frame_cnt == 3'd2) begin
    if(TFT_VS_rise) //TFT_VS rising edge 
      x2 <= 4'd0;
    else if(vcount == v_3) 
      if(th_flag_fall && (hcount > hcount_l) && (hcount < hcount_r))
	     x2 <= x2 + 4'd1;
	   else
	     x2 <= x2;
  end
  else
    x2 <= x2;
end

always @(posedge pixel_clk or negedge reset_n) begin
  if(!reset_n)
    x2_l <= 1'b0;
  else if(frame_cnt == 3'd2) begin
    if(TFT_VS_rise)//TFT_VS rising edge 
      x2_l <= 1'b0;
    else if(vcount == v_3)
      if(th_flag_fall &&(hcount > hcount_l) && (hcount < h_2))
	     x2_l <= 1'b1;
	   else
	     x2_l <= x2_l;
  end
  else
    x2_l <= x2_l;
end

always @(posedge pixel_clk or negedge reset_n) begin
  if(!reset_n)
    x2_r <= 1'b0;
  else if(frame_cnt == 3'd2) begin
    if(TFT_VS_rise)//TFT_VS rising edge 
     x2_r <= 1'b0;
    else if(vcount == v_3)
      if(th_flag_fall && (hcount < hcount_r) && (hcount > h_2))
	     x2_r <= 1'b1;
	   else
	     x2_r <= x2_r;
  end
  else
    x2_r <= x2_r;
end

//----------------------------------------------------
// y
//----------------------------------------------------

always @(posedge pixel_clk or negedge reset_n) begin
  if(!reset_n) 
    y_cnt <= 12'd0;
  else if(frame_cnt == 3'd3 ||frame_cnt == 2'd1) begin
    if(TFT_VS_rise)//i_vsync rising edge 
      y_cnt <= 12'd480;
	else if(y_cnt == 12'd0)
      y_cnt <=  12'd0;
    else if(i_vsync)
      y_cnt <=  y_cnt - 12'd1;
  end
  else
    ;
end


always @(posedge pixel_clk or negedge reset_n) begin
  if(!reset_n) 
    rd_y_en <= 1'b0;
  else if(frame_cnt == 3'd3) begin
    if(i_vsync && (y_cnt > 0))
      rd_y_en <= 1'b1;
    else
      rd_y_en <= 1'b0;
  end
  else
    ;
end

always @(posedge pixel_clk or negedge reset_n) begin
  if(!reset_n) 
    wr_y_en <= 1'b0;
  else if(frame_cnt == 2'd1 && y_cnt > 0)
    wr_y_en <= 1'b1;
  else if(frame_cnt == 2'd2) begin 
    if(hcount == h_2 && i_de == 1'b1)
      wr_y_en <= 1'b1;
    else
      wr_y_en <= 1'b0;
  end
  else
    ;
end

always @(posedge pixel_clk ) begin
  y_flag_r0 <= y_flag;
  y_flag_r1 <= y_flag_r0;
end

assign y_flag_fall = (!y_flag_r0 && y_flag_r1) ? 1'b1:1'b0;

always @(posedge pixel_clk or negedge reset_n) begin
  if(!reset_n)
    y <= 4'd0;
  else if(frame_cnt == 2'd3) begin
    if(TFT_VS_rise)//TFT_VS rising edge 
      y <= 4'd0;
    else  if(y_flag_fall)
	   y <= y + 4'd1;
    else
	   y <= y;
  end
  else
   ;
end

wire th1 = 1;
wire th2;

assign th2 = (frame_cnt == 2'd1)?th1:th_flag;

fifo_y fifo_y_inst(
	   .clock(pixel_clk),
	   .reset_n(reset_n),
	   .data(th2),
	   .rdreq(rd_y_en),
	   .wrreq(wr_y_en),
	   .empty(),
	   .full(),
	   .q(y_flag),
	   .usedw());

endmodule 