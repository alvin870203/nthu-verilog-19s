`timescale 1ns / 1ps
`include "global.v"
module direction_ctl(
  output reg [1:0] direction, // 00 stop, 01 forward, 10 right, 11 left
  input [511:0] key_down,
  input [8:0] last_change,
  input key_valid,
  input clk, // 100MHz
  input rst_n
);

reg [1:0] direction_next;

always @*
  if (key_down[117] == 1'b1)
    direction_next = 2'b01;
  else if (key_down[116] == 1'b1)
    direction_next = 2'b10;
  else if (key_down[107] == 1'b1)
    direction_next = 2'b11;
  else
    direction_next = 2'b00;

always @(posedge clk or negedge rst_n)
  if (~rst_n)
    direction <= 2'd0;
  else
    direction <= direction_next;

endmodule

