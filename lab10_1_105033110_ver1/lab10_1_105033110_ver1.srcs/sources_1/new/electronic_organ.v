`timescale 1ns / 1ps
`include "global.v"
module electric_organ(
  clk, // clock from crystal
  rst_n, // active low reset
  audio_mclk, // master clock
  audio_lrck, // left-right clock
  audio_sck, // serial clock
  audio_sdin // serial audio data input
);

// I/O declaration
input clk;  // clock from the crystal
input rst_n;  // active low reset
output audio_mclk; // master clock
output audio_lrck; // left-right clock
output audio_sck; // serial clock
output audio_sdin; // serial audio data input

// Declare internal nodes
wire [15:0] audio_in_left, audio_in_right;
wire mute;
wire [21:0] note_div;
wire clk_1;
wire clk_2k;
wire [`BCD_BIT_WIDTH-1:0] freq;

// clock generator
clock_generator U_cg(
  .clk_1(clk_1), // generated 1Hz clock for counter
  .clk_2k(clk_2k), // generated 2k clock for scan control
  .clk(clk), // clock from crystal
  .rst_n(rst_n) // active low reset
);

// counter count from 1 to 14 repeatedly
counter U_C(
  .freq(freq),
  .clk(clk_1), // 1Hz
  .rst_n(rst_n)
);

// push button select Do Re Mi
DoReMi U_drm(
  .note_div(note_div),
  .mute(mute),
  .freq(freq)
);

// Note generation
buzzer_control Ubc(
  .clk(clk), // clock from crystal
  .rst_n(rst_n), // active low reset
  .mute(mute),
  .note_div(note_div), // div for note generation
  .volumn_left(16'h7FFF),
  .volumn_right(16'h7FFF),
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