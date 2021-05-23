`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/26 21:39:09
// Design Name: 
// Module Name: cnt50M
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


module cnt50M(cnt, clk);
output reg [25:0] cnt = 26'd0;
input clk;
wire clr_n;
wire [25:0] cnt_tmp;
reg [25:0] cnt_d;

//cmp
assign clr_n = (cnt < 26'd49_999_999) ? 1:0;

//add
assign cnt_tmp = cnt + 1'b1;

//MUX
always @*
  if (~clr_n)
    cnt_d = 26'd0;
  else
    cnt_d = cnt_tmp;
    
//DFF
always @(posedge clk)
  cnt <= cnt_d;

endmodule
