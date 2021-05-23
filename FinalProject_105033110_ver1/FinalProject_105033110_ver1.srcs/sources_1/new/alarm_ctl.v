// 9-? 10-?
`timescale 1ns / 1ps
`include "global.v"
module alarm_ctl(
  output led_alarm,
  output reg [21:0] note_div,
  output reg mute,
  input dip_alarm,
  input clk, // 2Hz
  input rst_n
);

reg [21:0] note_div_next; // 100M/Hz/2
reg mute_next;

assign led_alarm = dip_alarm;

always @*
begin
  mute_next = 1'b1;
  note_div_next = 22'd50000;
  if (note_div == 22'd50000 && dip_alarm == 1'b1)
  begin
    mute_next = 1'b0;
    note_div_next = 22'd62500;
  end
  else if (note_div == 22'd62500 && dip_alarm == 1'b1)
  begin
    mute_next = 1'b0;
    note_div_next = 22'd50000;
  end
end

always @(posedge clk or negedge rst_n)
  if (~rst_n)
  begin
    mute <= 1'b0;
    note_div <= 22'd50000;
  end
  else
  begin
    mute <= mute_next;
    note_div <= note_div_next;
  end  

endmodule
