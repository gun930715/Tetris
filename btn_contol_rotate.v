module btn_contol_rotate
(
	clk,
	reset,
	btn_rotate_in,
	btn_out
);

	input clk;
	input reset;
	input btn_rotate_in;
	output reg btn_out;
	
	reg [24:0] count;
	parameter [24:0]times = 5000;
	
	always@(posedge clk,posedge reset)
		begin
			if(reset)
				begin
					count <= 0;
				end
			else
				begin
					if(count < times && btn_rotate_in)
						count <= count + 1;
					else
						count <= 0;
				end
				btn_out <= btn_rotate_in && (count==times);
		end
endmodule