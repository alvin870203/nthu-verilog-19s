`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/05 11:30:40
// Design Name: 
// Module Name: lab1_1_105033110_ver1
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


module lab1_1_105033110_ver1(
    input x,
    input y,
    input cin,
    output cout,
    output s
    );
    
assign {cout, s} = x + y + cin;
    
endmodule
