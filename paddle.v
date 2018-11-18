`timescale 1ns / 1ps
module paddle(
    input clk,
	 input up,
	 input down,
    output [9:0] x,
    output [9:0] y
    );

	localparam MAX_X = 640;
	localparam MAX_Y = 480;
	localparam WIDTH = 16;
	localparam HEIGHT = 64;
	localparam WALL_SIZE = 16;

	reg [9:0] x_reg = MAX_X - WIDTH;
	reg [9:0] y_reg = MAX_Y / 2;
	
	always @(posedge clk)
	begin
		if ( up && y_reg >= WALL_SIZE )
			y_reg <= y_reg - 1;
		else if ( down && y_reg < MAX_Y - WALL_SIZE - HEIGHT )
			y_reg <= y_reg + 1;
	end
	
	assign x = x_reg;
	assign y = y_reg;

endmodule
