`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/26 21:26:05
// Design Name: 
// Module Name: cnt1Hz
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


module cnt1Hz(q, clk);
output [3:0] q;
input clk;
wire [25:0] cnt;
wire clk_out;

cnt50M U_C50M(.cnt(cnt), .clk(clk));
freqdiv1Hz U_FD1Hz(.clk_out(clk_out), .clk(clk), .cnt(cnt));
bincnt U_BC(.q(q), .clk_out(clk_out));

endmodule