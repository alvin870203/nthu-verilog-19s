`timescale 1ns / 1ps

`include "global.v"

module freq1Hz(
  clk_out, // 1Hz clock (global clock)  
  clk, // global clock input (clock from oscillator)
  rst_n // active low reset
);

output clk_out;
input clk;
input rst_n;

reg clk_out;
reg [`FREQ1HZ_BIT-1:0] cnt;
reg [`FREQ1HZ_BIT-1:0] cnt_d;
reg clk_d;

// 50M counter
// combinational logics
always @*
  if (cnt==`FREQ1HZ_LIMIT)
    cnt_d = `FREQ1HZ_BIT'd0;
  else
    cnt_d = cnt + 1'b1;
// dff
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    cnt <= `FREQ1HZ_BIT'd0;
  else
    cnt <= cnt_d;

// 1Hz
// combinational logics
always @*
  if (cnt==`FREQ1HZ_LIMIT)
    clk_d = ~clk_out;
  else
    clk_d = clk_out;
// dff
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    clk_out <= 1'b0;
  else
    clk_out <= clk_d;

endmodule
