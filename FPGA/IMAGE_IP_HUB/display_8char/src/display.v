
module display(
       input						    pixelclk,
	   input                            reset_n,

  	   input          [23:0]            i_rgb,
	   input						    i_hsync,
	   input							i_vsync,
	   input							i_de,
	   
	   input [11:0]                     hcount,
       input [11:0]                     vcount,
	   
	   input            [11:0]          hcount_l1,
       input            [11:0]          hcount_r1,
	   input            [11:0]          hcount_l2,
       input            [11:0]          hcount_r2,
	   input            [11:0]          hcount_l3,
       input            [11:0]          hcount_r3,
	   input            [11:0]          hcount_l4,
       input            [11:0]          hcount_r4,
	   input            [11:0]          hcount_l5,
       input            [11:0]          hcount_r5,
	   input            [11:0]          hcount_l6,
       input            [11:0]          hcount_r6,
	   input            [11:0]          hcount_l7,
       input            [11:0]          hcount_r7,
	   input            [11:0]          hcount_l8,
       input            [11:0]          hcount_r8,
       input            [11:0]          vcount_l,
       input            [11:0]          vcount_r,
	   
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
  else if (vcount > vcount_l && vcount < vcount_r && ( hcount == hcount_l1 || hcount == hcount_r1 || hcount == (hcount_l1 -1) || hcount == (hcount_r1+1)))
    rgb_r <= 24'hff000;
  else if (vcount > vcount_l && vcount < vcount_r && ( hcount == hcount_l2 || hcount == hcount_r2 || hcount == (hcount_l2 -1) || hcount == (hcount_r2+1)))
    rgb_r <= 24'hff000;
  else if (vcount > vcount_l && vcount < vcount_r && ( hcount == hcount_l3 || hcount == hcount_r3 || hcount == (hcount_l3 -1) || hcount == (hcount_r3+1)))
    rgb_r <= 24'hff000;
  else if (vcount > vcount_l && vcount < vcount_r && ( hcount == hcount_l4 || hcount == hcount_r4 || hcount == (hcount_l4 -1) || hcount == (hcount_r4+1)))
    rgb_r <= 24'hff000;
  else if (vcount > vcount_l && vcount < vcount_r && ( hcount == hcount_l5 || hcount == hcount_r5 || hcount == (hcount_l5 -1) || hcount == (hcount_r5+1)))
    rgb_r <= 24'hff000;
  else if (vcount > vcount_l && vcount < vcount_r && ( hcount == hcount_l6 || hcount == hcount_r6 || hcount == (hcount_l6 -1) || hcount == (hcount_r6+1)))
    rgb_r <= 24'hff000;
  else if (vcount > vcount_l && vcount < vcount_r && ( hcount == hcount_l7 || hcount == hcount_r7 || hcount == (hcount_l7 -1) || hcount == (hcount_r7+1)))
    rgb_r <= 24'hff000;
  else if (vcount > vcount_l && vcount < vcount_r && ( hcount == hcount_l8 || hcount == hcount_r8 || hcount == (hcount_l8 -1) || hcount == (hcount_r8+1)))
    rgb_r <= 24'hff000;
  else if (hcount > hcount_l1 && hcount < hcount_r1 && (vcount== vcount_l || vcount== vcount_r || vcount==( vcount_l - 1) || vcount== (vcount_r + 1)))
    rgb_r <= 24'hff00;
  else if (hcount > hcount_l2 && hcount < hcount_r2 && (vcount== vcount_l || vcount== vcount_r || vcount==( vcount_l - 1) || vcount== (vcount_r + 1)))
    rgb_r <= 24'hff00;
  else if (hcount > hcount_l3 && hcount < hcount_r3 && (vcount== vcount_l || vcount== vcount_r || vcount==( vcount_l - 1) || vcount== (vcount_r + 1)))
    rgb_r <= 24'hff00;
  else if (hcount > hcount_l4 && hcount < hcount_r4 && (vcount== vcount_l || vcount== vcount_r || vcount==( vcount_l - 1) || vcount== (vcount_r + 1)))
    rgb_r <= 24'hff00;
  else if (hcount > hcount_l5 && hcount < hcount_r5 && (vcount== vcount_l || vcount== vcount_r || vcount==( vcount_l - 1) || vcount== (vcount_r + 1)))
    rgb_r <= 24'hff00;
  else if (hcount > hcount_l6 && hcount < hcount_r6 && (vcount== vcount_l || vcount== vcount_r || vcount==( vcount_l - 1) || vcount== (vcount_r + 1)))
    rgb_r <= 24'hff00;
  else if (hcount > hcount_l7 && hcount < hcount_r7 && (vcount== vcount_l || vcount== vcount_r || vcount==( vcount_l - 1) || vcount== (vcount_r + 1)))
    rgb_r <= 24'hff00;
  else if (hcount > hcount_l8 && hcount < hcount_r8 && (vcount== vcount_l || vcount== vcount_r || vcount==( vcount_l - 1) || vcount== (vcount_r + 1)))
    rgb_r <= 24'hff00;
  else
    rgb_r <= i_rgb;
end 

endmodule