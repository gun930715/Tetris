module block_control
(
		clk,
		clk_1Hz,
		reset,
		load_next_block,
		fall_down,
		move_left,
		move_right,
		move_down,
		move_left_en,
		move_right_en,
		move_down_en,
		cur_x,
		cur_y
);
	input clk;
	input clk_1Hz;
	input reset;
	input load_next_block;
	input fall_down;
	input	move_left;
	input	move_right;
	input	move_down;
	input move_left_en;
	input move_right_en;
	input move_down_en;
	output reg [3:0]cur_x;
	output reg [3:0]cur_y;
	
	// 控制
	always@(posedge clk,posedge reset)
		begin
			if(reset)
				begin
					cur_x <= 3;
					cur_y <= 0;
				end
			else if(load_next_block)
				begin
					cur_x <= 3;
					cur_y <= 0;
				end
			else if(move_left && move_left_en && (cur_x - 1) != 0 )
				cur_x <= cur_x - 1'b1;
			else if(move_right && move_right_en && (cur_x + 1) != 9) 
				cur_x <= cur_x + 1'b1;
			else if(move_down && move_down_en)
				cur_y <= cur_y + 1'b1;
			else if(fall_down && move_down_en)
				cur_y <= cur_y + 1'b1;
		end
		
//	always@(posedge clk,posedge reset)
//		begin
//			if(reset)
//				cur_y <= 0;
//			else if(load_next_block)
//				cur_y <= 0;
//			else if(move_down && move_down_en)
//				cur_y <= cur_y + 1'b1;
//			else if(fall_down && move_down_en)
//				cur_y <= cur_y + 1'b1;
//		end
	
	
endmodule