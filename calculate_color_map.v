module calculate_color_map
(
	clk,
	reset,
	block_window,
	color,
	cur_x,
	cur_y,
	remove_line,
	load_next_block,
	color_map_r,
	color_map_display
	
);
	//--------------------------------
	input clk;
	input reset;
	input [0:3][0:3]block_window;
	input color;
	input [3:0]cur_x;
	input [3:0]cur_y;
	input [7:0]remove_line;
	input load_next_block;
	
	output reg [0:7][0:7]color_map_display;
	output reg [0:7][0:7]color_map_r;
	//--------------------------------
	
	
	integer i;
	integer j;
	
	parameter logic[0:7][0:7] init_map =
	{
		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b00000000
	};
	// color map_r update
	always@(posedge clk,posedge reset)
		begin
			if(reset)
				begin
					color_map_r <= init_map;
				end
			else
				begin
					if(remove_line[7])
						begin
							color_map_r[7]<=color_map_r[6];
							color_map_r[6]<=color_map_r[5];
							color_map_r[5]<=color_map_r[4];
							color_map_r[4]<=color_map_r[3];
							color_map_r[3]<=color_map_r[2];
							color_map_r[2]<=color_map_r[1];
							color_map_r[1]<=color_map_r[0];
							color_map_r[0]<=8'b00000000;
						end
					else if(remove_line[6])
						begin
							color_map_r[7]<=color_map_r[7];
							color_map_r[6]<=color_map_r[5];
							color_map_r[5]<=color_map_r[4];
							color_map_r[4]<=color_map_r[3];
							color_map_r[3]<=color_map_r[2];
							color_map_r[2]<=color_map_r[1];
							color_map_r[1]<=color_map_r[0];
							color_map_r[0]<=8'b00000000;
						end
					else if(remove_line[5])
						begin
							color_map_r[7]<=color_map_r[7];
							color_map_r[6]<=color_map_r[6];
							color_map_r[5]<=color_map_r[4];
							color_map_r[4]<=color_map_r[3];
							color_map_r[3]<=color_map_r[2];
							color_map_r[2]<=color_map_r[1];
							color_map_r[1]<=color_map_r[0];
							color_map_r[0]<=8'b00000000;
						end
					else if(remove_line[4])
						begin
							color_map_r[7]<=color_map_r[7];
							color_map_r[6]<=color_map_r[6];
							color_map_r[5]<=color_map_r[5];
							color_map_r[4]<=color_map_r[3];
							color_map_r[3]<=color_map_r[2];
							color_map_r[2]<=color_map_r[1];
							color_map_r[1]<=color_map_r[0];
							color_map_r[0]<=8'b00000000;
						end
					else if(remove_line[3])
						begin
							color_map_r[7]<=color_map_r[7];
							color_map_r[6]<=color_map_r[6];
							color_map_r[5]<=color_map_r[5];
							color_map_r[4]<=color_map_r[4];
							color_map_r[3]<=color_map_r[2];
							color_map_r[2]<=color_map_r[1];
							color_map_r[1]<=color_map_r[0];
							color_map_r[0]<=8'b00000000;
						end
					else if(remove_line[2])
						begin
							color_map_r[7]<=color_map_r[7];
							color_map_r[6]<=color_map_r[6];
							color_map_r[5]<=color_map_r[5];
							color_map_r[4]<=color_map_r[4];
							color_map_r[3]<=color_map_r[3];
							color_map_r[2]<=color_map_r[1];
							color_map_r[1]<=color_map_r[0];
							color_map_r[0]<=8'b00000000;
						end
					else if(remove_line[1])
						begin
							color_map_r[7]<=color_map_r[7];
							color_map_r[6]<=color_map_r[6];
							color_map_r[5]<=color_map_r[5];
							color_map_r[4]<=color_map_r[4];
							color_map_r[3]<=color_map_r[3];
							color_map_r[2]<=color_map_r[2];
							color_map_r[1]<=color_map_r[0];
							color_map_r[0]<=8'b00000000;
						end
					else if(color == 1'b1 && load_next_block)
						for(i = 0;i<4;i=i+1)
								for(j = 0;j<4;j=j+1)
									if(cur_y + i < 8 && cur_x + j-3 >= 0 && cur_x + j-3 < 8)
										color_map_r[cur_y+i][cur_x+j-3] <= color_map_r[cur_y+i][cur_x+j-3] || block_window[i][j];
				end
		end
	always@(posedge clk,posedge reset)
		begin
			if(reset)
				color_map_display <= init_map;
			else
				begin
				
					color_map_display <= color_map_r;
					
					if(color == 1'b1)
						begin
							for(i = 0;i<4;i=i+1)
								for(j = 0;j<4;j=j+1)
									if(cur_y + i < 8 && cur_x + j-3 >= 0 && cur_x + j-3 < 8)
										color_map_display[cur_y+i][cur_x+j-3] <= color_map_r[cur_y+i][cur_x+j-3] || block_window[i][j];
						end
				end
		end
	
endmodule