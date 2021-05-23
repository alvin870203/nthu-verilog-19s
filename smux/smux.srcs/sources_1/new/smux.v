`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/13 15:32:11
// Design Name: 
// Module Name: smux
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


module smux(out, a, b, sel);
output out;
input a,b,sel;
    
assign out = (a&sel) | (b&(~sel));
    
endmodule
