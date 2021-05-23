`include "global.v"
module stopwatch(
  output [`BCD_BIT_WIDTH-1:0] q_sec0,
  output [`BCD_BIT_WIDTH-1:0] q_sec1,
  output [`BCD_BIT_WIDTH-1:0] q_min0,
  output [`BCD_BIT_WIDTH-1:0] q_min1,
  input count_enable,
  input restart_enable, // restart after stop, load initial value control
  input clk,
  input rst
);

wire carry_sec0, carry_sec1, carry_min0;

//second0 counter
counterx Usec0(
  .q(q_sec0), // counter value
  .time_carry(carry_sec0), // counter carry
  .count_enable(count_enable), // counting enabled control signal
  .restart_enable(restart_enable), // restart after stop, load initial value control
  .count_limit(`NINE), // limit of the up counter
  .clk(clk), // clock
  .rst(rst) // high active reset
);

//second1 counter
counterx Usec1(
  .q(q_sec1), // counter value
  .time_carry(carry_sec1), // counter carry
  .count_enable(carry_sec0), // counting enabled control signal
  .restart_enable(restart_enable), // restart after stop, load initial value control
  .count_limit(`FIVE), // limit of the up counter
  .clk(clk), // clock
  .rst(rst) // high active reset
);

//minute0 counter
counterx Umin0(
  .q(q_min0), // counter value
  .time_carry(carry_min0), // counter carry
  .count_enable(carry_sec0 && carry_sec1), // counting enabled control signal
  .restart_enable(restart_enable), // restart after stop, load initial value control
  .count_limit(`NINE), // limit of the up counter
  .clk(clk), // clock
  .rst(rst) // high active reset
);

//minute1 counter
counterx Umin1(
  .q(q_min1), // counter value
  .time_carry(), // counter carry
  .count_enable(carry_sec0 && carry_sec1 && carry_min0), // counting enabled control signal
  .restart_enable(restart_enable), // restart after stop, load initial value control
  .count_limit(`FIVE), // limit of the up counter
  .clk(clk), // clock
  .rst(rst) // high active reset
);

endmodule
