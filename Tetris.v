	module Tetris
(
	clk,
	reset,
	move_left_in,
	move_right_in,
	move_down_in,
	rotate_in,
	LED_Red,
	LED_Green,
	LED_Blue,
	LED_en,
	LED_COM,
	seg,
	seg_COM
);
//----------------------------------
		input clk;
		input reset;
		input move_left_in;
		input move_right_in;
		input move_down_in;
		input rotate_in;
//----------------------------------
		output [0:7]LED_Red;
		output [0:7]LED_Green;
		output [0:7]LED_Blue;
		output LED_en;
		output [2:0]LED_COM;
		output [6:0]seg;
		output seg_COM;
//----------------------------------
		wire fall_down;
		wire move_left_en;
		wire move_right_en;
		wire move_down_en;
		wire rotate_en;
//----------------------------------		
		wire [0:8][0:11]map;
		wire [0:3][0:3]block;
		wire [2:0]block_type;
		wire [0:3][0:3]rotate_test_block;
		wire clk_1Hz;
		wire load_next_block;
		wire [2:0]block_color;
		
		wire [0:7][0:7]Red_map;
		wire [0:7][0:7]Green_map;
		wire [0:7][0:7]Blue_map;
		wire [0:7][0:7]Red_map_display;
		wire [0:7][0:7]Green_map_display;
		wire [0:7][0:7]Blue_map_display;
		
		wire [3:0]cur_x;
		wire [3:0]cur_y;
		
		wire move_left;
		wire move_right;
		wire move_down;
		wire rotate;
		
		reg score_plus;
		reg[7:0]remove_line;
//----------------------------------

		// 控制輸入頻率(統一)
//		btn_contol
//		btn_contol_move_left
//		(
//			.clk(clk),
//			.reset(reset),
//			.btn_in(move_left_in),
//			.btn_out(move_left)
//		);
//		btn_contol
//		btn_contol_move_right
//		(
//			.clk(clk),
//			.reset(reset),
//			.btn_in(move_right_in),
//			.btn_out(move_right)
//		);
//		btn_contol
//		btn_contol_move_down
//		(
//			.clk(clk),
//			.reset(reset),
//			.btn_in(move_down_in),
//			.btn_out(move_down)
//		);
//		btn_contol
//		btn_contol_rotate
//		(
//			.clk(clk),
//			.reset(reset),
//			.btn_in(rotate_in),
//			.btn_out(rotate)
//		);

		// 控制輸入頻率(個別)
		btn_contol_move_left
		btn_contol_move_left_
		(
			.clk(clk),
			.reset(reset),
			.btn_left_in(move_left_in),
			.btn_out(move_left)
		);
		btn_contol_move_right
		btn_contol_move_right_
		(
			.clk(clk),
			.reset(reset),
			.btn_right_in(move_right_in),
			.btn_out(move_right)
		);
		btn_contol_move_down
		btn_contol_move_down_
		(
			.clk(clk),
			.reset(reset),
			.btn_down_in(move_down_in),
			.btn_out(move_down)
		);
		btn_contol_rotate
		btn_contol_rotate_
		(
			.clk(clk),
			.reset(reset),
			.btn_rotate_in(rotate_in),
			.btn_out(rotate)
		);

//----------------------------------

		// 移除一列方塊
		always@(negedge clk ,posedge reset)
			begin
				if(reset)
					remove_line <= 0;
				else
					for(integer i= 0 ; i < 8 ; i=i+1)
						remove_line[i] <= &(Red_map[i] | Green_map[i] | Blue_map[i]);
			end
		//
		always@(posedge clk ,posedge reset)
			begin
				if(reset)
					score_plus <= 0;
				else
					begin
						score_plus <= 0;
						if(|remove_line)
							score_plus <= 1'b1;
					end
			end
		

