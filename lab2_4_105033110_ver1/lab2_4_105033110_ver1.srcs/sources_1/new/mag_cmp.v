`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/20 02:30:40
// Design Name: 
// Module Name: mag_cmp
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


module mag_cmp(X, dA, dB, A, B);
output X;
output [3:0] dA;
output [3:0] dB;
input [3:0] A;
input [3:0] B;

assign X = (A>B) ? 1 : 0;
assign dA = A;
assign dB = B;

endmodule
