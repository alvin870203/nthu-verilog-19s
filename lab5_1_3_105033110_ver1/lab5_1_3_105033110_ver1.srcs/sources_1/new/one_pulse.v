`timescale 1ns / 1ps
`include "global.v"
module one_pulse(
  out_pulse, // output one pulse
  in_trig, // input trigger
  clk,  // clock input
  rst //active high reset 
);

// Declare I/Os
input clk;  // clock input
input rst; //active high reset
input in_trig; // input trigger
output out_pulse; // output one pulse 
reg out_pulse; // output one pulse 

// Declare internal nodes
reg in_trig_delay;

// Buffer input 
always @(posedge clk or posedge rst)
  if (rst)
    in_trig_delay <= 1'b0; 
  else
    in_trig_delay <= in_trig;

// Pulse generation
assign out_pulse_next = in_trig & (~in_trig_delay);

always @(posedge clk or posedge rst)
  if (rst)
    out_pulse <=1'b0;
  else
    out_pulse <= out_pulse_next;

endmodule
