`include "global.v"
module keyboard_ctl(
  output reg [3:0] key_num, // 0/1/2/3/4/5/6/7/8/9
  input [511:0] key_down,
  input [8:0] last_change,
  input key_valid,
  input clk, // 100MHz
  input rst_n
);

reg [3:0] key_num_next;

always @*
  case (last_change)
    9'b0_0111_0000:
      key_num_next = 4'd0;
    9'b0_0110_1001:
      key_num_next = 4'd1;
    9'b0_0111_0010:
      key_num_next = 4'd2;
    9'b0_0111_1010:
      key_num_next = 4'd3;
    9'b0_0110_1011:
      key_num_next = 4'd4;
    9'b0_0111_0011:
      key_num_next = 4'd5;
    9'b0_0111_0100:
      key_num_next = 4'd6;
    9'b0_0110_1100:
      key_num_next = 4'd7;
    9'b0_0111_0101:
      key_num_next = 4'd8;
    9'b0_0111_1101:
      key_num_next = 4'd9;
    default:
      key_num_next = key_num;
  endcase

always @(posedge clk or negedge rst_n)
  if (~rst_n)
    key_num <= `F_NULL;
  else
    key_num <= key_num_next;


endmodule
