module Load_block
(
	clk,
	clk_1Hz,
	reset,
	move_down_en,
	load_next_block,
	fall_down
);
	input clk;
	input clk_1Hz;
	input reset;
	input move_down_en;
	input fall_down;
	
	output reg load_next_block;
	reg map_update;
	
	
	always@(negedge clk,posedge reset)
		if(reset)
			load_next_block <= 0;
		else
			load_next_block <= fall_down && !move_down_en;
endmodule