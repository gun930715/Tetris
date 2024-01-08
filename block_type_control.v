





module block_type_control
(
	clk,
	reset,
	load_next_block,
	rotate_test_block,
	rotate_en,
	rotate,
	block,
	block_type,
	block_color
	
);
	input clk;
	input reset;
	input load_next_block;	
	input	[0:3][0:3]rotate_test_block;
	input rotate;
	input rotate_en;
	output reg[0:3][0:3]block;
	output reg[2:0]block_type;
	output reg [2:0]block_color;
	reg [2:0]RGB_conut;
	
	
	parameter type_I 	= 3'b001;
	parameter type_O	= 3'b010;
	parameter type_S	= 3'b011;
	parameter type_Z	= 3'b100;
	parameter type_J	= 3'b101;
	parameter type_L	= 3'b110;
	parameter type_T	= 3'b111;
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
		4'b0110,
		4'b1100,
		4'b0000,
		4'b0000
	};
	parameter logic [0:3][0:3]block_type_Z1=
	{
		4'b0100,
		4'b0110,
		4'b0010,
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
		4'b0010,
		4'b0010,
		4'b0110,
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
	parameter [2:0]init_color = 3'b100;
	always@(posedge clk,posedge reset)
		begin
			if(reset)
				begin
					block_type <= 3'b001;
					RGB_conut <= 3'b100;
				end
			else
				begin
					block_type <= block_type + 1'b1;
					if(block_type == 3'b000)
						block_type <= 3'b001;
					if(block_type == 3'b111)
						if(RGB_conut == 3'b111)
							RGB_conut <= 3'b001;
						else
							RGB_conut <= RGB_conut + 1'b1;
				end
		end
		
	always@(posedge clk , posedge reset)
		begin
			if(reset)
				begin
					block <= block_type_I;
					block_color <= 3'b100;
				end
			else if(rotate && rotate_en)
				begin
					block <= rotate_test_block;
				end
			else if(load_next_block)
				begin
					block_color <= RGB_conut;
					case(block_type)
						type_I:
							block <= block_type_I;
						type_O:
							block <= block_type_O;
						type_S:
							block <= block_type_S;
						type_Z:
							block <= block_type_Z;
						type_J:
							block <= block_type_J;
						type_L:
							block <= block_type_L;
						type_T:
							block <= block_type_T;
						default:
							block <= block_type_O;
					endcase
				end
			else
				block <= block;
		end
endmodule