`include "global.v"
module counterx(
  output reg [`BCD_BIT_WIDTH-1:0] q, // counter value
  output reg time_carry, // counter carry
  input count_enable, // counting enabled control signal
  input [`BCD_BIT_WIDTH-1:0] count_limit, // limit of the up counter
  input clear_and_carry,
  input [`BCD_BIT_WIDTH-1:0] clear_value,
  input [`BCD_BIT_WIDTH-1:0] initial_value,
  input clk, // clock
  input rst_n // low active reset
);

reg [`BCD_BIT_WIDTH-1:0] q_next;

always @(posedge clk or negedge rst_n)
  if (~rst_n)
    q <= initial_value;
  else
    q <= q_next;

always @*
begin
  q_next = q;
  time_carry = `DISABLED;
  if (clear_and_carry)
  begin
    q_next = clear_value;
    time_carry = `ENABLED;
  end
  else if (count_enable && (q == count_limit))
  begin
    q_next = `BCD_BIT_WIDTH'b0;
    time_carry = `ENABLED;
  end
  else if (count_enable)
    q_next = q + `ONE;
end
endmodule
