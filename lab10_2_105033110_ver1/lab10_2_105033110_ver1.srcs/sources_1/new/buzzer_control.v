`timescale 1ns / 1ps
module buzzer_control(
  clk, // clock from crystal
  rst_n, // active low reset
  mute,
  note_div, // div for note generation
  volumn_left, // magnitude of left volumn (positive) // 16'h0000~16'h7FFF
  volumn_right, // magnitude of right volumn (positive) // 16'h0000~16'h7FFF
  audio_left, // left sound audio
  audio_right // right sound audio
);

// I/O declaration
input clk; // clock from crystal
input rst_n; // active low reset
input mute;
input [21:0] note_div; // div for note generation
input [15:0] volumn_left;
input [15:0] volumn_right;
output reg [15:0] audio_left; // left sound audio
output reg [15:0] audio_right; // right sound audio

// Declare internal signals
reg [21:0] clk_cnt_next, clk_cnt;
reg b_clk, b_clk_next;
wire [15:0] volumn_left_neg; // -magnitude of left volumn (negative)
wire [15:0] volumn_right_neg; // -magnitude of right volumn (negative)

// Note frequency generation
always @(posedge clk or negedge rst_n)
  if (~rst_n)
  begin
    clk_cnt <= 22'd0;
    b_clk <= 1'b0;
  end
  else
  begin
    clk_cnt <= clk_cnt_next;
    b_clk <= b_clk_next;
  end
	 
always @*
  if (clk_cnt == note_div)
  begin
    clk_cnt_next = 22'd0;
    b_clk_next = ~b_clk;
  end
  else
  begin
    clk_cnt_next = clk_cnt + 1'b1;
    b_clk_next = b_clk;
  end

// Assign the amplitude of the note
// same magnitude 2'compliment -> positive = (~negative)+1
assign volumn_left_neg = (~volumn_left) + 1'b1;
assign volumn_right_neg = (~volumn_right) + 1'b1;

always @*
  if (~mute)
  begin
    audio_left = (b_clk == 1'b0) ? volumn_left_neg : volumn_left;
    audio_right = (b_clk == 1'b0) ? volumn_right_neg : volumn_right;    
  end
  else
  begin
    audio_left = 16'd0;
    audio_right = 16'd0;
  end


endmodule
