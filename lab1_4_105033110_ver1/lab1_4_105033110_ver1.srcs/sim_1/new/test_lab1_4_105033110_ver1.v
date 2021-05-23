`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/09 13:22:43
// Design Name: 
// Module Name: test_lab1_4_105033110_ver1
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


module test_lab1_4_105033110_ver1();
parameter t=5;
wire [3:0] S;
wire CO;
reg [3:0] A, B;
reg CI;

lab1_4_105033110_ver1 U0(.a(A), .b(B), .ci(CI), .s(S), .co(CO));

initial
begin
A=0;B=0;CI=0;
#t B=1; #t B=2; #t B=3; #t B=4; #t B=5; #t B=6; #t B=7; #t B=8; #t B=9;

#t A=1;
B=1; #t B=2; #t B=3; #t B=4; #t B=5; #t B=6; #t B=7; #t B=8; #t B=9;

#t A=2;
B=1; #t B=2; #t B=3; #t B=4; #t B=5; #t B=6; #t B=7; #t B=8; #t B=9;

#t A=3;
B=1; #t B=2; #t B=3; #t B=4; #t B=5; #t B=6; #t B=7; #t B=8; #t B=9;

#t A=4;
B=1; #t B=2; #t B=3; #t B=4; #t B=5; #t B=6; #t B=7; #t B=8; #t B=9;

#t A=5;
B=1; #t B=2; #t B=3; #t B=4; #t B=5; #t B=6; #t B=7; #t B=8; #t B=9;

#t A=6;
B=1; #t B=2; #t B=3; #t B=4; #t B=5; #t B=6; #t B=7; #t B=8; #t B=9;

#t A=7;
B=1; #t B=2; #t B=3; #t B=4; #t B=5; #t B=6; #t B=7; #t B=8; #t B=9;

#t A=8;
B=1; #t B=2; #t B=3; #t B=4; #t B=5; #t B=6; #t B=7; #t B=8; #t B=9;

#t A=9;
B=1; #t B=2; #t B=3; #t B=4; #t B=5; #t B=6; #t B=7; #t B=8; #t B=9;

//CI  = 1;
A=0;B=0;CI=1;
#t B=1; #t B=2; #t B=3; #t B=4; #t B=5; #t B=6; #t B=7; #t B=8; #t B=9;

#t A=1;
B=1; #t B=2; #t B=3; #t B=4; #t B=5; #t B=6; #t B=7; #t B=8; #t B=9;

#t A=2;
B=1; #t B=2; #t B=3; #t B=4; #t B=5; #t B=6; #t B=7; #t B=8; #t B=9;

#t A=3;
B=1; #t B=2; #t B=3; #t B=4; #t B=5; #t B=6; #t B=7; #t B=8; #t B=9;

#t A=4;
B=1; #t B=2; #t B=3; #t B=4; #t B=5; #t B=6; #t B=7; #t B=8; #t B=9;

#t A=5;
B=1; #t B=2; #t B=3; #t B=4; #t B=5; #t B=6; #t B=7; #t B=8; #t B=9;

#t A=6;
B=1; #t B=2; #t B=3; #t B=4; #t B=5; #t B=6; #t B=7; #t B=8; #t B=9;

#t A=7;
B=1; #t B=2; #t B=3; #t B=4; #t B=5; #t B=6; #t B=7; #t B=8; #t B=9;

#t A=8;
B=1; #t B=2; #t B=3; #t B=4; #t B=5; #t B=6; #t B=7; #t B=8; #t B=9;

#t A=9;
B=1; #t B=2; #t B=3; #t B=4; #t B=5; #t B=6; #t B=7; #t B=8; #t B=9;

end

endmodule
