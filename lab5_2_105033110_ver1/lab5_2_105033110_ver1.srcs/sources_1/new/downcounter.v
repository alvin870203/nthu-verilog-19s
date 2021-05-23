`timescale 1ns / 1ps
`include "global.v"
module downcounter(
  value,  // counter value 
  borrow,  // borrow indicator for counter to next stage
  clk, // global clock signal
  rst,  // high active reset
  decrease,  // decrease input from previous stage of counter
  init_value,  // initial value for the counter
  limit  // limit for the counter
);

// outputs
output [`BCD_BIT_WIDTH-1:0] value; // counter value
output borrow; // borrow indicator for counter to next stage
// inputs
input clk; // global clock signal
input rst; // high active reset
input decrease; // decrease input from previous stage of counter
input [`BCD_BIT_WIDTH-1:0] init_value; // initial value for the counter
input [`BCD_BIT_WIDTH-1:0] limit; // limit for the counter

reg [`BCD_BIT_WIDTH-1:0] value; // counter value
reg [`BCD_BIT_WIDTH-1:0] value_tmp; // D input for counter register
reg borrow; // borrow indicator for counter to next stage

// combinational part for BCD counter
always @*
  if (value == `BCD_ZERO && decrease)  // reach limit, go back to 0
  begin
    value_tmp = limit;
    borrow = `ENABLED;
  end
  else if (decrease) // count enabled
  begin
    value_tmp = value - `INCREMENT;
    borrow = `DISABLED;
  end
  else // count disabled
  begin
    value_tmp = value;
    borrow = `DISABLED;
  end

// register part for BCD counter
always @(posedge clk or posedge rst)
  if (rst)
    value <= init_value;
  else
    value <= value_tmp;

endmodule
