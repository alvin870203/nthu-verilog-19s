`timescale 1ns / 1ps
`include "global.v"
module speaker(
  clk, // clock from crystal
  rst_n, // active low reset
  Do_pb,
  Re_pb,
  Mi_pb,
  volumn_up_pb,
  volumn_down_pb,
  segs,  // 7-segment display
  ssd_ctl, // scan control for 7-segment display
  audio_mclk, // master clock
  audio_lrck, // left-right clock
  audio_sck, // serial clock
  audio_sdin // serial audio data input
);

// I/O declaration
input clk;  // clock from the crystal
input rst_n;  // active low reset
input Do_pb;
input Re_pb;
input Mi_pb;
input volumn_up_pb;
input volumn_down_pb;
output [`SSD_BIT_WIDTH-1:0] segs;  // 7-segment display
output [`SSD_NUM-1:0] ssd_ctl; // scan control for 7-segment display
output audio_mclk; // master clock
output audio_lrck; // left-right clock
output audio_sck; // serial clock
output audio_sdin; // serial audio data input

// Declare internal nodes
wire [15:0] audio_in_left, audio_in_right;
wire mute;
wire [21:0] note_div;
wire [15:0] volumn;
wire clk_100, clk_2k;
wire up_db, down_db;
wire up_1pulse, down_1pulse;
wire [`BCD_BIT_WIDTH-1:0] volumn_cnt0, volumn_cnt1;
wire [`BCD_BIT_WIDTH-1:0] ssd_in;

// clock generator
clock_generator U_cg(
  .clk_100(clk_100), // generated 100 Hz clock
  .clk_2k(clk_2k), // generated 2k clock for scan control
  .clk(clk), // clock from crystal
  .rst_n(rst_n) // active low reset
);

// debounce circuit - up & down
debounce_circuit U_db_up(
  .pb_debounced(up_db), // debounced push button output
  .pb_in(volumn_up_pb), //push button input
  .clk(clk_100), // clock control
  .rst_n(rst_n) // reset
);

debounce_circuit U_db_down(
  .pb_debounced(down_db), // debounced push button output
  .pb_in(volumn_down_pb), //push button input
  .clk(clk_100), // clock control
  .rst_n(rst_n) // reset
);

// 1 pulse generation circuit - up & down
one_pulse U_op_up(
  .out_pulse(up_1pulse), // output one pulse
  .in_trig(up_db), // input trigger
  .clk(clk_100),  // clock input
  .rst_n(rst_n) //active high reset 
);

one_pulse U_op_down(
  .out_pulse(down_1pulse), // output one pulse
  .in_trig(down_db), // input trigger
  .clk(clk_100),  // clock input
  .rst_n(rst_n) //active high reset 
);

// volumn control
volumn_control U_vc(
  .volumn(volumn),
  .volumn_cnt0(volumn_cnt0),
  .volumn_cnt1(volumn_cnt1),
  .up_cnt_en(up_1pulse), // one_pulse input
  .down_cnt_en(down_1pulse), // one_pulse input
  .clk(clk_100),
  .rst_n(rst_n)
);

// Scan control
scan_ctl U_SC(
  .ssd_ctl(ssd_ctl), // ssd display control signal
  .ssd_in(ssd_in), // output to ssd display
  .in0(volumn_cnt0), // 1st input
  .in1(volumn_cnt1), // 2nd input
  .in2(`F_NULL), // 3rd input
  .in3(`F_NULL),  // 4th input
  .ssd_ctl_en(clk_2k), // divided clock for scan control
  .rst_n(rst_n)
);

// binary to 7-segment display decoder
display U_display(
  .segs(segs), // 7-segment display output
  .bin(ssd_in)  // BCD number input
);

// push button select Do Re Mi
DoReMi U_drm(
  .note_div(note_div),
  .mute(mute),
  .Do_pb(Do_pb),
  .Re_pb(Re_pb),
  .Mi_pb(Mi_pb)
);

// Note generation
buzzer_control Ubc(
  .clk(clk), // clock from crystal
  .rst_n(rst_n), // active low reset
  .mute(mute),
  .note_div(note_div), // div for note generation
  .volumn_left(volumn),
  .volumn_right(volumn),
  .audio_left(audio_in_left), // left sound audio
  .audio_right(audio_in_right) // right sound audio
);

// Speaker controllor
speaker_control Usc(
  .clk(clk),  // clock from the crystal
  .rst_n(rst_n),  // active low reset
  .audio_in_left(audio_in_left), // left channel audio data input
  .audio_in_right(audio_in_right), // right channel audio data input
  .audio_mclk(audio_mclk), // master clock
  .audio_lrck(audio_lrck), // left-right clock
  .audio_sck(audio_sck), // serial clock
  .audio_sdin(audio_sdin) // serial audio data input
);

endmodule
