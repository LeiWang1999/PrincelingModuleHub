`timescale 1ns/1ps

module car_id(
       input                            pix_clk,
       input                            reset_n,
       
       input          [23:0]            i_rgb,
       input          [23:0]            i_gray,
       input          [23:0]            i_ycbcr,
       input                            i_h_sync,
       input                            i_v_sync,
       input                            i_de,
     
       output           [23:0]          skin_binary_image,
       output           [23:0]          skin_rgb_image,
       output           [23:0]          skin_gray_image,
       output                           o_h_sync,
       output                           o_v_sync,                                                                                                  
       output                           o_de  
       );
       
//*****************************************
// skin detection parameter define
//*****************************************
parameter Y_LOW   = 8'd00 ;//8'd35;
parameter Y_HIGH  = 8'd100;
//parameter CB_LOW  = 8'd160;
//parameter CB_HIGH = 8'd192;
//parameter CR_LOW  = 8'd95;
//parameter CR_HIGH = 8'd120;

//parameter CB_LOW  = 8'd155;
//parameter CB_HIGH = 8'd195;
//parameter CR_LOW  = 8'd95;
//parameter CR_HIGH = 8'd125;

parameter CB_LOW  = 8'd10;
parameter CB_HIGH = 8'd200;
parameter CR_LOW  = 8'd10;
parameter CR_HIGH = 8'd200;
 
wire			         [7 : 0]		    y_8b;
wire               [7 : 0]         cb_8b;
wire               [7 : 0]         cr_8b; 

reg                                h_sync_delay;
reg                                v_sync_delay;                                                                                                  
reg                                de_delay;  

reg                [23:0]          skin_binary_r;
reg                [23:0]          skin_rgb_r;
reg                [23:0]          skin_gray_r;

assign  y_8b  = i_ycbcr[23:16];
assign  cb_8b = i_ycbcr[15:8];   
assign  cr_8b = i_ycbcr[7:0]; 

always @(posedge pix_clk or negedge reset_n) begin
  if(!reset_n) begin
    skin_binary_r <= 24'h000000;
    skin_rgb_r    <= 24'h000000;
    skin_gray_r   <= 24'h000000;
  end
  else if((cb_8b > CB_LOW && cb_8b < CB_HIGH) && (cr_8b > CR_LOW && cr_8b < CR_HIGH)) begin
    skin_binary_r <= 24'hfff_fff;
    skin_rgb_r    <= 24'hFFFFFF;
    skin_gray_r   <= 24'hFFFFFF;
  end
  else begin
    skin_binary_r <= 24'h000_000;
    skin_rgb_r    <= i_rgb;
    skin_gray_r   <= i_gray;
  end
end 

always @(posedge pix_clk) begin
  h_sync_delay <= i_h_sync;
  v_sync_delay <= i_v_sync;
  de_delay     <= i_de;
end 

assign o_h_sync = h_sync_delay;
assign o_v_sync = v_sync_delay;
assign o_de     = de_delay;

assign skin_binary_image = skin_binary_r;
assign skin_rgb_image    = skin_rgb_r;
assign skin_gray_image   = skin_gray_r;    
       
endmodule
