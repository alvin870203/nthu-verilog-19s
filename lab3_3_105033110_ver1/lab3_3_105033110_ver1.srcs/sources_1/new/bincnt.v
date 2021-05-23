`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/26 21:27:08
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


module bincnt(q, clk_out);
output reg [3:0] q=4'd0;
input clk_out;
reg [3:0] q_tmp;

always @*
  q_tmp = q + 1'b1;
  
always @(posedge clk_out)
  q <= q_tmp;

endmodule
