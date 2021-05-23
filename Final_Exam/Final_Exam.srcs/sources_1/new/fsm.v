`include "global.v"
module fsm(
  output reg [3:0] state_shift,
  output reg [3:0] state,
  input switch,
  input clk,
  input rst_n,
  input switch_left
);

reg [3:0] state_next;
reg [3:0] state_next_shift;

always @*
begin
  state_next = 4'd0;
  case (state)
  4'd0:
    if (switch)
      state_next = 4'd1;
    else
      state_next = 4'd0;
  4'd1:
    if (switch)
      state_next = 4'd2;
    else
      state_next = 4'd1;
  4'd2:
    if (switch)
      state_next = 4'd3;
    else
      state_next = 4'd2;
  4'd3:
    if (switch)
      state_next = 4'd4;
    else
      state_next = 4'd3;
  4'd4:
    if (switch)
      state_next = 4'd5;
    else
      state_next = 4'd4; 
  4'd5:
    if (switch)
      state_next = 4'd6;
    else
      state_next = 4'd5;   
  4'd6:
    if (switch)
      state_next = 4'd7;
    else
      state_next = 4'd6;
  4'd7:
    if (switch)
      state_next = 4'd8;
    else
      state_next = 4'd7;      
  4'd8:
      state_next = 4'd8;
  endcase                                   
end

// state register
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    state <=4'b0;
  else
    state <= state_next;
    
always @*
  case (state_shift)
  4'b0:
    if (switch_left)
      state_next_shift = 4'b1;
    else
      state_next_shift = 4'b0;
  4'b1:
    state_next_shift = 4'b1;
  default:
    state_next_shift = 4'b0;
  endcase
  
always @(posedge clk or negedge rst_n)
    if (~rst_n)
      state_shift <=4'b0;
    else
      state_shift <= state_next_shift;      

endmodule
