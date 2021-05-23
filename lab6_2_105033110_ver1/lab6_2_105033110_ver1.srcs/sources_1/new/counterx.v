`include "global.v"
module counterx(
  output reg [`BCD_BIT_WIDTH-1:0] q, // counter value
  output reg time_carry, // counter carry
  input count_enable, // counting enabled control signal
  input load_value_enable, // load setting value control
  input [`BCD_BIT_WIDTH-1:0] load_value, // value to be loaded
  input [`BCD_BIT_WIDTH-1:0] count_limit, // limit of the up counter
  input clk, // clock
  input rst_n, // low active reset
  input min_23
);

reg [`BCD_BIT_WIDTH-1:0] q_next;

always @(posedge clk or negedge rst_n)
  if (~rst_n)
    q <= `BCD_BIT_WIDTH'b0;
  else
    q <= q_next;

always @*
begin
  q_next = q;
  time_carry = `DISABLED;
  if (load_value_enable)
    q_next = load_value;
  else if (count_enable && ((q == count_limit) || (min_23)))
  begin
    q_next = `BCD_BIT_WIDTH'b0;
    time_carry = `ENABLED;
  end
  else if (count_enable)
    q_next = q + `ONE;
end
endmodule
