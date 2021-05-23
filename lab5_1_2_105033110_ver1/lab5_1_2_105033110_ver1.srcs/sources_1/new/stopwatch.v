`timescale 1ns / 1ps
`include "global.v"
module stopwatch(
  state_led, // one led to represent current state
  in, // push button input for start/pause
  clk, // 100MHz crystal clock
  rst // active high reset
);

output state_led;
input in;
input clk;
input rst;

wire clk_100; // 100Hz divided clock
wire clk_d; // 1Hz divided clock
wire in_db; // debounce circuit output
wire in_1pulse; // one pulse output

// useless internal wire
wire [`SSD_SCAN_CTL_BIT_WIDTH-1:0] clk_ctl;
wire count_enable;

// Clock generator module
clock_generator U_CG(
  .clk_100(clk_100), // generated 100 Hz clock
  .clk_1(clk_d), // generated 1 Hz clock
  .clk_ctl(clk_ctl), // divided clock for 7-segment display scan
  .clk(clk), // clock from 100MHz crystal oscillator
  .rst(rst) // high active reset  
);

// debounce circuit
debounce_circuit U_DC(
  .pb_debounced(in_db), // debounced push button output
  .pb_in(in), //push button input
  .clk(clk_100), // clock control
  .rst(rst) // reset
);

// 1 pulse generation circuit
one_pulse U_OP(
  .out_pulse(in_1pulse), // output one pulse
  .in_trig(in_db), // input trigger
  .clk(clk_d),  // clock input
  .rst(rst) //active high reset 
);

// FSM
fsm U_FSM(
  .state(state_led), // state of fsm
  .count_enable(count_enable), // if counter is enable
  .in(in_1pulse), // input control
  .clk(clk_d), // clock for fsm
  .rst(rst) // high active reset
);

endmodule
