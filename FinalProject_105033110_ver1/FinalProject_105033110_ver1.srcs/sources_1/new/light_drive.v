`timescale 1ns / 1ps
`include "global.v"
module light_drive(
  output reg [3:0] light_warn, // 0: red1, 1: red2, 2:green1, 3: green2
  output reg [`BCD_BIT_WIDTH-1:0] mode_num, // segs of mode
  input [1:0] light_mode,
  input clk, // 1Hz
  input rst_n
);

reg [3:0] light_warn_next;
reg [`BCD_BIT_WIDTH-1:0] mode_num_next;

always @*
  case (light_mode)
  `DARK:
    begin
      light_warn_next = 4'd0;
      mode_num_next = `ZERO;
    end
  `ONE_LIGHT_BLINK:
    begin
      light_warn_next[0] = ~light_warn[0];
      light_warn_next[2] = light_warn[0];
      light_warn_next[1] = 1'b0;
      light_warn_next[3] = 1'b0;
      mode_num_next = `ONE;
    end
  `TWO_LIGHT_BLINK:
    begin
      light_warn_next[0] = ~light_warn[0];
      light_warn_next[2] = light_warn[0];
      light_warn_next[1] = ~light_warn[0];
      light_warn_next[3] = light_warn[0];
      mode_num_next = `TWO;
    end
  `TWO_LIGHT_BRIGHT:
    begin
      light_warn_next = 4'b1111;
      mode_num_next = `THREE;
    end
  endcase

always @(posedge clk or negedge rst_n)
  if (~rst_n)
  begin
    light_warn <= 4'd0;
    mode_num <= `F_NULL;
  end
  else
  begin
    light_warn <= light_warn_next;
    mode_num <= mode_num_next;
  end

endmodule
