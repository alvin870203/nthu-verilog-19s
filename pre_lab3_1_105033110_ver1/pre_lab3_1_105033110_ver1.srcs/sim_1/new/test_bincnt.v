`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/20 17:25:23
// Design Name: 
// Module Name: test_bincnt
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


module test_bincnt;
wire [3:0] q;
reg clk;
reg rst_n;

bincnt U0(.q(q), .clk(clk), .rst_n(rst_n));

always #5 clk=~clk;

initial
begin
  clk=0; rst_n=0;
  #20 rst_n=1;
  #150 rst_n=0;
end

endmodule
