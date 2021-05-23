`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:29:22 05/02/2012 
// Design Name: 
// Module Name:    speaker_control 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module speaker_control(
  clk,  // clock from the crystal
  rst_n,  // active low reset
  audio_in_left, // left channel audio data input
  audio_in_right, // right channel audio data input
  audio_mclk, // master clock
  audio_lrck, // left-right clock, Word Select clock, or sample rate clock
  audio_sck, // serial clock
  audio_sdin // serial audio data input
);

// I/O declaration
input clk;  // clock from the crystal
input rst_n;  // active low reset
input [15:0] audio_in_left; // left channel audio data input
input [15:0] audio_in_right; // right channel audio data input
output audio_mclk; // master clock
output audio_lrck; // left-right clock
output audio_sck; // serial clock
output audio_sdin; // serial audio data input
reg audio_sdin;

// Declare internal signal nodes 
wire [8:0] clk_cnt_next;
reg [8:0] clk_cnt;
reg [15:0] audio_left, audio_right;

// Counter for the clock divider
assign clk_cnt_next = clk_cnt + 1'b1;

always @(posedge clk or negedge rst_n)
  if (~rst_n)
    clk_cnt <= 9'd0;
  else
    clk_cnt <= clk_cnt_next;

// Assign divided clock output
assign audio_mclk = clk_cnt[1];
assign audio_lrck = clk_cnt[8];
assign audio_sck = 1'b1; // use internal serial clock mode
//assign audio_sck = clk_cnt[3]; // can also use this to replace line60

// audio input data buffer
//always @(posedge clk_cnt[8] or negedge rst_n) // can also use this to replace line65
always @(posedge clk_cnt[4] or negedge rst_n)
  if (~rst_n)
  begin
    audio_left <= 16'd0;
    audio_right <= 16'd0;
  end
  else
  begin
    audio_left <= audio_in_left;
    audio_right <= audio_in_right;
  end

always @* // combine mux and output register
  case (clk_cnt[8:4])
    5'b00000: audio_sdin = audio_right[0];
    5'b00001: audio_sdin = audio_left[15];
    5'b00010: audio_sdin = audio_left[14];
    5'b00011: audio_sdin = audio_left[13];
    5'b00100: audio_sdin = audio_left[12];
    5'b00101: audio_sdin = audio_left[11];
    5'b00110: audio_sdin = audio_left[10];
    5'b00111: audio_sdin = audio_left[9];
    5'b01000: audio_sdin = audio_left[8];
    5'b01001: audio_sdin = audio_left[7];
    5'b01010: audio_sdin = audio_left[6];
    5'b01011: audio_sdin = audio_left[5];
    5'b01100: audio_sdin = audio_left[4];
    5'b01101: audio_sdin = audio_left[3];
    5'b01110: audio_sdin = audio_left[2];
    5'b01111: audio_sdin = audio_left[1];
    5'b10000: audio_sdin = audio_left[0];
    5'b10001: audio_sdin = audio_right[15];
    5'b10010: audio_sdin = audio_right[14];
    5'b10011: audio_sdin = audio_right[13];
    5'b10100: audio_sdin = audio_right[12];
    5'b10101: audio_sdin = audio_right[11];
    5'b10110: audio_sdin = audio_right[10];
    5'b10111: audio_sdin = audio_right[9];
    5'b11000: audio_sdin = audio_right[8];
    5'b11001: audio_sdin = audio_right[7];
    5'b11010: audio_sdin = audio_right[6];
    5'b11011: audio_sdin = audio_right[5];
    5'b11100: audio_sdin = audio_right[4];
    5'b11101: audio_sdin = audio_right[3];
    5'b11110: audio_sdin = audio_right[2];
    5'b11111: audio_sdin = audio_right[1];
    default: audio_sdin = 1'b0;
  endcase

endmodule
