`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/05 16:00:47
// Design Name: 
// Module Name: test_lab1_2_105033110_ver1
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


module test_lab1_2_105033110_ver1();
wire [7:0] D;
reg EN;
reg [2:0] IN;

lab1_2_105033110_ver1 U0(.in(IN), .en(EN), .d(D));

initial
begin

/* Method1:by repeat
  EN=1;
  IN=0;
  repeat (8)
  begin
    #10
    //$display("IN = %1d EN = %1b D = %8b", IN, EN, D);
    IN = IN + 1;
  end
*/  

/* Mehod2: truth table */
//EN=0
IN[2]=0;IN[1]=0;IN[0]=0;EN=0;
#10 IN[2]=0;IN[1]=0;IN[0]=1;EN=0;
#10 IN[2]=0;IN[1]=1;IN[0]=0;EN=0;
#10 IN[2]=0;IN[1]=1;IN[0]=1;EN=0;
#10 IN[2]=1;IN[1]=0;IN[0]=0;EN=0;
#10 IN[2]=1;IN[1]=0;IN[0]=1;EN=0;
#10 IN[2]=1;IN[1]=1;IN[0]=0;EN=0;
#10 IN[2]=1;IN[1]=1;IN[0]=1;EN=0;
//EN=1
#10 IN[2]=0;IN[1]=0;IN[0]=0;EN=1;
#10 IN[2]=0;IN[1]=0;IN[0]=1;EN=1;
#10 IN[2]=0;IN[1]=1;IN[0]=0;EN=1;
#10 IN[2]=0;IN[1]=1;IN[0]=1;EN=1;
#10 IN[2]=1;IN[1]=0;IN[0]=0;EN=1;
#10 IN[2]=1;IN[1]=0;IN[0]=1;EN=1;
#10 IN[2]=1;IN[1]=1;IN[0]=0;EN=1;
#10 IN[2]=1;IN[1]=1;IN[0]=1;EN=1;


end

endmodule
