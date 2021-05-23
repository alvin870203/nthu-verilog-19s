module keyboard_ctl(
  output reg state, // low or caps
  output reg [6:0] key_num_next, // ascii
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
        key_num_next = 7'd65;
      else if (key_down[50] == 1'b1)
        key_num_next = 7'd66;
      else if (key_down[33] == 1'b1)
        key_num_next = 7'd67;
      else if (key_down[35] == 1'b1)
        key_num_next = 7'd68;
      else if (key_down[36] == 1'b1)
        key_num_next = 7'd69;
      else if (key_down[43] == 1'b1)
        key_num_next = 7'd70;
      else if (key_down[52] == 1'b1)
        key_num_next = 7'd71;
      else if (key_down[51] == 1'b1)
        key_num_next = 7'd72;
      else if (key_down[67] == 1'b1)
        key_num_next = 7'd73;
      else if (key_down[59] == 1'b1)
        key_num_next = 7'd74;
      else if (key_down[66] == 1'b1)
        key_num_next = 7'd75;
      else if (key_down[75] == 1'b1)
        key_num_next = 7'd76;
      else if (key_down[58] == 1'b1)
        key_num_next = 7'd77;
      else if (key_down[49] == 1'b1)
        key_num_next = 7'd78;
      else if (key_down[68] == 1'b1)
        key_num_next = 7'd79;
      else if (key_down[77] == 1'b1)
        key_num_next = 7'd80;
      else if (key_down[21] == 1'b1)
        key_num_next = 7'd81;
      else if (key_down[45] == 1'b1)
        key_num_next = 7'd82;
      else if (key_down[27] == 1'b1)
        key_num_next = 7'd83;
      else if (key_down[44] == 1'b1)
        key_num_next = 7'd84;
      else if (key_down[60] == 1'b1)
        key_num_next = 7'd85;
      else if (key_down[42] == 1'b1)
        key_num_next = 7'd86;
      else if (key_down[29] == 1'b1)
        key_num_next = 7'd87;
      else if (key_down[34] == 1'b1)
        key_num_next = 7'd88;
      else if (key_down[53] == 1'b1)
        key_num_next = 7'd89;
      else if (key_down[26] == 1'b1)
        key_num_next = 7'd90;
      else
        key_num_next = 7'd0;
    else
      if (key_down[28] == 1'b1)
        key_num_next = 7'd97;
      else if (key_down[50] == 1'b1)
        key_num_next = 7'd98;
      else if (key_down[33] == 1'b1)
        key_num_next = 7'd99;
      else if (key_down[35] == 1'b1)
        key_num_next = 7'd100;
      else if (key_down[36] == 1'b1)
        key_num_next = 7'd101;
      else if (key_down[43] == 1'b1)
        key_num_next = 7'd102;
      else if (key_down[52] == 1'b1)
        key_num_next = 7'd103;
      else if (key_down[51] == 1'b1)
        key_num_next = 7'd104;
      else if (key_down[67] == 1'b1)
        key_num_next = 7'd105;
      else if (key_down[59] == 1'b1)
        key_num_next = 7'd106;
      else if (key_down[66] == 1'b1)
        key_num_next = 7'd107;
      else if (key_down[75] == 1'b1)
        key_num_next = 7'd108;
      else if (key_down[58] == 1'b1)
        key_num_next = 7'd109;
      else if (key_down[49] == 1'b1)
        key_num_next = 7'd110;
      else if (key_down[68] == 1'b1)
        key_num_next = 7'd111;
      else if (key_down[77] == 1'b1)
        key_num_next = 7'd112;
      else if (key_down[21] == 1'b1)
        key_num_next = 7'd113;
      else if (key_down[45] == 1'b1)
        key_num_next = 7'd114;
      else if (key_down[27] == 1'b1)
        key_num_next = 7'd115;
      else if (key_down[44] == 1'b1)
        key_num_next = 7'd116;
      else if (key_down[60] == 1'b1)
        key_num_next = 7'd117;
      else if (key_down[42] == 1'b1)
        key_num_next = 7'd118;
      else if (key_down[29] == 1'b1)
        key_num_next = 7'd119;
      else if (key_down[34] == 1'b1)
        key_num_next = 7'd120;
      else if (key_down[53] == 1'b1)
        key_num_next = 7'd121;
      else if (key_down[26] == 1'b1)
        key_num_next = 7'd122;
      else
        key_num_next = 7'd0;
  else
    if (key_down[18] == 1'b1 || key_down[89] == 1'b1)
      if (key_down[28] == 1'b1)
        key_num_next = 7'd97;
      else if (key_down[50] == 1'b1)
        key_num_next = 7'd98;
      else if (key_down[33] == 1'b1)
        key_num_next = 7'd99;
      else if (key_down[35] == 1'b1)
        key_num_next = 7'd100;
      else if (key_down[36] == 1'b1)
        key_num_next = 7'd101;
      else if (key_down[43] == 1'b1)
        key_num_next = 7'd102;
      else if (key_down[52] == 1'b1)
        key_num_next = 7'd103;
      else if (key_down[51] == 1'b1)
        key_num_next = 7'd104;
      else if (key_down[67] == 1'b1)
        key_num_next = 7'd105;
      else if (key_down[59] == 1'b1)
        key_num_next = 7'd106;
      else if (key_down[66] == 1'b1)
        key_num_next = 7'd107;
      else if (key_down[75] == 1'b1)
        key_num_next = 7'd108;
      else if (key_down[58] == 1'b1)
        key_num_next = 7'd109;
      else if (key_down[49] == 1'b1)
        key_num_next = 7'd110;
      else if (key_down[68] == 1'b1)
        key_num_next = 7'd111;
      else if (key_down[77] == 1'b1)
        key_num_next = 7'd112;
      else if (key_down[21] == 1'b1)
        key_num_next = 7'd113;
      else if (key_down[45] == 1'b1)
        key_num_next = 7'd114;
      else if (key_down[27] == 1'b1)
        key_num_next = 7'd115;
      else if (key_down[44] == 1'b1)
        key_num_next = 7'd116;
      else if (key_down[60] == 1'b1)
        key_num_next = 7'd117;
      else if (key_down[42] == 1'b1)
        key_num_next = 7'd118;
      else if (key_down[29] == 1'b1)
        key_num_next = 7'd119;
      else if (key_down[34] == 1'b1)
        key_num_next = 7'd120;
      else if (key_down[53] == 1'b1)
        key_num_next = 7'd121;
      else if (key_down[26] == 1'b1)
        key_num_next = 7'd122;
      else
        key_num_next = 7'd0;
    else
      if (key_down[28] == 1'b1)
        key_num_next = 7'd65;
      else if (key_down[50] == 1'b1)
        key_num_next = 7'd66;
      else if (key_down[33] == 1'b1)
        key_num_next = 7'd67;
      else if (key_down[35] == 1'b1)
        key_num_next = 7'd68;
      else if (key_down[36] == 1'b1)
        key_num_next = 7'd69;
      else if (key_down[43] == 1'b1)
        key_num_next = 7'd70;
      else if (key_down[52] == 1'b1)
        key_num_next = 7'd71;
      else if (key_down[51] == 1'b1)
        key_num_next = 7'd72;
      else if (key_down[67] == 1'b1)
        key_num_next = 7'd73;
      else if (key_down[59] == 1'b1)
        key_num_next = 7'd74;
      else if (key_down[66] == 1'b1)
        key_num_next = 7'd75;
      else if (key_down[75] == 1'b1)
        key_num_next = 7'd76;
      else if (key_down[58] == 1'b1)
        key_num_next = 7'd77;
      else if (key_down[49] == 1'b1)
        key_num_next = 7'd78;
      else if (key_down[68] == 1'b1)
        key_num_next = 7'd79;
      else if (key_down[77] == 1'b1)
        key_num_next = 7'd80;
      else if (key_down[21] == 1'b1)
        key_num_next = 7'd81;
      else if (key_down[45] == 1'b1)
        key_num_next = 7'd82;
      else if (key_down[27] == 1'b1)
        key_num_next = 7'd83;
      else if (key_down[44] == 1'b1)
        key_num_next = 7'd84;
      else if (key_down[60] == 1'b1)
        key_num_next = 7'd85;
      else if (key_down[42] == 1'b1)
        key_num_next = 7'd86;
      else if (key_down[29] == 1'b1)
        key_num_next = 7'd87;
      else if (key_down[34] == 1'b1)
        key_num_next = 7'd88;
      else if (key_down[53] == 1'b1)
        key_num_next = 7'd89;
      else if (key_down[26] == 1'b1)
        key_num_next = 7'd90;
      else
        key_num_next = 7'd0;
/*
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    key_num <= 7'd0;
  else
    key_num <= key_num_next;
*/

endmodule
