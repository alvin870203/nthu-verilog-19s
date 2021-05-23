`timescale 1ns / 1ps
`include "global.v"
module top(
// Motor output
  output [1:0] motor, // 0 for right, 1 for left 
  output [1:0] led_direction, // 0 for right, 1 for left
// Alarm output
  output audio_mclk,
  output audio_lrck,
  output audio_sck,
  output audio_sdin,
  output led_alarm,
  output [`SSD_BIT_WIDTH-1:0] segs,
  output [`SSD_NUM-1:0] ssd_ctl,
// Light output
  output [3:0] light_warn, // 0: red1, 1: red2, 2:green1, 3: green2
  //output [`SSD_BIT_WIDTH-1:0] segs,
  //output [`SSD_NUM-1:0] ssd_ctl,
// Motor inout
  inout PS2_DATA,
  inout PS2_CLK,
// Alarm input 
  input volumn_up_pb,
  input volumn_down_pb,
  input dip_alarm,
// Light input
  input btn_led,
// global input
  input clk,
  input rst_n
);

wire clk_1, clk_2, clk_100, clk_2k;
wire [`BCD_BIT_WIDTH-1:0] volumn_cnt0, volumn_cnt1;
wire [`BCD_BIT_WIDTH-1:0] mode_num;
wire [`BCD_BIT_WIDTH-1:0] ssd_in;

clock_generator U_CG(
  .clk_1(clk_1), // generated 1 Hz clock
  .clk_2(clk_2), // generated 2 Hz clock
  .clk_100(clk_100), // generated 100 Hz clock
  .clk_2k(clk_2k), // generated 2k clock for scan control
  .clk(clk), // clock from crystal
  .rst_n(rst_n) // active low reset
);

Motor U_M(
  .motor(motor), // 0 for right, 1 for left 
  .led_direction(led_direction), // 0 for right, 1 for left
  .PS2_DATA(PS2_DATA),
  .PS2_CLK(PS2_CLK),
  .clk(clk), // 100MHz
  .rst_n(rst_n)
);

Alarm U_A(
  .audio_mclk(audio_mclk), // master clock
  .audio_lrck(audio_lrck), // left-right clock
  .audio_sck(audio_sck), // serial clock
  .audio_sdin(audio_sdin), // serial audio data input,
  .led_alarm(led_alarm),
  .volumn_cnt0(volumn_cnt0), // to scan_ctl in0
  .volumn_cnt1(volumn_cnt1), // to scan_ctl in1
  .volumn_up_pb(volumn_up_pb),
  .volumn_down_pb(volumn_down_pb),
  .dip_alarm(dip_alarm),
  .clk_1(clk_1), // generated 1 Hz clock
  .clk_2(clk_2), // generated 2 Hz clock
  .clk_100(clk_100), // generated 100 Hz clock
  .clk_2k(clk_2k), // generated 2k clock for scan control
  .clk(clk),
  .rst_n(rst_n)
);

Light U_L(
  .light_warn(light_warn), // 0: red1, 1: red2, 2:green1, 3: green2
  .mode_num(mode_num), // segs of mode
  .btn_led(btn_led),
  .clk_1(clk_1), // 1Hz
  .clk(clk), // 100MHz
  .rst_n(rst_n)
);

// Scan control
scan_ctl U_SC(
  .ssd_ctl(ssd_ctl), // ssd display control signal
  .ssd_in(ssd_in), // output to ssd display
  .in0(volumn_cnt0), // 1st input
  .in1(volumn_cnt1), // 2nd input
  .in2(`F_NULL), // 3rd input
  .in3(mode_num),  // 4th input
  .ssd_ctl_en(clk_2k), // divided clock for scan control
  .rst_n(rst_n)
);

// binary to 7-segment display decoder
display U_display(
  .segs(segs), // 7-segment display output
  .bin(ssd_in)  // BCD number input
);

endmodule
