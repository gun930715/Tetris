# Tetris

## input
* __move_left__  
往左移動  
* __move_right__  
往右移動  
* __move_down__  
往下移動  
* __rotate__  
切換旋轉樣式  
* __reset__  
重製遊戲

## output 

* **LED_Red**
  
* **LED_Green**
  
* **LED_Blue**
  
*	**LED_en**
  
*	**LED_COM**

## module

* **Tetris**  
連接其他moudle
* **btn_control**  
控制移動或旋轉輸入
* **btn_control_check**
檢測移動或旋轉是否可執行
* **block_type_control**
控制方塊顏色和樣式
* **calculate_color_map**
輸入方塊位置和樣式並計算在8*8陣列中的位置，輸出陣列
* **display_map**
將8*8陣列顯示在LED陣列
