`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/21 02:15:43
// Design Name: 
// Module Name: test_shifter
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


module test_shifter;
wire [7:0] q;
reg clk;
reg rst_n;

shifter U0(.q(q), .clk(clk), .rst_n(rst_n));

always #5 clk=~clk;

initial
begin
  clk=0; rst_n=0;
  #20 rst_n=1;
  #90 rst_n=0;
end

endmodule
