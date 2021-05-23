`timescale 1ns / 1ps
`include "global.v"
module bcd_downcounter(
  segs,  // 7-segment display
  clk,  // clock from oscillator
  ssd_ctl, // scan control for 7-segment display
  rst_n  // active low reset
);

output [`SSD_BIT_WIDTH-1:0] segs; // 7-segment display out
output [`SSD_NUM-1:0] ssd_ctl;
input  clk;  // clock from oscillator
input  rst_n;  // active low reset

wire clk_d; //divided clock
wire [`CNT_BIT_WIDTH-1:0] cnt_out; // BCD counter output
wire [`SSD_NUM-1:0] ssd_ctl;

// Frequency Divider
freqdiv27 U_FD0(
  .clk_out(clk_d), //divided clock output
  .clk(clk), // clock from the 40MHz oscillator
  .rst_n(rst_n) // low active reset
);

// Binary Counter
bcddcnt U_BC(
  .out(cnt_out), //counter output
  .clk(clk_d), // clock
  .rst_n(rst_n) //active low reset
);

// Scan control
assign ssd_ctl = `SSD_NUM'b1110;

// binary to 7-segment display decoder
display U_display(
  .segs(segs), // 7-segment display output
  .bcd(cnt_out)  // BCD number input
);

endmodule
