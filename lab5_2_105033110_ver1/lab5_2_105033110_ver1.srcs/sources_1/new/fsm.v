`timescale 1ns / 1ps
`include "global.v"
module fsm(
  count_enable, // if counter is enable
  rst, // if counter is reset, high active
  pb, // input from push button, pb(t)
  clk // clock for fsm
);

output count_enable;
output rst;
input pb;
input clk;

reg count_enable;
reg rst;
reg [`STAT_BIT_WIDTH-1:0] state; // state of FSM
reg [`STAT_BIT_WIDTH-1:0] next_state; // next state of FSM
reg pb_prev; // pb(t-1), pb at previous cycle
reg [`FSM_COUNT_BIT_WIDTH-1:0] cnt; // count for how long push button is pressed
reg [`FSM_COUNT_BIT_WIDTH-1:0] cnt_next;

// Combinational block
always @*
  if (pb) // start counting from 00 when button is pushed
    cnt_next = cnt + 1'b1;
  else
    cnt_next = `FSM_COUNT_BIT_WIDTH'b0;
  
// FSM state dicision
always @*
  case (state)
    `STAT_RESET:
      if (pb) // reset -> reset
      begin
        next_state = `STAT_RESET;
        count_enable = `DISABLED;
        rst = `RESET;
      end
      else // reset -> pause
      begin
        next_state = `STAT_PAUSE;
        count_enable = `DISABLED;
        rst = `UN_RESET;
      end
    `STAT_PAUSE:
      if (pb & (cnt[1] & cnt[0])) // pause -> reset
      begin
        next_state = `STAT_RESET; // can't rst=`RESET here, or clock_generator will be reset and stop when button is pushed down for long time, causing `STAT_RESET can't be transfered to state. So here we give one clock cycle to led reset state be trasfered
      end
      else if ((~pb) & pb_prev) // pause -> start
      begin
        next_state = `STAT_COUNT;
        count_enable = `ENABLED; // will be done right away, don't need to wait for one clock cycle like in reset case
        rst = `UN_RESET;
      end
      else // pb==0: pause -> pause
      begin
        next_state = `STAT_PAUSE;
        count_enable = `DISABLED;
        rst = `UN_RESET;
      end 
    `STAT_COUNT: // start
      if (pb & (cnt[1] & cnt[0])) // start -> reset
      begin
        next_state = `STAT_RESET; // can't rst=`RESET here, or clock_generator will be reset and stop when button is pushed down for long time, causing `STAT_RESET can't be transfered to state. So here we give one clock cycle to led reset state be trasfered
      end
      else if ((~pb) & pb_prev) // start -> pause
      begin
        next_state = `STAT_PAUSE;
        count_enable = `DISABLED;
        rst = `UN_RESET;
      end
      else // pb==0: start -> start
      begin
        next_state = `STAT_COUNT;
        count_enable = `ENABLED;
        rst = `UN_RESET;
      end
    default:
    begin
      next_state = `STAT_PAUSE;
      count_enable = `DISABLED;
      rst = `UN_RESET;
    end
  endcase

// Sequential block & // FSM state transition
always @(posedge clk)
begin
  pb_prev <= pb;
  cnt <= cnt_next;
  state <= next_state;
end

endmodule
