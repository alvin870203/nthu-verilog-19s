module fsm(
  output in_trig,
  output reg [2:0] state,
  input [511:0] key_down,
  input [8:0] last_change,
  input key_valid,
  input clk, // 100MHz
  input rst_n
);

parameter [2:0] STATE_NUM0_1 = 3'b000;
parameter [2:0] STATE_NUM0_0 = 3'b001;
parameter [2:0] STATE_OPERATOR = 3'b010;
parameter [2:0] STATE_NUM1_1 = 3'b011;
parameter [2:0] STATE_NUM1_0 = 3'b100;
parameter [2:0] STATE_ANS = 3'b101;

//wire in_trig;
reg in_trig_delay;
reg enter;
wire enter_next;
/*
wire in_trig_num;
reg in_trig_delay_num;
reg enter_num;
wire enter_next_num;
*/
reg [2:0] state_next;

// One-pulse
assign in_trig = key_down[90]; // Enter

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
    
/*
// One-pulse
assign in_trig_num = key_down[112] | key_down[105] | key_down[114] | key_down[122] | key_down[107] | key_down[115] | key_down[116] | key_down[108] | key_down[117] | key_down[125]; // NUM key

always @(posedge clk or negedge rst_n)
  if (~rst_n)
    in_trig_delay_num <= 1'b0; 
  else
    in_trig_delay_num <= in_trig_num;
    
assign enter_next_num = in_trig_num & (~in_trig_delay_num);

always @(posedge clk or negedge rst_n)
  if (~rst_n)
    enter_num <=1'b0;
  else
    enter_num <= enter_next_num; // One-pulse press Enter
*/

// FSM
always @*
  case (state)
    STATE_NUM0_1:
      if (enter)
        state_next = STATE_NUM0_0;
      else
        state_next = STATE_NUM0_1;
    STATE_NUM0_0:
      if (enter)
        state_next = STATE_OPERATOR;
      else
        state_next = STATE_NUM0_0;    
    STATE_OPERATOR:
      if (enter)
        state_next = STATE_NUM1_1;
      else
        state_next = STATE_OPERATOR;
    STATE_NUM1_1:
      if (enter)
        state_next = STATE_NUM1_0;
      else
        state_next = STATE_NUM1_1;
    STATE_NUM1_0:
      if (enter)
        state_next = STATE_ANS;
      else
        state_next = STATE_NUM1_0;
    STATE_ANS:
        state_next = STATE_ANS;
    default:
        state_next = STATE_NUM0_1;
  endcase

always @(posedge clk or negedge rst_n)
  if (~rst_n)
    state <= STATE_NUM0_1;
  else
    state <= state_next;       
    

endmodule
