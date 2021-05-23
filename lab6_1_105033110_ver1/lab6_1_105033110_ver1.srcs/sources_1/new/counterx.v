`include "global.v"
module counterx(
  output reg [`BCD_BIT_WIDTH-1:0] q, // counter value
  output reg time_carry, // counter carry
  input count_enable, // counting enabled control signal
  input restart_enable, // restart after stop, load initial value control
  input [`BCD_BIT_WIDTH-1:0] count_limit, // limit of the up counter
  input clk, // clock
  input rst // high active reset
);

reg [`BCD_BIT_WIDTH-1:0] q_next;

always @(posedge clk or posedge rst)
  if (rst)
    q <= `BCD_BIT_WIDTH'b0; // initial value
  else
    q <= q_next;

always @*
begin
  q_next = q;
  time_carry = `DISABLED;
  if (restart_enable)
    q_next = `BCD_BIT_WIDTH'b0; // initial value
  else if (count_enable && q == count_limit)
  begin
    q_next = `BCD_BIT_WIDTH'b0;
    time_carry = `ENABLED;
  end
  else if (count_enable)
    q_next = q + `ONE;
end
endmodule
