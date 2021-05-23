`timescale 1ns / 1ps

`include "global.v"

module bntLED(
  b, // binary up counter 4-bit output
  clk, // global clock
  rst_n // active low reset
);

output [`BINCNT_BIT-1:0] b;
input clk;
input rst_n;

wire clk_1Hz; // 1Hz clock

// freq 1Hz
freq1Hz U_F1Hz(
  .clk_out(clk_1Hz), // 1Hz clock  
  .clk(clk), // global clock input
  .rst_n(rst_n) // active low reset
);

// binary counter
bincnt U_BC(
  .out(b), // output
  .clk(clk_1Hz), // input clock
  .rst_n(rst_n) // active low reset
);

endmodule
