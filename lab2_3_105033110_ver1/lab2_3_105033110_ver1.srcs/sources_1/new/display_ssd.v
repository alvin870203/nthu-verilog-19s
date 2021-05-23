`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/20 00:53:26
// Design Name: 
// Module Name: display_ssd
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

`define SS_0 8'b0000_0011
`define SS_1 8'b1001_1111
`define SS_2 8'b0010_0101
`define SS_3 8'b0000_1101
`define SS_4 8'b1001_1001
`define SS_5 8'b0100_1001
`define SS_6 8'b0100_0001
`define SS_7 8'b0001_1111
`define SS_8 8'b0000_0001
`define SS_9 8'b0000_1001
`define SS_A 8'b0001_0001
`define SS_B 8'b1100_0001
`define SS_C 8'b0110_0011
`define SS_D 8'b1000_0101
`define SS_E 8'b0110_0001
`define SS_F 8'b0111_0001
`define SS_NULL 8'b1111_1111

module display_ssd(D, i);
output [7:0] D;
input [3:0] i;
reg [7:0] D;

always @*
  case (i)
    4'h0: D = `SS_0;
    4'h1: D = `SS_1;
    4'h2: D = `SS_2;
    4'h3: D = `SS_3;
    4'h4: D = `SS_4;
    4'h5: D = `SS_5;
    4'h6: D = `SS_6;
    4'h7: D = `SS_7;
    4'h8: D = `SS_8;
    4'h9: D = `SS_9;
    4'hA: D = `SS_A;
    4'hB: D = `SS_B;
    4'hC: D = `SS_C;
    4'hD: D = `SS_D;
    4'hE: D = `SS_E;
    4'hF: D = `SS_F;
    default: D = `SS_NULL;
  endcase
  
endmodule
