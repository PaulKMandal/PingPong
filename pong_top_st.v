// Listing 13.4
module pong_top_st
   (
    input wire clk, reset,
	 input wire up, down,
    output wire hsync, vsync,
    output wire [2:0] rgb
   );

   // signal declaration
   wire [9:0] pixel_x, pixel_y;
   wire video_on, pixel_tick, v_end;
   reg [2:0] rgb_reg;
   wire [2:0] rgb_next;
	
	// ball
	wire [9:0] ball_x, ball_y;
	ball ball_unit(.clk(v_end), .x(ball_x), .y(ball_y));
	
	// paddle
	wire [9:0] paddle_x, paddle_y;
	paddle paddle_unit(.clk(v_end), .up(up), .down(down),
	                   .x(paddle_x), .y(paddle_y));

   // body
   // instantiate vga sync circuit
   vga_sync vsync_unit
      (.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync),
       .video_on(video_on), .p_tick(pixel_tick),
       .pixel_x(pixel_x), .pixel_y(pixel_y), .v_end(v_end));
   // instantiate graphic generator
   pong_graph_st pong_grf_unit
      (.video_on(video_on), .pix_x(pixel_x), .pix_y(pixel_y),
       .graph_rgb(rgb_next), .ball_x(ball_x), .ball_y(ball_y),
		 .paddle_x(paddle_x), .paddle_y(paddle_y));
   // rgb buffer
   always @(posedge clk)
      if (pixel_tick)
         rgb_reg <= rgb_next;
   // output
   assign rgb = rgb_reg;

endmodule
