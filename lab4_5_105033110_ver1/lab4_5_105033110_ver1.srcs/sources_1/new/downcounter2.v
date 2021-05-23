`timescale 1ns / 1ps
`include "global.v"
module downcounter2(
  value, // counter output
  borrow, // borrow indicator
  clk, // 1Hz clock
  rst_n, // active low reset
  decrease, // counter enable control
  limit // limit for the counter
);

output [`CNT_BIT_WIDTH-1:0] value;
output borrow;
input clk;
input rst_n;
input decrease;
input [`CNT_BIT_WIDTH-1:0] limit;

reg [`CNT_BIT_WIDTH-1:0] value;
reg borrow;
reg [`CNT_BIT_WIDTH-1:0] value_tmp;

// Combinational logics
always @*
  if (value==`BCD_ZERO && decrease)
    begin
      value_tmp = limit;
      borrow = `ENABLED;
    end
  else if (value!=`BCD_ZERO && decrease)
    begin
      value_tmp = value - `INCREMENT;
      borrow = `DISABLED;
    end
  else
    begin
      value_tmp = value;
      borrow = `DISABLED;
    end

// register part for BCD counter
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    value <= limit; // start form 3
  else
    value <= value_tmp;

endmodule
