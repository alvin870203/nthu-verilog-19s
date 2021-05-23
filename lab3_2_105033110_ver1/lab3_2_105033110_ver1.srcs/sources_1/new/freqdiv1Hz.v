`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/26 19:22:02
// Design Name: 
// Module Name: freqdiv1Hz
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


module freqdiv1Hz(clk_out, clk);
output reg clk_out = 1'b0;
input clk;
wire [25:0] cnt;
wire inv_n;
reg [25:0] clk_d;

//cnt50M
cnt50M U0(.cnt(cnt), .clk(clk));

//cmp
assign inv_n = (cnt < 26'd49_999_999) ? 1:0;

//MUX
always @*
  if (~inv_n)
    clk_d = ~clk_out;
  else
    clk_d = clk_out;

//DFF
always @(posedge clk)
  clk_out <= clk_d;

endmodule
