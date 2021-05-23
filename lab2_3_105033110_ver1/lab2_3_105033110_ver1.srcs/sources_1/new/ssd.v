`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/20 00:52:07
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


module ssd(ssd_ctl, D, d, i);
output [3:0] ssd_ctl;
output [7:0] D;
output [3:0] d;
input [3:0] i;

assign ssd_ctl = 4'b1110;
display_ssd U_SSD(.D(D), .i(i));
display_led U_LED(.d(d), .i(i));

endmodule
