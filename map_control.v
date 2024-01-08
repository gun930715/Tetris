


module map_control
(
	clk,
	reset,
	load_next_block,
	block,
	cur_x,
	cur_y,
	Red_map,
	Green_map,
	Blue_map,
	map,
);
	input clk;
	input reset;
	input load_next_block;
	input [0:3][0:3]block;
	input [3:0]cur_x;
	input [3:0]cur_y;
	input [0:7][0:7]Red_map;
	input [0:7][0:7]Green_map;
	input [0:7][0:7]Blue_map;
	output reg[0:8][0:11]map;
	parameter logic[0:8][0:11] init_map =
	{
		12'b111000000001,
		12'b111000000001,
		12'b111000000001,
		12'b111000000001,
		12'b111000000001,
		12'b111000000001,
		12'b111000000001,
		12'b111000000001,
		12'b111111111111
	};
	always@(posedge clk , posedge reset)
		begin
			if(reset)
				begin
					map <= init_map;
				end
			else
				begin
						for(integer i = 0;i<8;i=i+1)
								for(integer j = 0;j<8;j=j+1)
									map[i][j+3] <= Red_map[i][j] || Green_map[i][j] || Blue_map[i][j]; 
				end
		end

endmodule