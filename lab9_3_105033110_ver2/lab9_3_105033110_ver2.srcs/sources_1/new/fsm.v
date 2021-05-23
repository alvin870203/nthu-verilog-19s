module fsm(
  //output reg en,
  output in_trig,
  output reg [2:0] state,
  input [511:0] key_down,
  input [8:0] last_change,
  input key_valid,
  input clk, // 100MHz
  input rst_n
);

parameter [2:0] STATE_START = 3'b110;
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

wire in_trig_num;
reg in_trig_delay_num;
reg enter_num;
wire enter_next_num;

wire in_trig_operator;
reg in_trig_delay_operator;
reg enter_operator;
wire enter_next_operator;

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
    
    
// One-pulse
assign in_trig_operator = key_down[121] | key_down[123] | key_down[124]; // +/-/* key

always @(posedge clk or negedge rst_n)
  if (~rst_n)
    in_trig_delay_operator <= 1'b0; 
  else
    in_trig_delay_operator <= in_trig_operator;
    
assign enter_next_operator = in_trig_operator & (~in_trig_delay_operator);

always @(posedge clk or negedge rst_n)
  if (~rst_n)
    enter_operator <=1'b0;
  else
    enter_operator <= enter_next_operator; // One-pulse press Enter


// FSM
always @*
begin
  //en = 0;
  state_next = STATE_START;
  case (state)
    STATE_START:
      if (enter_num)
      begin
        //en = 0;//1;
        state_next = STATE_NUM0_1;
      end
      else
      begin
        //en = 0;//0;
        state_next = STATE_START;
      end      
    STATE_NUM0_1:
      if (enter_num)
      begin
        //en = 0;//1;
        state_next = STATE_NUM0_0;
      end
      else
      begin
        //en = 0;//0;
        state_next = STATE_NUM0_1;
      end
    STATE_NUM0_0:
      if (enter_operator)
      begin
        //en = 0;
        state_next = STATE_OPERATOR;
      end
      else if (enter_num)
      begin
        //en = 1;
        state_next = STATE_NUM0_0;
      end
      else
      begin
        //en = 0; // don't get key from previous state
        state_next = STATE_NUM0_0; 
      end   
    STATE_OPERATOR:
      if (enter_num)
      begin
        //en = 0;
        state_next = STATE_NUM1_1;
      end
      else
      begin
        //en = 1;
        state_next = STATE_OPERATOR;
      end
    STATE_NUM1_1:
      if (enter_num) // key for next state
      begin
        //en = 0; // don't get at this state
        state_next = STATE_NUM1_0;
      end
      else
      begin
        //en = 1;
        //en = (state_next != STATE_NUM1_0) ? 1 : 0; // get key from previous state
        state_next = STATE_NUM1_1;
      end
    STATE_NUM1_0:
      if (enter)
      begin
        //en = 0;
        state_next = STATE_ANS;
      end
      else if (enter_num)
      begin
        //en = 1;
        state_next = STATE_NUM1_0;
      end
      else
      begin
        //en = 1;
        state_next = STATE_NUM1_0;
      end
    STATE_ANS:
    begin
      //en = 0;
      state_next = STATE_ANS;
    end
  endcase
end


always @(posedge clk or negedge rst_n)
  if (~rst_n)
  begin
    state <= STATE_START;
    //en_prev <= 0;
  end
  else
  begin
    state <= state_next;
    //en_prev <= en;
  end       
   

endmodule
