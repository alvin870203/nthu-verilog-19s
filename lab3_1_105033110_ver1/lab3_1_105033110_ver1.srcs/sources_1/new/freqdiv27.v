`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/25 22:27:17
// Design Name: 
// Module Name: freqdiv27
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


module freqdiv27(clk_out, clk);
output clk_out;
input clk;
reg clk_out;
reg [25:0] cnt_l;
reg [26:0] cnt_tmp;

initial
  {clk_out, cnt_l} = 27'b0;

always @*
  cnt_tmp = {clk_out, cnt_l} + 1'b1;
  
always @(posedge clk)
  {clk_out, cnt_l} <= cnt_tmp;

endmodule
