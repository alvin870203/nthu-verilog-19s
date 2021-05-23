`timescale 1ns / 1ps
`include "global.v"
module display(
  segs, // 14-segment segs output
  bcd  // BCD input
);

output [`SSD_BIT_WIDTH-1:0] segs; // 7-segment segs out
input [`BCD_BIT_WIDTH-1:0] bcd; // BCD input

reg [`SSD_BIT_WIDTH-1:0] segs; 

// Combinatioanl Logic
always @*
  case (bcd)
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
     default: segs = `SSD_NULL;
  endcase
  
endmodule
