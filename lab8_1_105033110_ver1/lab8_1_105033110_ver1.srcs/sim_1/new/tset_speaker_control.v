`timescale 1ns / 1ps
module tset_speaker_control;

wire sck;
wire lrck;
wire audio_sdin;
reg [15:0] audio_in_left;
reg [15:0] audio_in_right;
reg clk;
reg rst_n;

speaker_control U_sc_test(
  .clk(clk),  // clock from the crystal
  .rst_n(rst_n),  // active low reset
  .audio_in_left(audio_in_left), // left channel audio data input
  .audio_in_right(audio_in_right), // right channel audio data input
  .audio_mclk(), // master clock
  .audio_lrck(lrck), // left-right clock
  .audio_sck(sck), // serial clock
  .audio_sdin(audio_sdin) // serial audio data input
);

always
  #1 clk = ~clk;

initial
begin
  audio_in_left = 0;
  audio_in_right = 0;
  clk = 0;
  rst_n = 0;
end

initial
begin
  #2 rst_n = 1;
  #1023 audio_in_left = 16'h5000; audio_in_right = 16'h5000;
  #1024 audio_in_left = 16'hB000; audio_in_right = 16'hB000;
  #1024 audio_in_left = 0; audio_in_right = 0;
end

endmodule
