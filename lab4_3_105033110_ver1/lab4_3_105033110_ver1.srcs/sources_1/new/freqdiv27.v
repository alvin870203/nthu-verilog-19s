`timescale 1ns / 1ps
`include "global.v"
module freqdiv27(
  clk_out, //divided clock output
  clk, // clock from the 100MHz oscillator
  rst_n // low active reset
);

output clk_out; //divided clock output
input clk; // clock from the 40MHz oscillator
input rst_n; //low active reset

reg clk_out; // divided clock output (in the always block)
reg [25:0] cnt_l; // temperatory buffer
reg [`FREQ_DIV_BIT-1:0] cnt_tmp; // input node to flip flops

// Combinational block 
always @(clk_out)
  cnt_tmp = {clk_out,cnt_l} + 1'b1;
  
// Sequential block 
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    {clk_out,cnt_l} <= `FREQ_DIV_BIT'b0;
  else
    {clk_out,cnt_l} <= cnt_tmp;

endmodule
