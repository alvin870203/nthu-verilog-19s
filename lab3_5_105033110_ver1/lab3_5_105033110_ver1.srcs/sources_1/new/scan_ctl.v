`timescale 1ns / 1ps
`include "global.v"
module scan_ctl(
  ssd_ctl, // ssd display control signal 
  segs, // ssd out
  in0, // 1st input
  in1, // 2nd input
  in2, // 3rd input
  in3,  // 4th input
  ssd_ctl_en // divided clock for scan control
);

output [`SSD_BIT_WIDTH-1:0] segs; // Binary data 
output [`SSD_NUM-1:0] ssd_ctl; // scan control for 7-segment display
input [`SSD_BIT_WIDTH-1:0] in0,in1,in2,in3; // binary input control for the four digits 
input [`SSD_SCAN_CTL_BIT_WIDTH-1:0] ssd_ctl_en; // divided clock for scan control

reg [`SSD_NUM-1:0] ssd_ctl; // scan control for 7-segment display (in the always block)
reg [`SSD_BIT_WIDTH-1:0] segs; // 7 segment display control (in the always block)

always @*
  case (ssd_ctl_en)
    2'b00: 
    begin
      ssd_ctl=4'b1110;
      segs=in0;
    end
    2'b01: 
    begin
      ssd_ctl=4'b1101;
      segs=in1;
    end
    2'b10: 
    begin
      ssd_ctl=4'b1011;
      segs=in2;
    end
    2'b11: 
    begin
      ssd_ctl=4'b0111;
      segs=in3;
    end
    default: 
    begin
      ssd_ctl=4'b0000;
      segs=`SSD_DEF;
    end
  endcase

endmodule
