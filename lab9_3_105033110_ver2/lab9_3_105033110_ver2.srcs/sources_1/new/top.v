`include "global.v"
module top(
  //output in_trig,
  output [2:0] state,
  output [8:0] last_change,
  output [7:0] segs, // 7-segment display
  output [3:0] ssd_ctl, // scan control for 7-segment display
  inout PS2_DATA, // B17
  inout PS2_CLK, // C17
  input clk, // clock from oscillator
  input rst_n // DIP switch, low-active reset
);

wire in_trig;

wire clk_2k;
wire [`BCD_BIT_WIDTH-1:0] dig0, dig1, dig2, dig3;
wire [`BCD_BIT_WIDTH-1:0] ssd_in;
wire [6:0] key_num; // ASCII
wire [511:0] key_down;
//wire [8:0] last_change;
wire key_valid;
//wire en;

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

fsm U_FSM(
  //.en(en),
  .in_trig(in_trig),
  .state(state),
  .key_down(key_down),
  .last_change(last_change),
  .key_valid(key_valid),
  .clk(clk),
  .rst_n(rst_n)
);


keyboard_ctl U_KC(
  .key_num(key_num),
  .state(state),
  .key_down(key_down),
  .last_change(last_change),
  .key_valid(key_valid),
  .clk(clk),
  .rst_n(rst_n)
);

calculator U_C(
  .dig0(dig0), // BCD nmber to input to scan_ctl
  .dig1(dig1),
  .dig2(dig2),
  .dig3(dig3),
  //.en(`ENABLED),
  .key_num(key_num), // ASCII
  .state(state),
  .clk(clk), // 100MHz
  .rst_n(rst_n)
);

scan_ctl U_SC(
  .ssd_ctl(ssd_ctl),
  .ssd_in(ssd_in),
  .in0(dig0), // LSB
  .in1(dig1),
  .in2(dig2),
  .in3(dig3), // MSB
  .ssd_ctl_en(clk_2k),
  .rst_n(rst_n)
);

display U_D(
  .segs(segs),
  .bin(ssd_in) 
);

endmodule
