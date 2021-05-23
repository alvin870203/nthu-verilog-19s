// 8-2
`timescale 1ns / 1ps
`include "global.v"
module Alarm(
  output audio_mclk,
  output audio_lrck,
  output audio_sck,
  output audio_sdin,
  output led_alarm,
  output [`BCD_BIT_WIDTH-1:0] volumn_cnt0, // to scan_ctl in0
  output [`BCD_BIT_WIDTH-1:0] volumn_cnt1, // to scan_ctl in1
  input volumn_up_pb,
  input volumn_down_pb,
  input dip_alarm,
  input clk_1,
  input clk_2,
  input clk_100,
  input clk_2k,
  input clk,
  input rst_n
);

// Declare internal nodes
wire up_db, down_db;
wire up_1pulse, down_1pulse;
wire [15:0] volumn;
wire mute;
wire [21:0] note_div;
wire [15:0] audio_in_left, audio_in_right;

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

// alarm control
alarm_ctl U_AC(
  .led_alarm(led_alarm),
  .note_div(note_div),
  .mute(mute),
  .dip_alarm(dip_alarm),
  .clk(clk_2),
  .rst_n(rst_n)
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