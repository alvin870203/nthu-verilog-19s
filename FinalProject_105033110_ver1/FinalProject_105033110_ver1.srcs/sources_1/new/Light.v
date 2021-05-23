`timescale 1ns / 1ps
`include "global.v"
module Light(
  output [3:0] light_warn, // 0: red1, 1: red2, 2:green1, 3: green2
  output [`BCD_BIT_WIDTH-1:0] mode_num, // segs of mode
  input btn_led,
  input clk_1, // 1Hz
  input clk, // 100MHz
  input rst_n
);

wire [1:0] light_mode;

FSM U_FSM(
  .light_mode(light_mode),
  .btn_led(btn_led),
  .clk(clk_1), // 1Hz
  .rst_n(rst_n)
);

light_drive U_LD(
  .light_warn(light_warn), // 0: red1, 1: red2, 2:green1, 3: green2
  .mode_num(mode_num), // segs of mode
  .light_mode(light_mode),
  .clk(clk_1), // 100MHz
  .rst_n(rst_n)
);

endmodule
