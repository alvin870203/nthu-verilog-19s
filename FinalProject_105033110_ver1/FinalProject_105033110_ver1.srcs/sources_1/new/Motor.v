`timescale 1ns / 1ps
`include "global.v"
module Motor(
  output [1:0] motor, // 0 for right, 1 for left 
  output [1:0] led_direction, // 0 for right, 1 for left
  inout PS2_DATA,
  inout PS2_CLK,
  input clk, // 100MHz
  input rst_n
);

wire [511:0] key_down;
wire [8:0] last_change;
wire key_valid;
wire [1:0] direction;

KeyboardDecoder U_KD(
  .key_down(key_down),
  .last_change(last_change),
  .key_valid(key_valid),
  .PS2_DATA(PS2_DATA),
  .PS2_CLK(PS2_CLK),
  .rst(~rst_n),
  .clk(clk)
);

direction_ctl U_DC(
  .direction(direction),
  .key_down(key_down),
  .last_change(last_change),
  .key_valid(key_valid),
  .clk(clk),
  .rst_n(rst_n)
);

motor_drive U_MD(
  .motor(motor),
  .led_direction(led_direction),
  .direction(direction),
  .clk(clk),
  .rst_n(rst_n)
);

endmodule
