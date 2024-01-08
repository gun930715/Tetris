module block_control_check
(
		clk,
		clk_1Hz,
		reset,
		map,
		block,
		cur_x,
		cur_y,
		fall_down,
		move_left_en,
		move_right_en,
		move_down_en,
		rotate_en,
		rotate_test_block
);
	// I型方塊
	parameter logic [0:3][0:3]block_type_I=
	{
		4'b1111,
		4'b0000,
		4'b0000,
		4'b0000
	};
	parameter logic [0:3][0:3]block_type_I1=
	{
		4'b0010,
		4'b0010,
		4'b0010,
		4'b0010
	};
	// O型方塊
	parameter logic [0:3][0:3]block_type_O=
	{
		4'b0110,
		4'b0110,
		4'b0000,
		4'b0000
	};
	// S型方塊
	parameter logic [0:3][0:3]block_type_S=
	{
		4'b0110,
		4'b1100,
		4'b0000,
		4'b0000
	};
	parameter logic [0:3][0:3]block_type_S1=
	{
		4'b0100,
		4'b0110,
		4'b0010,
		4'b0000
	};
	// Z型方塊
	parameter logic [0:3][0:3]block_type_Z=
	{
		4'b1100,
		4'b0110,
		4'b0000,
		4'b0000
	};
	parameter logic [0:3][0:3]block_type_Z1=
	{
		4'b0010,
		4'b0110,
		4'b0100,
		4'b0000
	};
	// J型方塊
	parameter logic [0:3][0:3]block_type_J=
	{
		4'b1000,
		4'b1110,
		4'b0000,
		4'b0000
	};
	parameter logic [0:3][0:3]block_type_J1=
	{
		4'b1100,
		4'b1000,
		4'b1000,
		4'b0000
	};
	parameter logic [0:3][0:3]block_type_J2=
	{
		4'b1110,
		4'b0010,
		4'b0000,
		4'b0000
	};
	parameter logic [0:3][0:3]block_type_J3=
	{
		4'b0100,
		4'b0100,
		4'b1100,
		4'b0000
	};
	// L型方塊
	parameter logic [0:3][0:3]block_type_L=
	{
		4'b0010,
		4'b1110,
		4'b0000,
		4'b0000
	};
	parameter logic [0:3][0:3]block_type_L1=
	{
		4'b0100,
		4'b0100,
		4'b0110,
		4'b0000
	};
	parameter logic [0:3][0:3]block_type_L2=
	{
		4'b1110,
		4'b1000,
		4'b0000,
		4'b0000
	};
	parameter logic[0:3][0:3]block_type_L3=
	{
		4'b0110,
		4'b0010,
		4'b0010,
		4'b0000
	};
	// T型方塊
	parameter logic[0:3][0:3] block_type_T=
	{
		4'b0100,
		4'b1110,
		4'b0000,
		4'b0000
	};
	parameter logic[0:3][0:3] block_type_T1=
	{
		4'b0100,
		4'b0110,
		4'b0100,
		4'b0000
	};
	parameter logic[0:3][0:3] block_type_T2=
	{
		4'b0000,
		4'b1110,
		4'b0100,
		4'b0000
	};
	parameter logic[0:3][0:3] block_type_T3=
	{
		4'b0100,
		4'b1100,
		4'b0100,
		4'b0000
	};
	input clk;
	input clk_1Hz;
	input reset;
	input [0:8][0:11]map;
	input [0:3][0:3]block;
	input [3:0]cur_x;
	input [3:0]cur_y;
	output reg fall_down;
	output reg move_left_en;
	output reg move_right_en;
	output reg move_down_en;
	output reg rotate_en;
	output reg [0:3][0:3]rotate_test_block;
	
	reg [15:0]chk_left;
	reg [15:0]chk_right;
	reg [15:0]chk_down;
	reg [15:0]chk_rotate;
	reg [24:0]count;
	
	parameter [24:0]times = 11000;

	always@(posedge clk,posedge reset)
		if(reset)
			begin
				chk_left<= 16'b1;
				chk_right<= 16'b1;
				chk_down<= 16'b1;
				chk_rotate <= 16'b1;
			end
		else 
			begin
				for(integer i=0;i<4;i=i+1)
					for(integer j=0;j<4;j=j+1)
						begin	
							chk_left[i*4+j] 	=	block[i][j] && map[cur_y+i][cur_x+j-1];
							chk_right[i*4+j] 	=	block[i][j] &&	map[cur_y+i][cur_x+j+1];
							chk_down[i*4+j] 	=	block[i][j] &&	map[cur_y+i+1][cur_x+j];
							chk_rotate[i*4+j] = 	rotate_test_block[i][j] && map[cur_y+i][cur_x+j];
						end	
				move_left_en 	<= !(|chk_left);
				move_right_en 	<= !(|chk_right);
				move_down_en 	<= !(|chk_down);
				rotate_en 		<=	!(|chk_rotate);
			end
			
	// 方塊落下 頻率可改
	always@(posedge clk,posedge reset)
		if(reset)
			begin 
				fall_down <= 0;
				count <= 0;
			end
		else
			begin
				if(count < times)
					count <= count + 1'b1;
				else			
						count <= 0;
				fall_down <= (count == times);
			end
			
	always@(posedge clk ,posedge reset)
		if(reset)
			rotate_test_block <= block_type_I1;
		else
			begin
				case(block)
						block_type_I 	: rotate_test_block <= block_type_I1;
						block_type_I1 	: rotate_test_block <= block_type_I;
						block_type_O	: rotate_test_block <= block_type_O;
						block_type_S	: rotate_test_block <= block_type_S1;
						block_type_S1	: rotate_test_block <= block_type_S;
						block_type_Z 	: rotate_test_block <= block_type_Z1;
						block_type_Z1 	: rotate_test_block <= block_type_Z;
						block_type_J 	: rotate_test_block <= block_type_J1;
						block_type_J1 	: rotate_test_block <= block_type_J2;	
						block_type_J2 	: rotate_test_block <= block_type_J3;
						block_type_J3 	: rotate_test_block <= block_type_J;
						block_type_L 	: rotate_test_block <= block_type_L1;
						block_type_L1 	: rotate_test_block <= block_type_L2;
						block_type_L2 	: rotate_test_block <= block_type_L3;
						block_type_L3 	: rotate_test_block <= block_type_L;
						block_type_T 	: rotate_test_block <= block_type_T1;
						block_type_T1 	: rotate_test_block <= block_type_T2;
						block_type_T2 	: rotate_test_block <= block_type_T3;
						block_type_T3 	: rotate_test_block <= block_type_T;	
						default : rotate_test_block <= rotate_test_block;
				endcase
		end
endmodule