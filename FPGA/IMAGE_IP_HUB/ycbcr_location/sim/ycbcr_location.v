
`timescale 1ns / 1ps

module ycbcr_location#(
       parameter IMG_WIDTH_DATA = 24,
	   parameter Y_LOW   = 8'd0,
       parameter Y_HIGH  = 8'd0,
       parameter CB_LOW  = 123,
       parameter CB_HIGH = 165,
       parameter CR_LOW  = 110,
       parameter CR_HIGH = 132
       )(
       input                            pixelclk,
       input                            reset_n,
       
       input[IMG_WIDTH_DATA-1:0]        i_rgb,
       input[IMG_WIDTH_DATA-1:0]        i_gray,
       input[IMG_WIDTH_DATA-1:0]        i_ycbcr,
       input                            i_hsync,
       input                            i_vsync,
       input                            i_de,
     
       output[IMG_WIDTH_DATA-1:0]       binary_image,
       output[IMG_WIDTH_DATA-1:0]       rgb_image,
       output[IMG_WIDTH_DATA-1:0]       gray_image,
       output                           o_hsync,
       output                           o_vsync,                                                                                                  
       output                           o_de  
       );
wire			   [IMG_WIDTH_DATA/3-1 : 0]		  y_8b;
wire               [IMG_WIDTH_DATA/3-1 : 0]       cb_8b;
wire               [IMG_WIDTH_DATA/3-1 : 0]       cr_8b; 

reg                                               h_sync_delay;
reg                                               v_sync_delay;                                                                                                  
reg                                               de_delay;  

reg                [IMG_WIDTH_DATA-1:0]           binary_r;
reg                [IMG_WIDTH_DATA-1:0]           rgb_r;
reg                [IMG_WIDTH_DATA-1:0]           gray_r;

assign  y_8b  = i_ycbcr[23:16];
assign  cb_8b = i_ycbcr[15:8];   
assign  cr_8b = i_ycbcr[7:0]; 

always @(posedge pixelclk or negedge reset_n) begin
  if(!reset_n) begin
    binary_r <= 24'h000000;
    rgb_r    <= 24'h000000;
    gray_r   <= 24'h000000;
  end
  else if((cb_8b > CB_LOW && cb_8b < CB_HIGH) && (cr_8b > CR_LOW && cr_8b < CR_HIGH)) begin
    binary_r <= 24'b000_000;
    rgb_r    <= i_rgb;
    gray_r   <= i_gray;
  end
  else begin
    binary_r <= 24'hFFFFFF;
    rgb_r    <= 24'hFFFFFF;
    gray_r   <= 24'hFFFFFF;
  end
end 

always @(posedge pixelclk) begin
  h_sync_delay <= i_hsync;
  v_sync_delay <= i_vsync;
  de_delay     <= i_de;
end 

assign o_hsync = h_sync_delay;
assign o_vsync = v_sync_delay;
assign o_de     = de_delay;

assign binary_image = binary_r;
assign rgb_image    = rgb_r;
assign gray_image   = gray_r;    
       
endmodule
