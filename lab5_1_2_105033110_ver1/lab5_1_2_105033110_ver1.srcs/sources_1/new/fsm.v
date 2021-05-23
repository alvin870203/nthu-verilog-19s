`timescale 1ns / 1ps
`include "global.v"
module fsm(
  state, // state of fsm
  count_enable, // if counter is enable
  in, // input control
  clk, // clock for fsm
  rst // high active reset
);

output state;
output count_enable;
input in;
input clk;
input rst;

reg state;
reg count_enable;
reg next_state; // next state of fsm

// FSM state dicision
always @*
  case (state)
    `STAT_PAUSE:
      if (in)
      begin
        next_state = `STAT_COUNT;
        count_enable = `ENABLED;
      end
      else
      begin
        next_state = `STAT_PAUSE;
        count_enable = `DISABLED;
      end
    `STAT_COUNT:
      if (in)
      begin
        next_state = `STAT_PAUSE;
        count_enable = `DISABLED;
      end
      else
      begin
        next_state = `STAT_COUNT;
        count_enable = `ENABLED;
      end
    default:
      begin
        next_state = `STAT_PAUSE;
        count_enable = `DISABLED;
      end
  endcase
  
// FSM state transition
always @(posedge clk or posedge rst)
  if (rst)
    state <= `STAT_PAUSE;
  else
    state <= next_state;

endmodule
