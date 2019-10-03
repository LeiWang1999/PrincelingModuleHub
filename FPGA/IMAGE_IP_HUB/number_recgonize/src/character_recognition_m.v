module number_recognition(
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
       output         [15:0]			number   
);


/*
		Reg		Define
*/
wire		TFT_VS;
wire		TFT_VCLK;
wire		rst_n;
reg         TFT_VS_r0;
reg         TFT_VS_r1;
reg         TFT_VS_r2;
reg         TFT_VS_r3;
reg         TFT_VS_r4;
wire        TFT_VS_rise;
wire        TFT_VS_rise0;
wire        TFT_VS_rise1;
wire        TFT_VS_rise2;
wire        TFT_VS_fall;


//digit 0
wire       x1_l;
wire       x1_r;
wire       x2_l;
wire       x2_r;
wire [3:0] x1;	
wire [3:0] x2;
wire [3:0] y;


wire		th_flag;
reg         th_flag_r0;  //dark 1 white 0
reg         th_flag_r1;  //dark 1 white 0
wire        th_flag_rise;
wire        th_flag_fall;

reg			[3:0]	digit_id;

assign		o_digit_id = digit_id;
assign	TFT_VS	=	i_vsync;
assign	TFT_VCLK	=	pixelclk;
assign	rst_n		=	reset_n;
//-----------------------------------
//pipeline  
//-----------------------------------		
always @(posedge TFT_VCLK) begin
  		TFT_VS_r0 <= TFT_VS;
  		TFT_VS_r1 <= TFT_VS_r0;
  		TFT_VS_r2 <= TFT_VS_r1;
  		TFT_VS_r3 <= TFT_VS_r2;
  		TFT_VS_r4 <= TFT_VS_r3;

  		th_flag_r0 <= th_flag;
  		th_flag_r1 <= th_flag_r0;
end

//--------------------------------------------------------------
// rise or fall flag
//--------------------------------------------------------------
assign th_flag_rise = (th_flag_r0 && (!th_flag_r1)) ? 1'b1:1'b0;  //
assign th_flag_fall = ((!th_flag_r0) && th_flag_r1) ? 1'b1:1'b0;  //
assign TFT_VS_rise  = (TFT_VS_r0 && (!TFT_VS_r1)) ? 1'b1 :1'b0;   //VS rise edge
assign TFT_VS_rise0  = (TFT_VS_r1 && (!TFT_VS_r2)) ? 1'b1 :1'b0;   //VS rise edge
assign TFT_VS_rise1  = (TFT_VS_r2 && (!TFT_VS_r3)) ? 1'b1 :1'b0;   //VS rise edge
assign TFT_VS_rise2  = (TFT_VS_r3 && (!TFT_VS_r4)) ? 1'b1 :1'b0;   //VS rise edge
assign TFT_VS_fall  = ((!TFT_VS_r0) && TFT_VS_r1) ? 1'b1 :1'b0;   //VS fall edge


//-------------------------------------------------------------
// threshold value
//-------------------------------------------------------------

assign th_flag = (i_rgb == 24'h000000)?1'b0:1'b1;	//	white	0	dark	1




digital_recognition digital_recognition_inst0(
    .TFT_VCLK(TFT_VCLK),
	.TFT_VS(TFT_VS),		//	*	Done
	.rst_n(rst_n),			//	*	Done
	.th_flag(th_flag),		//	*	Done;
	.th_flag_rise(th_flag_rise),	//	*	Done
    .th_flag_fall(th_flag_fall),	//	*	Done
    .TFT_VS_rise(TFT_VS_rise),		//	*	Done
    .TFT_VS_fall(TFT_VS_fall),		//	*	Done
	.frame_cnt(frame_cnt),		
	.hcount(hcount),
    .vcount(vcount),
	.hcount_l(hcount_l),
    .hcount_r(hcount_r),
    .vcount_l(vcount_l),
    .vcount_r(vcount_r),
	.x1_l(x1_l),				//	*	Done
	.x1_r(x1_r),				//	*	Done
	.x2_l(x2_l),				//	*	Done
	.x2_r(x2_r),				//	*	Done
	.y(y),						//	*	Done
	.x1(x1),					//	*	Done
	.x2(x2)						//	*	Done
);

always @(posedge TFT_VCLK or negedge rst_n) begin
  if(!rst_n)
    digit_id <= 4'h0;
  else if((frame_cnt == 3'd1) && TFT_VS_rise0)
    case(number)             //特征统计数据对应列表
	   	16'b1111_0010_0010_0010: digit_id <= 4'h0; //0
		16'b1010_0001_0001_0001: digit_id <= 4'h1; //1
		16'b0110_0011_0001_0001: digit_id <= 4'h2; //2
		16'b0101_0011_0001_0001: digit_id <= 4'h3; //3
		16'b1101_0010_0010_0001: digit_id <= 4'h4; //4
		16'b1001_0011_0001_0001: digit_id <= 4'h5; //5
		16'b1011_0011_0001_0010: digit_id <= 4'h6; //6
		16'b0110_0010_0001_0001: digit_id <= 4'h7; //7
		16'b1111_0011_0010_0010: digit_id <= 4'h8; //8
		16'b1101_0011_0010_0001: digit_id <= 4'h9; //9
		default: digit_id <= 32'b0;
	 endcase
  else
	 digit_id <= digit_id; 
end



assign	number	=	((frame_cnt == 3'd1) && TFT_VS_rise0)?{x1_l,x1_r,x2_l,x2_r,y,x1,x2}:number;	//	4	+	4	+	4	+	4	=	16

endmodule