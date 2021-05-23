`timescale 1ns / 1ps
`include "global.v"
module scan_ctl(
  ssd_ctl, // ssd display control signal 
  ssd_in, // output to ssd display
  in0, // 1st input
  in1, // 2nd input
  in2, // 3rd input
  in3,  // 4th input
  ssd_ctl_en // divided clock for scan control
);

output [`BCD_BIT_WIDTH-1:0] ssd_in; // Binary data 
output [`SSD_NUM-1:0] ssd_ctl; // scan control for 7-segment display
input [`BCD_BIT_WIDTH-1:0] in0,in1,in2,in3; // binary input control for the four digits 
input [`SSD_SCAN_CTL_BIT_WIDTH-1:0] ssd_ctl_en; // divided clock for scan control

reg [`SSD_NUM-1:0] ssd_ctl; // scan control for 7-segment display (in the always block)
reg [`BCD_BIT_WIDTH-1:0] ssd_in; // 14 segment display control (in the always block)

always @(ssd_ctl_en)
  case (ssd_ctl_en)
    2'b00: 
    begin
      ssd_ctl=`SSD_SCAN_CTL_DISP1;
      ssd_in=in0;
    end
    2'b01: 
    begin
      ssd_ctl=`SSD_SCAN_CTL_DISP2;
      ssd_in=in1;
    end
    2'b10: 
    begin
      ssd_ctl=`SSD_SCAN_CTL_DISP3;
      ssd_in=in2;
    end
    2'b11: 
    begin
      ssd_ctl=`SSD_SCAN_CTL_DISP4;
      ssd_in=in3;
    end
    default: 
    begin
      ssd_ctl=`SSD_SCAN_CTL_DISPALL;
      ssd_in=in0;
    end
  endcase

endmodule
