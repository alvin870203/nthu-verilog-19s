`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/19 16:00:13
// Design Name: 
// Module Name: test_FA
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


module test_lab1_1_105033110_ver1();
wire COUT, S;
reg X, Y, CIN;

lab1_1_105033110_ver1 U0(.x(X), .y(Y), .cin(CIN), .cout(COUT), .s(S));

initial
begin

X=0; Y=0; CIN=0;
#10 X=0; Y=0; CIN=1;
#10 X=0; Y=1; CIN=0;
#10 X=0; Y=1; CIN=1;
#10 X=1; Y=0; CIN=0;
#10 X=1; Y=0; CIN=1;
#10 X=1; Y=1; CIN=0;
#10 X=1; Y=1; CIN=1;
end

endmodule
