`timescale 1ns / 1ps

`include "global.v"

module bincnt(
  out, // output
  clk, // global clock
  rst_n // active low reset
);
output [`BINCNT_BIT-1:0] out;
input clk;
input rst_n;

reg [`BINCNT_BIT-1:0] out;
reg [`BINCNT_BIT-1:0] tmp_cnt;

// combinational circuit
always @*
  tmp_cnt = out + 1'b1;
  
// dff  
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    out <= `BINCNT_BIT'd0;
  else
    out <= tmp_cnt;

endmodule
