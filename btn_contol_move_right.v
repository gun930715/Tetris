module btn_contol_move_right
(
	clk,
	reset,
	btn_right_in,
	btn_out
);

	input clk;
	input reset;
	input btn_right_in;
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
					if(count < times && btn_right_in)
						count <= count + 1;
					else
						count <= 0;
				end
				btn_out <= btn_right_in && (count==times);
		end
endmodule