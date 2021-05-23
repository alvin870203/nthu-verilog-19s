`include "global.v"
module electronic_organ(
  output high_led,
  output state,
  output [`SSD_BIT_WIDTH-1:0] segs,
  output [`BCD_BIT_WIDTH-1:0]  ssd_ctl,
  output audio_mclk, // master clock
  output audio_lrck, // left-right clock
  output audio_sck, // serial clock
  output audio_sdin, // serial audio data input
  inout PS2_DATA, // B17
  inout PS2_CLK, // C17
  input clk, // clock from oscillator
  input rst_n // DIP switch, low-active reset
);

wire [511:0] key_down;
wire [8:0] last_change;
wire key_valid;
wire [`SSD_NUM-1:0] ssd_in;
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
  .state(state),
  .freq(freq),
  .key_down(key_down),
  .last_change(last_change),
  .key_valid(key_valid),
  .clk(clk),
  .rst_n(rst_n)
);

scan_ctl U_SC(
  .ssd_ctl(ssd_ctl), // ssd display control signal 
  .ssd_in(ssd_in), // output to ssd display
  .in0(freq), // 1st input
  .in1(`F_NULL), // 2nd input
  .in2(`F_NULL), // 3rd input
  .in3(`F_NULL),  // 4th input
  .ssd_ctl_en(clk_2k), // divided clock for scan control
  .rst_n(rst_n)
);

// binary to 7-segment display decoder
display U_D(
  .high_led(high_led),
  .segs(segs), // 7-segment display output
  .bin(ssd_in)  // BCD number input
);


endmodule
