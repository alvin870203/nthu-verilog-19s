`include "global.v"
module top(
  output [8:0] last_change,
  output [7:0] segs, // 7-segment display
  output [3:0] ssd_ctl, // scan control for 7-segment display
  inout PS2_DATA, // B17
  inout PS2_CLK, // C17
  input clk, // clock from oscillator
  input rst_n // DIP switch, low-active reset
);

wire clk_2k;
wire [6:0] ssd_in;
wire [6:0] key_num;
wire [511:0] key_down;
//wire [8:0] last_change;
wire key_valid;

clock_generator U_CG(
  .clk_2k(clk_2k),
  .clk(clk),
  .rst_n(rst_n)
);

KeyboardDecoder U_KD(
  .key_down(key_down),
  .last_change(last_change),
  .key_valid(key_valid),
  .PS2_DATA(PS2_DATA),
  .PS2_CLK(PS2_CLK),
  .rst(~rst_n),
  .clk(clk)
);

keyboard_ctl U_KC(
  .key_num(key_num),
  .key_down(key_down),
  .last_change(last_change),
  .key_valid(key_valid),
  .clk(clk),
  .rst_n(rst_n)
);

scan_ctl U_SC(
  .ssd_ctl(ssd_ctl),
  .ssd_in(ssd_in),
  .in0(key_num), // LSB
  .in1(7'd10),
  .in2(7'd10),
  .in3(7'd10), // MSB
  .ssd_ctl_en(clk_2k),
  .rst_n(rst_n)
);

display U_D(
  .segs(segs),
  .ascii(ssd_in)
);

endmodule
