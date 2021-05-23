`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/09 13:12:40
// Design Name: 
// Module Name: lab1_4_105033110_ver1
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


module lab1_4_105033110_ver1(
    input [3:0] a,
    input [3:0] b,
    input ci,
    output reg [3:0] s,
    output reg co
    );
    
assign gt=((a+b+ci)>9) ? 1 : 0;
always @*
  if(gt)
  begin
    s = a+b+ci+6;
    co = 1;
  end
  else
  begin
    s = a+b+ci;
    co = 0;
   end
    
endmodule
