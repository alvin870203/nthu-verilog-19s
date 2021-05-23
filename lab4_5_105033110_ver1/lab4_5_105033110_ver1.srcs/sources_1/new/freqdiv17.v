`timescale 1ns / 1ps
`include "global.v"
module freqdiv17(
  clk_ctl, // divided clock for 7-segment display scan
  clk, // clock from the 100MHz oscillator
  rst_n // low active reset
);

output [`SSD_SCAN_CTL_BIT_WIDTH-1:0] clk_ctl; // divided clock for 7-segment display scan
input clk; // clock from the 100MHz oscillator
input rst_n; //low active reset

reg [`SSD_SCAN_CTL_BIT_WIDTH-1:0] clk_ctl; // divided clock for seven-segment display scan (in the always block)
reg [14:0] cnt_l; // temperatory buffer
reg [`FREQ_DIV_BIT-1:0] cnt_tmp; // input node to flip flops

// Combinational block 
always @(cnt_l or clk_ctl)
  cnt_tmp = {clk_ctl,cnt_l} + 1'b1;
  
// Sequential block 
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    {clk_ctl,cnt_l} <= `FREQ_DIV_BIT'b0;
  else
    {clk_ctl,cnt_l} <= cnt_tmp;

endmodule
