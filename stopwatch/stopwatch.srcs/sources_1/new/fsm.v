//************************************************************************
// Filename      : FSM.v
// Author        : hp
// Function      : FSM module for digital watch
// Last Modified : Date: 2009-03-10
// Revision      : Revision: 1
// Copyright (c), Laboratory for Reliable Computing (LaRC), EE, NTHU
// All rights reserved
//************************************************************************
`include "global.v"
module fsm(
  count_enable,  // if counter is enabled 
  in, //input control
  clk, // global clock signal
  rst_n  // low active reset
);

// outputs
output count_enable;  // if counter is enabled 

// inputs
input clk; // global clock signal
input rst_n; // low active reset
input in; //input control

reg count_enable;  // if counter is enabled 
reg state; // state of FSM
reg next_state; // next state of FSM

// ***************************
// FSM
// ***************************
// FSM state decision
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
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    state <= `STAT_PAUSE;
  else
    state <= next_state;

endmodule
