`timescale 1ns / 1ps
`include "global.v"
module stop(
  decrease_enable,
  value0,
  value1
);

output decrease_enable;
input [`CNT_BIT_WIDTH-1:0] value0;
input [`CNT_BIT_WIDTH-1:0] value1;

reg decrease_enable;

always @*
  if (value0==`BCD_ZERO && value1==`BCD_ZERO)
    decrease_enable = `DISABLED;
  else
    decrease_enable = `ENABLED;

endmodule
