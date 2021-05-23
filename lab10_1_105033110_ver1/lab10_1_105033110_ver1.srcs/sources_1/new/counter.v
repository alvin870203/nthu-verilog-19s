`include "global.v"
module counter(
  output reg [`BCD_BIT_WIDTH-1:0] freq,
  input clk, // 1Hz
  input rst_n
);

reg [`BCD_BIT_WIDTH-1:0] freq_next;

always @*
  if (freq == `FOURTEEN)
    freq_next = `ONE;
  else
    freq_next = freq + 1'b1;

always @(posedge clk or negedge rst_n)
  if (~rst_n)
    freq <= `ZERO;
  else
    freq <= freq_next;

endmodule
