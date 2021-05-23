`include "global.v"
module display(
  high_led, // indicate high(Hz)
  segs, // 7-segment segs output
  bin  // binary input
);
output high_led;
output [`SSD_BIT_WIDTH-1:0] segs; // 7-segment segs out
input [`BCD_BIT_WIDTH-1:0] bin; // binary input

reg high_led;
reg [`SSD_BIT_WIDTH-1:0] segs; 

// Combinatioanl Logic
always @*
begin
  segs = `SSD_DEF;
  high_led = 1'b0;
  case (bin)
  `BCD_BIT_WIDTH'd0: segs = `SSD_NULL;
	`BCD_BIT_WIDTH'd1: segs = `SSD_C;
	`BCD_BIT_WIDTH'd2: segs = `SSD_D;
	`BCD_BIT_WIDTH'd3: segs = `SSD_E;
	`BCD_BIT_WIDTH'd4: segs = `SSD_F;
	`BCD_BIT_WIDTH'd5: segs = `SSD_G;
	`BCD_BIT_WIDTH'd6: segs = `SSD_A;
	`BCD_BIT_WIDTH'd7: segs = `SSD_B;
	`BCD_BIT_WIDTH'd8: begin segs = `SSD_C; high_led = 1'b1; end
	`BCD_BIT_WIDTH'd9: begin segs = `SSD_D; high_led = 1'b1; end
	`BCD_BIT_WIDTH'd10: begin segs = `SSD_E; high_led = 1'b1; end
	`BCD_BIT_WIDTH'd11: begin segs = `SSD_F; high_led = 1'b1; end
	`BCD_BIT_WIDTH'd12: begin segs = `SSD_G; high_led = 1'b1; end
	`BCD_BIT_WIDTH'd13: begin segs = `SSD_A; high_led = 1'b1; end
	`BCD_BIT_WIDTH'd14: begin segs = `SSD_B; high_led = 1'b1; end
	`BCD_BIT_WIDTH'd15: segs = `SSD_NULL; // all off
  endcase
end

endmodule
