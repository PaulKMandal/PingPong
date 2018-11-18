`timescale 1ns / 1ps
module ball(
    input clk,
    output [9:0] x,
    output [9:0] y
    );

	localparam MAX_X = 640;
	localparam MAX_Y = 480;
	localparam WALL_SIZE = 16;
	localparam BALL_SIZE = 16;

	reg [9:0] x_reg = MAX_X/2, y_reg = MAX_Y/2;
	reg signed [2:0] x_vel = 1, y_vel = 1;

	always @(posedge clk)
	begin
		if ( x_reg >= MAX_X - BALL_SIZE )
			x_vel <= -1;
		else if ( x_reg < WALL_SIZE )
			x_vel <= 1;
			
		if ( y_reg >= MAX_Y - (WALL_SIZE + BALL_SIZE) )
			y_vel <= -1;
		else if ( y_reg < WALL_SIZE )
			y_vel <= 1;

		x_reg <= x_reg + x_vel;
		y_reg <= y_reg + y_vel;
	end

	assign x = x_reg;
	assign y = y_reg;

endmodule
