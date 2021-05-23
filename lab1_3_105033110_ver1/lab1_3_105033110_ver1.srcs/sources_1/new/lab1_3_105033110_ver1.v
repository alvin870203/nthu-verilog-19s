`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/06 00:50:14
// Design Name: 
// Module Name: lab1_3_105033110_ver1
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


module lab1_3_105033110_ver1(
    input [2:0] a,
    input [2:0] b,
    output reg [2:0] max
    );

assign gt=(a>b) ? 1 : 0;
always @*
  if (gt)
    max = a;
  else
    max = b;

endmodule
