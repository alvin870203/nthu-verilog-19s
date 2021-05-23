`timescale 1ns / 1ps
`include "global.v"
module scan_ctl(
  output reg [`BCD_BIT_WIDTH-1:0]  ssd_ctl, // ssd display control signal 
  output reg [`SSD_NUM-1:0] ssd_in, // output to ssd display
  input [`BCD_BIT_WIDTH-1:0] in0, // 1st input
  input [`BCD_BIT_WIDTH-1:0] in1, // 2nd input
  input [`BCD_BIT_WIDTH-1:0] in2, // 3rd input
  input [`BCD_BIT_WIDTH-1:0] in3,  // 4th input
  input ssd_ctl_en, // divided clock for scan control
  input rst_n
);

reg [1:0] ssd_enabled_index;
wire [1:0] ssd_enabled_index_next;

// 2-bit binary up counter for scan control
assign ssd_enabled_index_next = ssd_enabled_index + 1'b1;

always @(posedge ssd_ctl_en or negedge rst_n)
  if (~rst_n)
    ssd_enabled_index = 2'b0;
  else
    ssd_enabled_index = ssd_enabled_index_next;

always @*
  case (ssd_enabled_index)
    2'b00: 
    begin
      ssd_ctl=4'b0111;
      ssd_in=in0;
    end
    2'b01: 
    begin
      ssd_ctl=4'b1011;
      ssd_in=in1;
    end
    2'b10: 
    begin
      ssd_ctl=4'b1101;
      ssd_in=in2;
    end
    2'b11: 
    begin
      ssd_ctl=4'b1110;
      ssd_in=in3;
    end
    default: 
    begin
      ssd_ctl=4'b0000;
      ssd_in=in0;
    end
  endcase

endmodule
