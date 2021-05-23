`timescale 1ns / 1ps
`include "global.v"
module downcounter_30s(
  segs,  // 7-segment display
  ssd_ctl, // scan control for 7-segment display
  clk,  // clock from oscillator
  rst_n  // active low reset
);

output [`SSD_BIT_WIDTH-1:0] segs; // 7-segment display out
output [`SSD_NUM-1:0] ssd_ctl;
input  clk;  // clock from oscillator
input  rst_n;  // active low reset

wire decrease_enable;
wire [`CNT_BIT_WIDTH-1:0] digit0; // value of Udc0
wire [`CNT_BIT_WIDTH-1:0] digit1; // value of Udc1
wire br0; // borrow of Udc0
wire br1; // borrow of Udc1
wire clk_d; // 1Hz clock
wire [`SSD_SCAN_CTL_BIT_WIDTH-1:0] ssd_ctl_en;
wire [`CNT_BIT_WIDTH-1:0] ssd_in;

// Frequency divider 17 for scan_ctl
freqdiv17 U_FD0(
  .clk_ctl(ssd_ctl_en), // divided scan clock for 7-segment display scan
  .clk(clk), // clock from the 100MHz oscillator
  .rst_n(rst_n) // low active reset
);

// freq1Hz
freq1Hz U_F1Hz(
  .clk_out(clk_d), // 1Hz clock
  .clk(clk), // clock from the 100MHz oscillator
  .rst_n(rst_n) // active low reset
);

// Down Counter LSB
downcounter Udc0(
  .value(digit0), // counter output
  .borrow(br0), // borrow indicator
  .clk(clk_d), // 1Hz clock
  .rst_n(rst_n), // active low reset
  .decrease(decrease_enable), // counter enable control
  .limit(4'd9) // limit for the counter
);

// Down Counter MSB
downcounter2 Udc1(
  .value(digit1), // counter output
  .borrow(br1), // borrow indicator
  .clk(clk_d), // 1Hz clock
  .rst_n(rst_n), // active low reset
  .decrease(br0), // counter enable control
  .limit(4'd3) // limit for the counter
);

// Stop at 00
stop U_STOP(
  .decrease_enable(decrease_enable),
  .value0(digit0),
  .value1(digit1)
);

// Scan control
scan_ctl U_SC(
  .ssd_ctl(ssd_ctl), // ssd display control signal 
  .ssd_in(ssd_in), // output to ssd display
  .in0(digit0), // 1st input
  .in1(digit1), // 2nd input
  .in2(4'b1111), // 3rd input
  .in3(4'b1111),  // 4th input
  .ssd_ctl_en(ssd_ctl_en) // divided clock for scan control
);

// binary to 7-segment display decoder
display U_display(
  .segs(segs), // 7-segment display output
  .bcd(ssd_in)  // BCD number input
);

endmodule
