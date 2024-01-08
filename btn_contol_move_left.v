module btn_contol_move_left
(
	clk,
	reset,
	btn_left_in,
	btn_out
);

	input clk;
	input reset;
	input btn_left_in;
	output reg btn_out;
	
	reg [24:0] count;
	parameter [24:0]times = 2500;
	
	always@(posedge clk,posedge reset)
		begin
			if(reset)
				begin
					count <= 0;
				end
			else
				begin
					if(count < times && btn_left_in)
						count <= count + 1;
					else
						count <= 0;
				end
				btn_out <= btn_left_in && (count==times);
		end
endmodule