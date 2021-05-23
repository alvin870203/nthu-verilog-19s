`timescale 1ns / 1ps
`include "global.v"
module clock_generator(
  clk_1, // generated 1 Hz clock
  clk_ctl, // divided clock for 7-segment display scan
  clk, // clock from 100MHz crystal oscillator
  rst // high active reset  
);

output clk_1;
output [`SSD_SCAN_CTL_BIT_WIDTH-1:0] clk_ctl;
input clk;
input rst;

// Clock Generator 1 Hz
reg clk_1;
reg clk_1_next;
reg [`DIV_BY_50M_BIT_WIDTH-1:0] count_50M;
reg [`DIV_BY_50M_BIT_WIDTH-1:0] count_50M_next;
// Frequency divider for 7-segment display scan
reg [`SSD_SCAN_CTL_BIT_WIDTH-1:0] clk_ctl;
reg [14:0] cnt_l; // temperatory buffer
reg [`FREQ_DIV_BIT-1:0] cnt_tmp; // input node to flip flops

// *******************
// Clock Generator 1 Hz
// *******************
// Clock Divider: Counter operation
always @*
  if (count_50M == `DIV_BY_50M-1)
  begin
    count_50M_next = `DIV_BY_50M_BIT_WIDTH'd0;
    clk_1_next = ~clk_1;
  end
  else
  begin
    count_50M_next = count_50M + 1'b1;
    clk_1_next = clk_1;
  end
// Counter flip-flops
always @(posedge clk or posedge rst)
  if (rst)
  begin
    count_50M <=`DIV_BY_50M_BIT_WIDTH'b0;
    clk_1 <=1'b0;
  end
  else
  begin
    count_50M <= count_50M_next;
    clk_1 <= clk_1_next;
  end

// *********************
// Frequency divider for 7-segment display scan
// *********************
// Combinational block
always @(cnt_l or clk_ctl)
  cnt_tmp = {clk_ctl,cnt_l} + 1'b1;
// Sequential block
always @(posedge clk or posedge rst)
  if (rst)
    {clk_ctl,cnt_l} <= `FREQ_DIV_BIT'b0;
  else
    {clk_ctl,cnt_l} <= cnt_tmp;

endmodule
