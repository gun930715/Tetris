module score_control
(
	clk,
	reset,
	score_plus,
	seg,
	seg_COM
);
	input clk;
	input reset;
	input score_plus;
	reg [3:0][3:0]score_r;
	reg [3:0][6:0]seg_r;
	output reg[6:0]seg;
	output reg [1:0]seg_COM;
	
		always@(posedge clk, posedge reset)
			if(reset)
				begin
					score_r[0] <= 0;
					score_r[1] <= 0;
					score_r[2] <= 0;
					score_r[3] <= 0;
				end
			else
				begin
					score_r[0] <= score_r[0] + score_plus;
					if(score_r[0] >= 4'b1010)
						begin
							score_r[0] <= score_r[0] - 4'b1010;
							score_r[1] <= score_r[1] + 1'b1;
						end
					else if(score_r[1] >= 4'b1010)
						begin
							score_r[1] <= score_r[1] - 4'b1010;
							score_r[2] <= score_r[2] + 1'b1;
						end
					else if(score_r[2] >= 4'b1010)
						begin
							score_r[2] <= score_r[2] - 4'b1010;
							score_r[3] <= score_r[3] + 1'b1;
						end
				end
	
	
	score_BCD_to_seg
	score_1_to_seg(
		.score(score_r[0]),
		.seg(seg_r[0])
	);
	
	score_BCD_to_seg
	score_2_to_seg(
		.score(score_r[1]),
		.seg(seg_r[1])
	);
	
	score_BCD_to_seg
	score_3_to_seg(
		.score(score_r[2]),
		.seg(seg_r[2])
	);
	
	score_BCD_to_seg
	score_4_to_seg(
		.score(score_r[3]),
		.seg(seg_r[3])
	);
	
	always@(posedge clk, posedge reset)
		begin
			if(reset)
				seg_COM <= 0 ;
			else
				seg_COM <= seg_COM + 1'b1;
		end
		
	always@(posedge clk ,posedge reset)
		begin
			if(reset)
				seg <= 7'b1111111;
			else
				seg <= seg_r[seg_COM+1'b1];
		end
	
endmodule