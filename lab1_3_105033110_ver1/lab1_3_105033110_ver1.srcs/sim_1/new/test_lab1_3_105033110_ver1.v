`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/06 00:56:42
// Design Name: 
// Module Name: test_lab1_3_105033110_ver1
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


module test_lab1_3_105033110_ver1();

wire [2:0] MAX;
reg [2:0] A, B;

lab1_3_105033110_ver1 U0(.a(A), .b(B), .max(MAX));

initial
begin
  A=0;
  repeat (8)
  begin
    B=0;
    repeat (7)
    begin
      #10 B=B+1;
    end
    #10 A=A+1; B=0;
  end
end

endmodule
