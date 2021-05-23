`timescale 1ns / 1ps
`include "global.v"
module test_fsm;

wire led_state; // one led to represent fsm current state
wire count_enable;
reg in;
reg clk;
reg rst_n;

fsm U0(
  .state(led_state), // state of fsm
  .count_enable(count_enable), // if counter is enable
  .in(in), // input control
  .clk(clk), // clock for fsm
  .rst_n(rst_n) // low active reset
);

always
  #5 clk = ~clk;

initial
begin
  in = 0;
  clk = 0;
  rst_n = 0;
end

initial
begin
  #10 rst_n = 1;
  #10 in = 1;  #10 in = 0; // fist push button pulse
  #20 in = 1;  #10 in = 0; // second push button pulse
end

endmodule
