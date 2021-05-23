module fsm(
  output in_trig,
  output reg [1:0] state,
  input [511:0] key_down,
  input [8:0] last_change,
  input key_valid,
  input clk, // 100MHz
  input rst_n
);

parameter [1:0] STATE_NUM0 = 2'b00;
parameter [1:0] STATE_NUM1 = 2'b10;
parameter [1:0] STATE_ANS = 2'b11;

//wire in_trig;
reg in_trig_delay;
reg enter;
wire enter_next;
reg [1:0] state_next;

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


// FSM
always @*
  case (state)
    STATE_NUM0:
      if (enter)
        state_next = STATE_NUM1;
      else
        state_next = STATE_NUM0;
    STATE_NUM1:
      if (enter)
        state_next = STATE_ANS;
      else
        state_next = STATE_NUM1;
    STATE_ANS:
        state_next = STATE_ANS;
    default:
        state_next = STATE_NUM0;
  endcase

always @(posedge clk or negedge rst_n)
  if (~rst_n)
    state <= STATE_NUM0;
  else
    state <= state_next;       
    

endmodule
