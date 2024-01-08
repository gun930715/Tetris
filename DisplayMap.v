

module DisplayMap
(
	clk,
	reset,
	Red_map_display,
	Green_map_display,
	Blue_map_display,
	LED_Red,
	LED_Green,
	LED_Blue,
	LED_COM
);
	input clk;
	input reset;
	input [0:7][0:7]Red_map_display;
	input [0:7][0:7]Green_map_display;
	input [0:7][0:7]Blue_map_display;
	output reg [0:7]LED_Red;
	output reg [0:7]LED_Green;
	output reg [0:7]LED_Blue;
	output reg [2:0]LED_COM;
	
	always@(posedge clk,posedge reset)
		begin
			if(reset)
				LED_COM 	<=  3'b000;
			else
				LED_COM 	<=  LED_COM + 1'b1;
		end
	always@(posedge clk ,posedge reset)
		begin
			if(reset)
				begin
					LED_Red 		<= 8'b11111111;
					LED_Green 	<= 8'b11111111;
					LED_Blue 	<= 8'b11111111;
				end
			else
				begin
					for(integer i = 0;i<8;i=i+1)
						begin
							LED_Red [i]		<= 	~Red_map_display[i][(LED_COM+1'b1)-8];
							LED_Green[i]	<= 	~Green_map_display[i][(LED_COM+1'b1)-8];
							LED_Blue[i] 	<= 	~Blue_map_display[i][(LED_COM+1'b1)-8];
						end
				end
		end
		
endmodule