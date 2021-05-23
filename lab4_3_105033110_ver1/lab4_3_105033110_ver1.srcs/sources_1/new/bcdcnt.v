`timescale 1ns / 1ps
`include "global.v"
module bcdcnt(
  out, //counter output
  clk, // clock
  rst_n //active low reset
);

output [`CNT_BIT_WIDTH-1:0] out; // counter output
input clk; // clock
input rst_n; //active low reset
    
reg [`CNT_BIT_WIDTH-1:0] out; // counter output
reg [`CNT_BIT_WIDTH-1:0] tmp_cnt;
    
always @*
  if (out==`BCD_NINE)
    tmp_cnt = `BCD_ZERO;
  else
    tmp_cnt = out + 1'b1;
    
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    out <= 0;
  else
    out <= tmp_cnt;

endmodule
