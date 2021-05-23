`include "global.v"
module stopwatch(
  output [9:0] led, // LED to indicate counter reaches 0 
  output [`BCD_BIT_WIDTH-1:0] sec0, // first digit of second
  output [`BCD_BIT_WIDTH-1:0] sec1, // second digit of second
  output [`BCD_BIT_WIDTH-1:0] min0, // first digit of minute
  output [`BCD_BIT_WIDTH-1:0] min1, // second digit of minute
  input count_enable, // counting enabled control signal
  input load_value_enable, // load setting value control
  input [`BCD_BIT_WIDTH-1:0] load_value_sec0, // sec0 to be loaded
  input [`BCD_BIT_WIDTH-1:0] load_value_sec1, // sec1 to be loaded
  input [`BCD_BIT_WIDTH-1:0] load_value_min0, // min0 to be loaded
  input [`BCD_BIT_WIDTH-1:0] load_value_min1, // min1 to be loaded
  input clk, // clock
  input rst_n // low active reset
);

wire borrow_sec0, borrow_sec1, borrow_min0; // borrow indicator
wire allzero; // count to zero indicator

// all zero detection
assign allzero = ((min1==4'd0)&&(min0==4'd0)&&(sec1==4'd0)&&(sec0==4'd0));
assign led = {10{allzero}};

// 1st digit of second
downcounter Usec0(
  .q(sec0), // counter value
  .time_borrow(borrow_sec0), // counter carry
  .count_enable(((~allzero)&count_enable)), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_sec0), // value to be loaded
  .count_limit(`NINE), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

// 2nd digit of second
downcounter Usec1(
  .q(sec1), // counter value
  .time_borrow(borrow_sec1), // counter carry
  .count_enable(borrow_sec0), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_sec1), // value to be loaded
  .count_limit(`FIVE), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

// 1st digit of minute
downcounter Umin0(
  .q(min0), // counter value
  .time_borrow(borrow_min0), // counter carry
  .count_enable(borrow_sec0 && borrow_sec1), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_min0), // value to be loaded
  .count_limit(`NINE), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

// 2nd digit of minute
downcounter Umin1(
  .q(min1), // counter value
  .time_borrow(), // counter carry
  .count_enable(borrow_sec0 && borrow_sec1 && borrow_min0), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_min1), // value to be loaded
  .count_limit(`FIVE), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

endmodule
