`timescale 1ns / 1ps
`include "global.v"
module shifter(
  q0, q1, q2, q3,  // shifter output
  clk,  // global clock
  rst_n  // active low reset
);

output [`SSD_BIT_WIDTH-1:0] q0;  // output of first ssd
output [`SSD_BIT_WIDTH-1:0] q1;  // output of second ssd
output [`SSD_BIT_WIDTH-1:0] q2;  // output of third ssd
output [`SSD_BIT_WIDTH-1:0] q3;  // output of fourth ssd
input clk;  // global clock
input rst_n;  // active low reset

reg [`SSD_BIT_WIDTH-1:0] q0;  // output
reg [`SSD_BIT_WIDTH-1:0] q1;  // output
reg [`SSD_BIT_WIDTH-1:0] q2;  // output
reg [`SSD_BIT_WIDTH-1:0] q3;  // output
reg [`SSD_BIT_WIDTH-1:0] q4;  // unshowed
reg [`SSD_BIT_WIDTH-1:0] q5;  // unshowed

// Sequential logics: Flip flops
always @(posedge clk or negedge rst_n)
  if (~rst_n) 
  begin
    q0 <= `SSD_U;
    q1 <= `SSD_H;
    q2 <= `SSD_T;
    q3 <= `SSD_N;
    q4 <= `SSD_E;
    q5 <= `SSD_E;    
  end  
  else
 begin
    q0 <= q5;
    q1 <= q0;
    q2 <= q1;
    q3 <= q2;
    q4 <= q3;
    q5 <= q4;
  end
endmodule
