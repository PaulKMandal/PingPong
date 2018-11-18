// Listing 13.3
module pong_graph_st
   (
    input wire video_on,
    input wire [9:0] pix_x, pix_y,
	 input wire [9:0] ball_x, ball_y,
	 input wire [9:0] paddle_x, paddle_y,
    output reg [2:0] graph_rgb
   );

   // constant and signal declaration
   // x, y coordinates (0,0) to (639,479)
   localparam MAX_X = 640;
   localparam MAX_Y = 480;

   //--------------------------------------------
   // right vertical bar
   //--------------------------------------------
   // bar top, bottom boundary
   localparam PADDLE_WIDTH = 16;
   localparam PADDLE_HEIGHT = 64;
   //--------------------------------------------
   // ball
   //--------------------------------------------
   localparam BALL_SIZE = 16;

   //--------------------------------------------
   // object output signals
   //--------------------------------------------
   wire wall_on, bar_on, ball_on;
   wire [2:0] wall_rgb, paddle_rgb, ball_rgb;

   //--------------------------------------------
   // wall
   //--------------------------------------------
	localparam WALL_SIZE = 16;
   assign wall_on = pix_x < WALL_SIZE || pix_y < WALL_SIZE || pix_y >= MAX_Y-WALL_SIZE;
   // wall rgb output
   assign wall_rgb = 3'b001; // blue
   //--------------------------------------------
   // paddle
   //--------------------------------------------
   assign paddle_on = (pix_x >= paddle_x) && (pix_x < paddle_x + PADDLE_WIDTH) &&
                      (pix_y >= paddle_y) && (pix_y < paddle_y + PADDLE_HEIGHT);
   // paddle rgb output
   assign paddle_rgb = 3'b010; // green
   //--------------------------------------------
   // square ball
   //--------------------------------------------
   // pixel within squared ball
   assign ball_on =
             (pix_x >= ball_x) && (pix_x < ball_x + BALL_SIZE) &&
             (pix_y >= ball_y) && (pix_y < ball_y + BALL_SIZE);
   assign ball_rgb = 3'b100;   // red

   //--------------------------------------------
   // rgb multiplexing circuit
   //--------------------------------------------
   always @*
      if (~video_on)
         graph_rgb = 3'b000; // blank
      else
         if (wall_on)
            graph_rgb = wall_rgb;
         else if (paddle_on)
            graph_rgb = paddle_rgb;
         else if (ball_on)
            graph_rgb = ball_rgb;
         else
            graph_rgb = 3'b110; // yellow background

endmodule