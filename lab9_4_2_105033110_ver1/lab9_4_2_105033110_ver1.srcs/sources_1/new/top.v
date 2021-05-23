module top(
  output state,
  output [6:0] key_num,
  inout PS2_DATA, // B17
  inout PS2_CLK, // C17
  input clk, // clock from oscillator
  input rst_n // DIP switch, low-active reset
);

wire [511:0] key_down;
wire [8:0] last_change;
wire key_valid;

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
  .key_num_next(key_num),
  .key_down(key_down),
  .last_change(last_change),
  .key_valid(key_valid),
  .clk(clk),
  .rst_n(rst_n)
);


endmodule
