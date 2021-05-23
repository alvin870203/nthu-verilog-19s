`timescale 1ns / 1ps
`include "global.v"
module fsm(
  state, // state of fsm
  count_enable, // if counter is enable
  in, // input control
  clk, // clock for fsm
  rst_n // low active reset
);

output state;
output count_enable;
input in;
input clk;
input rst_n;

reg state;
reg count_enable;
reg next_state; // next state of fsm

// FSM state dicision
always @*
  case (state)
    `STATE_PAUSE:
      if (in)
      begin
        next_state = `STATE_COUNT;
        count_enable = `ENABLED;
      end
      else
      begin
        next_state = `STATE_PAUSE;
        count_enable = `DISABLED;
      end
    `STATE_COUNT:
      if (in)
      begin
        next_state = `STATE_PAUSE;
        count_enable = `DISABLED;
      end
      else
      begin
        next_state = `STATE_COUNT;
        count_enable = `ENABLED;
      end
    default:
      begin
        next_state = `STATE_PAUSE;
        count_enable = `DISABLED;
      end
  endcase
  
// FSM state transition
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    state <= `STATE_PAUSE;
  else
    state <= next_state;

endmodule