//----------------------------------

	
	
		// Red Map
		calculate_color_map
		calculate_Red_map
		(
			.clk(clk),
			.reset(reset),
			.block_window(block),
			.color(block_color[2]),
			.cur_x(cur_x),
			.cur_y(cur_y),
			.remove_line(remove_line),
			.load_next_block(load_next_block),
			.color_map_r(Red_map),
			.color_map_display(Red_map_display)
		);
		// Green Map
		calculate_color_map
		calculate_Green_map
		(
			.clk(clk),
			.reset(reset),
			.block_window(block),
			.color(block_color[1]),
			.cur_x(cur_x),
			.cur_y(cur_y),
			.remove_line(remove_line),
			.load_next_block(load_next_block),
			.color_map_r(Green_map),
			.color_map_display(Green_map_display)
		);
		// Blue Map
		calculate_color_map
		calculate_Blue_map
		(
			.clk(clk),
			.reset(reset),
			.block_window(block),
			.color(block_color[0]),
			.cur_x(cur_x),
			.cur_y(cur_y),
			.remove_line(remove_line),
			.load_next_block(load_next_block),
			.color_map_r(Blue_map),
			.color_map_display(Blue_map_display)
		);
		
//----------------------------------

		// 除頻設置
		divfreq_1Hz
		divfreq_1Hz_
		(
			.clk_in(clk),
			.clk_out(clk_1Hz)
		);
		
//----------------------------------

		// Load_block
		// 載入下個方塊的控制訊號
		Load_block
		Load_block_
		(
			.clk(clk),
			.clk_1Hz(clk_1Hz),
			.reset(reset),
			.move_down_en(move_down_en),
			.fall_down(fall_down),
			.load_next_block(load_next_block)
		);
		
//----------------------------------

		// block_control_check
		// 判斷輸入是否可執行
		block_control_check
		block_control_check_(
			.clk(clk),
			.clk_1Hz(clk_1Hz),
			.reset(reset),
			.map(map),
			.block(block),
			.cur_x(cur_x),
			.cur_y(cur_y),
			.fall_down(fall_down),
			.move_left_en(move_left_en),
			.move_right_en(move_right_en),
			.move_down_en(move_down_en),
			.rotate_en(rotate_en),
			.rotate_test_block(rotate_test_block)
		);
		
//----------------------------------

		// block_type_control
		// 控制方塊樣式、顏色和旋轉後的樣式
		block_type_control
		block_type_control_(
			.clk(clk),
			.reset(reset),
			.load_next_block(load_next_block),
			.rotate_test_block(rotate_test_block),
			.rotate(rotate),
			.rotate_en(rotate_en),	
			.block(block),
			.block_type(block_type),
			.block_color(block_color)
		);
		


//----------------------------------
		
		// block_control 
		// 方塊移動控制
		block_control
		block_control_(
			.clk(clk),
			.clk_1Hz(clk_1Hz),
			.reset(reset),
			.load_next_block(load_next_block),
			.cur_x(cur_x),
			.cur_y(cur_y),
			.fall_down(fall_down),
			.move_left(move_left),
			.move_right(move_right),
			.move_down(move_down),
			.move_left_en(move_left_en),
			.move_right_en(move_right_en),
			.move_down_en(move_down_en)
		);
		
//----------------------------------

		// map_control
		// 
		map_control
		map_control_(
			.clk(clk),
			.reset(reset),
			.load_next_block(load_next_block),
			.block(block),
			.cur_x(cur_x),
			.cur_y(cur_y),
			.Red_map(Red_map),
			.Green_map(Green_map),
			.Blue_map(Blue_map),
			.map(map)
		);
		
//----------------------------------
		
		// DisplayMap
		// LED 顯示
		DisplayMap
		DisplayMap_(
			.clk(clk),
			.reset(reset),
			.Red_map_display(Red_map_display),
			.Green_map_display(Green_map_display),
			.Blue_map_display(Blue_map_display),
			.LED_Red(LED_Red),
			.LED_Green(LED_Green),
			.LED_Blue(LED_Blue),
			.LED_COM(LED_COM)
		);
		
		
		assign LED_en = 1'b1;	
		
//----------------------------------
		
		
		score_control
		score_control_(
			.clk(clk),
			.reset(reset),
			.score_plus(score_plus),
			.seg(seg),
			.seg_COM(seg_COM)
		);
		
		
	
	
endmodule