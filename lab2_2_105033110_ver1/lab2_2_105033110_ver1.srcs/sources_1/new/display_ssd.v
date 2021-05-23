`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/19 21:10:04
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
`define SS_F 8'b0111_0001

module display_ssd(D_seg, i);
output [7:0] D_seg;
input [3:0] i;
reg [7:0] D_seg;

always @*
  case (i)
    4'd0: D_seg = `SS_0;
    4'd1: D_seg = `SS_1;
    4'd2: D_seg = `SS_2;
    4'd3: D_seg = `SS_3;
    4'd4: D_seg = `SS_4;
    4'd5: D_seg = `SS_5;
    4'd6: D_seg = `SS_6;
    4'd7: D_seg = `SS_7;
    4'd8: D_seg = `SS_8;
    4'd9: D_seg = `SS_9;
    default: D_seg = `SS_F;
  endcase
  
endmodule