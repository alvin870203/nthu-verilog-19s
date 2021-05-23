module fsm(
  output reg en,
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



wire in_trig_num;
reg in_trig_delay_num;
reg enter_num;
wire enter_next_num;




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




// FSM
always @*
  case (state)
    STATE_NUM0:
      if (enter_num)
      begin
        en = 1;
        state_next = STATE_NUM1;
      end
      else
      begin
        en = 0;
        state_next = STATE_NUM0;
      end
    STATE_NUM1:
      if (enter)
      begin
        en = 0;
        state_next = STATE_ANS;
      end
      else if (enter_num)
      begin
        en = 1;
        state_next = STATE_NUM1;
      end
      else
      begin
        en = 0;
        state_next = STATE_NUM1;        
      end
    STATE_ANS:
    begin
      state_next = STATE_ANS;
      en = 0;
    end
    default:
    begin
      state_next = STATE_NUM0;
      en = 0;
    end
  endcase

always @(posedge clk or negedge rst_n)
  if (~rst_n)
    state <= STATE_NUM0;
  else
    state <= state_next;       
    

endmodule
