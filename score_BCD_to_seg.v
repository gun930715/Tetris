module score_BCD_to_seg
(
	score,
	seg
);


	input [3:0]score;
	output reg[6:0]seg;
	// 1 = 亮, 0 = 不亮 
	// {a,b,c,d,e,f,g} 
	parameter [6:0] seg_0 = 7'b000_0001;
	parameter [6:0] seg_1 = 7'b100_1111;
	parameter [6:0] seg_2 = 7'b001_0010;
	parameter [6:0] seg_3 = 7'b000_0110;
	parameter [6:0] seg_4 = 7'b100_1100;
	parameter [6:0] seg_5 = 7'b010_0100;
	parameter [6:0] seg_6 = 7'b010_0000;
	parameter [6:0] seg_7 = 7'b000_1111;
	parameter [6:0] seg_8 = 7'b000_0000;
	parameter [6:0] seg_9 = 7'b000_0100;
	always@(score)
		case(score)
			4'b0000 : 	seg <= seg_0;
			4'b0001 :	seg <= seg_1;
			4'b0010 :	seg <= seg_2;
			4'b0011 :	seg <= seg_3;
			4'b0100 :	seg <= seg_4;
			4'b0101 :	seg <= seg_5;
			4'b0110 :	seg <= seg_6;
			4'b0111 :	seg <= seg_7;
			4'b1000 :	seg <= seg_8;
			4'b1001 :	seg <= seg_9;
			default :	seg <= 7'b000_0000;
		endcase
endmodule