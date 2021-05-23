`timescale 1ns / 1ps
`include "global.v"
module motor_drive(
  output reg [1:0] motor, // 0 for right, 1 for left
  output reg [1:0] led_direction, // 0 for right, 1 for left
  input [1:0] direction, // 00 stop, 01 forward, 10 right, 11 left
  input  clk, // 100MHz
  input rst_n
);

reg [1:0] motor_next; // 0 for right, 1 for left
reg [1:0] led_direction_next; // 0 for right, 1 for left

always @*
  case (direction)
    2'b00:
    begin
      motor_next = 2'b00;
      led_direction_next = 2'b11;
    end
    2'b01:
    begin
      motor_next = 2'b11;
      led_direction_next = 2'b00;
    end
    2'b10:
    begin
      motor_next = 2'b10;
      led_direction_next = 2'b01;
    end
    2'b11:
    begin
      motor_next = 2'b01;
      led_direction_next = 2'b10;
    end
    default:
    begin
      motor_next = 2'b00;
      led_direction_next = 2'b11;
    end
  endcase

always @(posedge clk or negedge rst_n)
  if (~rst_n)
  begin
    motor <= 2'd0;
    led_direction <= 2'd0;
  end
  else
  begin
    motor <= motor_next;
    led_direction <= led_direction_next;
  end
  

endmodule
