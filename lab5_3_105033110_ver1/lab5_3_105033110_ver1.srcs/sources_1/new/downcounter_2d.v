`timescale 1ns / 1ps
`include "global.v"
module downcounter_2d(
  // {digit2},{digit1},{digit0}
  digit2,  // 3rd (hundreds) digit of the down counter
  digit1,  // 2nd (tens) digit of the down counter
  digit0,  // 1st (units) digit of the down counter
  clk,  // global clock
  rst,  // high active reset
  rst_init, // high active reset to initial value
  en, // enable/disable for the stopwatch
  init2, // initial value of digit2
  init1, // initial value of digit1
  init0 // initial value of digit0
);

output [`BCD_BIT_WIDTH-1:0] digit2; // 3rd digit of the down counter
output [`BCD_BIT_WIDTH-1:0] digit1; // 2nd digit of the down counter
output [`BCD_BIT_WIDTH-1:0] digit0; // 1st digit of the down counter

input clk;  // global clock
input rst;  // high active reset
input rst_init; // high active reset to initial value
input en; // enable/disable for the stopwatch
input [`BCD_BIT_WIDTH-1:0] init2; // initial value of digit2
input [`BCD_BIT_WIDTH-1:0] init1; // initial value of digit1
input [`BCD_BIT_WIDTH-1:0] init0; // initial value of digit0

wire br0,br1,br2; // borrow indicator 
wire decrease_enable;

assign decrease_enable = en && (~((digit0==`BCD_ZERO)&&(digit1==`BCD_ZERO)&&(digit2==`BCD_ZERO)));
  
// 30 sec down counter
downcounter Udc0(
  .value(digit0),  // counter value 
  .borrow(br0),  // borrow indicator for counter to next stage
  .clk(clk), // global clock signal
  .rst(rst),  // high active reset
  .rst_init(rst_init), // high active reset to initial value
  .decrease(decrease_enable),  // decrease input from previous stage of counter
  .init_value(init0),  // initial value for the counter
  .limit(`BCD_NINE)  // limit for the counter
);

downcounter Udc1(
  .value(digit1),  // counter value 
  .borrow(br1),  // borrow indicator for counter to next stage
  .clk(clk), // global clock signal
  .rst(rst),  // high active reset
  .rst_init(rst_init), // high active reset to initial value
  .decrease(br0),  // decrease input from previous stage of counter
  .init_value(init1),  // initial value for the counter
  .limit(`BCD_FIVE)  // limit for the counter
);

downcounter Udc2(
  .value(digit2),  // counter value 
  .borrow(br2),  // borrow indicator for counter to next stage
  .clk(clk), // global clock signal
  .rst(rst),  // high active reset
  .rst_init(rst_init), // high active reset to initial value
  .decrease(br1),  // decrease input from previous stage of counter
  .init_value(init2),  // initial value for the counter
  .limit(`BCD_ONE)  // limit for the counter
);

endmodule
