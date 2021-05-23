`include "global.v"
module keyboard_ctl(
  output reg [6:0] key_num, // ascii
  input [511:0] key_down,
  input [8:0] last_change,
  input key_valid,
  input clk, // 100MHz
  input rst_n
);

reg [6:0] key_num_next;

always @*
  case (last_change)
    9'h1C: // a
      key_num_next = 7'd97;
    9'h1B: // s
      key_num_next = 7'd115;
    9'h3A: // m
      key_num_next = 7'd109;
    9'h5A: // Enter
      key_num_next = 7'd10; // ASCII: new line
    default:
      key_num_next = key_num;
  endcase

always @(posedge clk or negedge rst_n)
  if (~rst_n)
    key_num <= 7'd10;
  else
    key_num <= key_num_next;


endmodule
