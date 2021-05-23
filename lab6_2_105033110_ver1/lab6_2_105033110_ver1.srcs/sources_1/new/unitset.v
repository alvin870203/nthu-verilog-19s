`include "global.v"
module unitset(
  output [`BCD_BIT_WIDTH-1:0] q0,
  output [`BCD_BIT_WIDTH-1:0] q1,
  output [`BCD_BIT_WIDTH-1:0] q2,
  output [`BCD_BIT_WIDTH-1:0] q3,
  input [1:0] count_enable,
  input load_value_enable,
  input [`BCD_BIT_WIDTH-1:0] load_value_q0,
  input [`BCD_BIT_WIDTH-1:0] load_value_q1,
  input [`BCD_BIT_WIDTH-1:0] load_value_q2,
  input [`BCD_BIT_WIDTH-1:0] load_value_q3,
  input clk,
  input rst_n
);

wire carry_q0;
wire carry_q2;

counterx Uq0(
  .q(q0), // counter value
  .time_carry(carry_q0), // counter carry
  .count_enable(count_enable[0]), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_q0), // value to be loaded
  .count_limit(`NINE), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n), // low active reset
  .min_23(`DISABLED)
);

counterx Uq1(
  .q(q1), // counter value
  .time_carry(), // counter carry
  .count_enable(carry_q0), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_q1), // value to be loaded
  .count_limit(`FIVE), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n), // low active reset
  .min_23(`DISABLED)
);

counterx Uq2(
  .q(q2), // counter value
  .time_carry(carry_q2), // counter carry
  .count_enable(count_enable[1]), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_q2), // value to be loaded
  .count_limit(`NINE), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n), // low active reset
  .min_23((q2==`THREE)&(q3==`TWO))
);

counterx Uq3(
  .q(q3), // counter value
  .time_carry(), // counter carry
  .count_enable(carry_q2), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_q3), // value to be loaded
  .count_limit(`FIVE), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n), // low active reset
  .min_23((q2==`THREE)&(q3==`TWO))
);

endmodule
