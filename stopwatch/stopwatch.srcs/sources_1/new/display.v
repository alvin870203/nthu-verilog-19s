`timescale 1ns / 1ps
`include "global.v"
module display(
  segs, // 14-segment segs output
  bin  // binary input
);
output [`SSD_BIT_WIDTH-1:0] segs; // 7-segment segs out
input [`BCD_BIT_WIDTH-1:0] bin; // binary input

reg [`SSD_BIT_WIDTH-1:0] segs; 

// Combinatioanl Logic
always @*
  case (bin)
    `BCD_BIT_WIDTH'd0: segs = `SSD_ZERO;
	`BCD_BIT_WIDTH'd1: segs = `SSD_ONE;
	`BCD_BIT_WIDTH'd2: segs = `SSD_TWO;
	`BCD_BIT_WIDTH'd3: segs = `SSD_THREE;
	`BCD_BIT_WIDTH'd4: segs = `SSD_FOUR;
	`BCD_BIT_WIDTH'd5: segs = `SSD_FIVE;
	`BCD_BIT_WIDTH'd6: segs = `SSD_SIX;
	`BCD_BIT_WIDTH'd7: segs = `SSD_SEVEN;
	`BCD_BIT_WIDTH'd8: segs = `SSD_EIGHT;
	`BCD_BIT_WIDTH'd9: segs = `SSD_NINE;
	`BCD_BIT_WIDTH'd10: segs = `SSD_A;
	`BCD_BIT_WIDTH'd11: segs = `SSD_B;
	`BCD_BIT_WIDTH'd12: segs = `SSD_C;
	`BCD_BIT_WIDTH'd13: segs = `SSD_D;
	`BCD_BIT_WIDTH'd14: segs = `SSD_E;
	`BCD_BIT_WIDTH'd15: segs = `SSD_F;
	 default: segs = `SSD_DEF;
  endcase
  
endmodule
