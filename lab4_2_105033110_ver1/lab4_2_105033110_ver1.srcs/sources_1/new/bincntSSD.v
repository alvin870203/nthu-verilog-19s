`timescale 1ns / 1ps

`include "global.v"

module bincntSSD(
  segs, // 7-segment display
  ssd_ctl, // scan control for 7-segment display
  clk, // clock from oscillator
  rst_n // active low reset
);

output [`SSD_BIT-1:0] segs;
output [`SSD_NUM-1:0] ssd_ctl;
input clk;
input rst_n;

wire clk1Hz; // 1Hz global clock
wire [`BINCNT_BIT-1:0] cnt_out; // binary counter output

// scan control
assign ssd_ctl = `SSD_NUM'b1110; // light one ssd

// freq 1Hz
freq1Hz U_F1Hz(
  .clk_out(clk1Hz), // 1Hz clock (global clock)  
  .clk(clk), // global clock input (clock from oscillator)
  .rst_n(rst_n) // active low reset
);

// binary counter
bincnt U_BC(
  .out(cnt_out), // output
  .clk(clk1Hz), // 1Hz global clock
  .rst_n(rst_n) // active low reset
);

// binary to 7-segment display decoder
display_ssd(
  .D(segs), // 7-segment display
  .i(cnt_out) // binary input
);

endmodule
