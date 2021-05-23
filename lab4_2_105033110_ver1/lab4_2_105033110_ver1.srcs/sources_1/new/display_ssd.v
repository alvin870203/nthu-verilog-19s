`timescale 1ns / 1ps

`include "global.v"

module display_ssd(
  D, // 7-segment display
  i // binary input
);
output [`SSD_BIT-1:0] D; 
input [`BINCNT_BIT-1:0] i;

reg [`SSD_BIT-1:0] D;

always @*
  case (i)
    `BINCNT_BIT'h0: D = `SS_0;
    `BINCNT_BIT'h1: D = `SS_1;
    `BINCNT_BIT'h2: D = `SS_2;
    `BINCNT_BIT'h3: D = `SS_3;
    `BINCNT_BIT'h4: D = `SS_4;
    `BINCNT_BIT'h5: D = `SS_5;
    `BINCNT_BIT'h6: D = `SS_6;
    `BINCNT_BIT'h7: D = `SS_7;
    `BINCNT_BIT'h8: D = `SS_8;
    `BINCNT_BIT'h9: D = `SS_9;
    `BINCNT_BIT'hA: D = `SS_A;
    `BINCNT_BIT'hB: D = `SS_B;
    `BINCNT_BIT'hC: D = `SS_C;
    `BINCNT_BIT'hD: D = `SS_D;
    `BINCNT_BIT'hE: D = `SS_E;
    `BINCNT_BIT'hF: D = `SS_F;
    default: D = `SS_NULL;
  endcase
  
endmodule
