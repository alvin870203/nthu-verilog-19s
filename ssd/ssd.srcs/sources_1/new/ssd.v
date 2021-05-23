`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/19 00:37:36
// Design Name: 
// Module Name: ssd
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


module ssd(seg, bin, ssd_ctl);
output [3:0] ssd_ctl;
output [7:0] seg;  
input [3:0] bin;

display U0(.segs(seg),.bin(bin));

assign ssd_ctl = 4'b0000;

endmodule
