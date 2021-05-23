`timescale 1ns / 1ps
`include "global.v"
module fsm_mode(
  rst_init, // reset to initial value
  init2, // initial value of digit2
  init1, // initial value of digit1
  init0, // initial value of digit0
  in, // input from push button
  clk // clock for fsm
);

output rst_init; // reset to initial value
output [`BCD_BIT_WIDTH-1:0] init2; // initial value of digit2
output [`BCD_BIT_WIDTH-1:0] init1; // initial value of digit1
output [`BCD_BIT_WIDTH-1:0] init0; // initial value of digit0
input in;
input clk;

reg rst_init; // reset to initial value
reg [`BCD_BIT_WIDTH-1:0] init2; // initial value of digit2
reg [`BCD_BIT_WIDTH-1:0] init1; // initial value of digit1
reg [`BCD_BIT_WIDTH-1:0] init0; // initial value of digit0
reg [`STAT_BIT_WIDTH-1:0] state; // state of FSM
reg [`STAT_BIT_WIDTH-1:0] next_state; // next state of FSM

// ***************************
// FSM
// ***************************
// FSM state decision
always @*
  case (state)
    `STAT_30SEC:
      if (in) // 30sec -> 1min
      begin
        next_state = `STAT_1MIN;
        rst_init = `RESET; // set to initial value for one clock cycle only
        init2 = `BCD_ONE;
        init1 = `BCD_ZERO;
        init0 = `BCD_ZERO;
      end
      else // 30sec -> 30sec
      begin
        next_state = `STAT_30SEC;
        rst_init = `UN_RESET; // set to initial value for one clock cycle only
        init2 = `BCD_ZERO;
        init1 = `BCD_THREE;
        init0 = `BCD_ZERO;
      end
    `STAT_1MIN:
      if (in) // 1min -> 30sec
      begin
        next_state = `STAT_30SEC;
        rst_init = `RESET;
        init2 = `BCD_ZERO;
        init1 = `BCD_THREE;
        init0 = `BCD_ZERO;
      end
      else // 1min -> 1min
      begin
        next_state = `STAT_1MIN;
        rst_init = `UN_RESET;
        init2 = `BCD_ONE;
        init1 = `BCD_ZERO;
        init0 = `BCD_ZERO;
      end
    default:
    begin
      next_state = `STAT_30SEC;
      rst_init = `RESET;
      init2 = `BCD_ZERO;
      init1 = `BCD_THREE;
      init0 = `BCD_ZERO;
    end
  endcase

// FSM state transition
always @(posedge clk)
  state <= next_state;

endmodule
