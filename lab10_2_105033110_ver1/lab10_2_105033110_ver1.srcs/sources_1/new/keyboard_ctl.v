`include "global.v"
module keyboard_ctl(
  output reg state, // low or caps
  output reg [`BCD_BIT_WIDTH-1:0] freq, 
  input [511:0] key_down,
  input [8:0] last_change,
  input key_valid,
  input clk, // 100MHz
  input rst_n
);

parameter STATE_CAPS = 1'b1;
parameter STATE_LOW = 1'b0;

//reg [6:0] key_num_next;

wire in_trig;
reg in_trig_delay;
reg enter;
wire enter_next;
reg state_next;

// One-pulse
assign in_trig = key_down[88]; // Caps

always @(posedge clk or negedge rst_n)
  if (~rst_n)
    in_trig_delay <= 1'b0; 
  else
    in_trig_delay <= in_trig;
    
assign enter_next = in_trig & (~in_trig_delay);

always @(posedge clk or negedge rst_n)
  if (~rst_n)
    enter <=1'b0;
  else
    enter <= enter_next; // One-pulse press Enter

// FSM
always @*
  case (state)
    STATE_CAPS:
      if (enter)
        state_next = STATE_LOW;
      else
        state_next = STATE_CAPS;
    STATE_LOW:
      if (enter)
        state_next = STATE_CAPS;
      else
        state_next = STATE_LOW;
    default:
      state_next = STATE_LOW;
  endcase

always @(posedge clk or negedge rst_n)
  if (~rst_n)
    state <= STATE_LOW;
  else
    state <= state_next; 


always @*
  if (state == STATE_LOW)
    if (key_down[18] == 1'b1 || key_down[89] == 1'b1)
      if (key_down[28] == 1'b1)
        freq = `THIRTEEN;
      else if (key_down[50] == 1'b1)
        freq = `FOURTEEN;
      else if (key_down[33] == 1'b1)
        freq = `EIGHT; // C -> high Do
      else if (key_down[35] == 1'b1)
        freq = `NINE;
      else if (key_down[36] == 1'b1)
        freq = `TEN;
      else if (key_down[43] == 1'b1)
        freq = `ELEVEN;
      else if (key_down[52] == 1'b1)
        freq = `TWELVE;
      else
        freq = `ZERO;
    else
      if (key_down[28] == 1'b1)
        freq = `SIX;
      else if (key_down[50] == 1'b1)
        freq = `SEVEN;
      else if (key_down[33] == 1'b1)
        freq = `ONE; // c -> mid Do
      else if (key_down[35] == 1'b1)
        freq = `TWO;
      else if (key_down[36] == 1'b1)
        freq = `THREE;
      else if (key_down[43] == 1'b1)
        freq = `FOUR;
      else if (key_down[52] == 1'b1)
        freq = `FIVE;
      else
        freq = `ZERO;
  else
    if (key_down[18] == 1'b1 || key_down[89] == 1'b1)
      if (key_down[28] == 1'b1)
        freq = `SIX;
      else if (key_down[50] == 1'b1)
        freq = `SEVEN;
      else if (key_down[33] == 1'b1)
        freq = `ONE; // c -> mid Do
      else if (key_down[35] == 1'b1)
        freq = `TWO;
      else if (key_down[36] == 1'b1)
        freq = `THREE;
      else if (key_down[43] == 1'b1)
        freq = `FOUR;
      else if (key_down[52] == 1'b1)
        freq = `FIVE;
      else
        freq = `ZERO;
    else
      if (key_down[28] == 1'b1)
        freq = `THIRTEEN;
      else if (key_down[50] == 1'b1)
        freq = `FOURTEEN;
      else if (key_down[33] == 1'b1)
        freq = `EIGHT; // C -> high Do
      else if (key_down[35] == 1'b1)
        freq = `NINE;
      else if (key_down[36] == 1'b1)
        freq = `TEN;
      else if (key_down[43] == 1'b1)
        freq = `ELEVEN;
      else if (key_down[52] == 1'b1)
        freq = `TWELVE;
      else
        freq = `ZERO;
/*
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    key_num <= 7'd0;
  else
    key_num <= key_num_next;
*/

endmodule
