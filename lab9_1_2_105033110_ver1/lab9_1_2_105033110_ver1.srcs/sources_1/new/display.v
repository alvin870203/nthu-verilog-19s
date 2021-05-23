`include "global.v"
module display(
  segs, // 7-segment segs output
  ascii  // ASCII input
);
output [`SSD_BIT_WIDTH-1:0] segs; // 7-segment segs out
input [6:0] ascii; // ASCII input

reg [`SSD_BIT_WIDTH-1:0] segs; 

// Combinatioanl Logic
always @*
  case (ascii)
    7'd97: segs = 8'b0111_1111;
    7'd115: segs = 8'b1111_1101;
    7'd109: segs = 8'b1110_1111;
    7'd10: segs = `SSD_NULL;
	  default: segs = `SSD_DEF;
  endcase
  
endmodule
