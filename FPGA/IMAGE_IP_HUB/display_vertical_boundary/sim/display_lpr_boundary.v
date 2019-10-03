
module display_veritical_boundary(
       input						    pixelclk,
	   input                            reset_n,

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
	   
       output         [23:0]            o_rgb,
	   output							o_hsync,
	   output							o_vsync,                                                                                                  
	   output						    o_de                                                                                               
	   );

reg	   [23:0]             rgb_r;	
reg                       hsync_r;
reg                       vsync_r;
reg                       de_r;
       
always @(posedge pixelclk) begin
  hsync_r <= i_hsync;
  vsync_r <= i_vsync;
  de_r    <= i_de;
end

assign o_hsync = hsync_r;
assign o_vsync = vsync_r;
assign o_de    = de_r;
assign o_rgb   = rgb_r;  
//-------------------------------------------------------------
// Display
//-------------------------------------------------------------
always @(posedge pixelclk or negedge reset_n) begin
  if(!reset_n) 
    rgb_r <= 24'h00000;
  else if (vcount > vcount_l && vcount < vcount_r && ( hcount == hcount_l || hcount == hcount_r || hcount == (hcount_l -1) || hcount == (hcount_r+1)))
    rgb_r <= 24'hff000;
  else if (hcount > hcount_l && hcount < hcount_r && (vcount== vcount_l || vcount== vcount_r || vcount==( vcount_l - 1) || vcount== (vcount_r + 1)))
    rgb_r <= 24'hff00;
  else
    rgb_r <= i_rgb;
end 

endmodule