module divfreq_1Hz
(
	output reg clk_out,
	input clk_in
);
	 parameter N = 5;  
	 parameter k = (25000000 / N);
	 integer		count;
	 initial
	 begin
		count = 0;
		clk_out = 0;
	 end
	 always@(posedge clk_in)
		if(count == (N-1))
			begin
				count = 0;
				clk_out =~clk_out;
			end
		else
				count = count + 1;

endmodule