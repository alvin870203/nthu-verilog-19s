`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/20 15:39:57
// Design Name: 
// Module Name: bincnt
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bincnt(q, clk, rst_n);
output [3:0] q;
input clk;
input rst_n;
reg [3:0] q;
reg [3:0] q_tmp;

always @*
  q_tmp = q + 1'b1;
  
always @(posedge clk or negedge rst_n)
  if (~rst_n) q <= 4'd0;
  else q <= q_tmp;

endmodule
