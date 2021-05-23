`timescale 1ns / 1ps
`include "global.v"
module scroll_ssd(
  segs,  // 7-segment display
  ssd_ctl, // scan control for 7-segment display
  clk,  // clock from oscillator
  rst_n  // active low reset
);

output [`SSD_BIT_WIDTH-1:0] segs; // 7-segment display out
output [`SSD_NUM-1:0] ssd_ctl;
input  clk;  // clock from oscillator
input  rst_n;  // active low reset

wire clk_d; //divided clock
wire [`SSD_BIT_WIDTH-1:0] q0;  // in0
wire [`SSD_BIT_WIDTH-1:0] q1;  // in1
wire [`SSD_BIT_WIDTH-1:0] q2;  // in2
wire [`SSD_BIT_WIDTH-1:0] q3;  // in3
wire [`SSD_SCAN_CTL_BIT_WIDTH-1:0] ssd_ctl_en;

// Frequency Divider
freqdiv27 U_FD(
  .clk_out(clk_d), //divided clock output
  .clk_ctl(ssd_ctl_en), // divided scan clock for 7-segment display scan
  .clk(clk), // clock from the 100MHz oscillator
  .rst_n(rst_n) // low active reset
);

// Shifter
shifter U_S(
  .q0(q0),  // shifter output
  .q1(q1),  // shifter output
  .q2(q2),  // shifter output
  .q3(q3),  // shifter output
  .clk(clk_d),  // global clock
  .rst_n(rst_n)  // active low reset
);

// Scan control
scan_ctl U_SC(
  .ssd_ctl(ssd_ctl), // ssd display control signal 
  .segs(segs), // 7-segment display output
  .in0(q0), // 1st input
  .in1(q1), // 2nd input
  .in2(q2), // 3rd input
  .in3(q3),  // 4th input
  .ssd_ctl_en(ssd_ctl_en) // divided clock for scan control
); 

endmodule
