`include "global.v"
module top(
  output  [`SSD_BIT_WIDTH-1:0] segs,  // 7-segment display
  output  [`SSD_NUM-1:0] ssd_ctl, // scan control for 7-segment display
  output[`BCD_BIT_WIDTH-1:0] q5,
  output[`BCD_BIT_WIDTH-1:0] q6,
  output[`BCD_BIT_WIDTH-1:0] q7,
  output[`BCD_BIT_WIDTH-1:0] q8,
  input switch,
  input switch_middle,
  input switch_left,
  input  clk,  // clock from oscillator
  input  rst_n  // active low reset
);

wire switch_db, switch_op;
wire switch_db_middle, switch_op_middle;

wire clk_1, clk_100, clk_2k;
wire [`BCD_BIT_WIDTH-1:0] q, dig0, dig1, dig2, dig3;
wire [`BCD_BIT_WIDTH-1:0] dig0c, dig1c, dig2c, dig3c;
wire [`BCD_BIT_WIDTH-1:0] dig0s, dig1s, dig2s, dig3s;
wire [`BCD_BIT_WIDTH-1:0] q0, q1, q2, q3, q4;
wire [`BCD_BIT_WIDTH-1:0] ssd_in;
wire [3:0] state;
wire [3:0] state_shift;

clock_generator U_CG(
  .clk_1(clk_1), // generated 1 Hz clock
  .clk_100(clk_100), // generated 100 Hz clock
  .clk_2k(clk_2k), // generated 2k clock for scan control
  .clk_1k(), // generated 1000 Hz clock, for faster hr display
  .clk_100k(), // slow year, fast day
  .clk_2500k(), // fast year
  .clk(clk), // clock from crystal
  .rst_n(rst_n) // active low reset
);

debounce_circuit U_DC(
  .pb_debounced(switch_db), // debounced push button output
  .pb_in(switch), //push button input
  .clk(clk_100), // clock control
  .rst_n(rst_n) // reset
);

one_pulse U_OP(
  .out_pulse(switch_op), // output one pulse
  .in_trig(switch_db), // input trigger
  .clk(clk_100),  // clock input
  .rst_n(rst_n) //active low reset 
);

BCD_up_counter U_BCDUC(
  .q(q), // counter value
  .time_carry(), // counter carry
  .count_enable(switch_op), // counting enabled control signal
  .count_limit(`NINE), // limit of the up counter
  .clear_and_carry(`DISABLED),
  .clear_value(`ZERO),
  .initial_value(`ZERO),
  .clk(clk_100), // clock
  .rst_n(rst_n), // low active reset
  .dig0(dig0c),
  .dig1(dig1c),
  .dig2(dig2c),
  .dig3(dig3c),
  .q0(q0),
  .q1(q1),
  .q2(q2),
  .q3(q3),
  .q4(q4),
  .q5(q5),
  .q6(q6),
  .q7(q7),
  .q8(q8),
  .state(state)
);


debounce_circuit U_DC_m(
  .pb_debounced(switch_db_middle), // debounced push button output
  .pb_in(switch_middle), //push button input
  .clk(clk_100), // clock control
  .rst_n(rst_n) // reset
);

one_pulse U_OP_m(
  .out_pulse(switch_op_middle), // output one pulse
  .in_trig(switch_db_middle), // input trigger
  .clk(clk_100),  // clock input
  .rst_n(rst_n) //active low reset 
);


fsm U_FSM(
  .state_shift(state_shift),
  .state(state),
  .switch(switch_op_middle),
  .clk(clk_100),
  .rst_n(rst_n),
  .switch_left(switch_left)
);


shifter U_S(
  .q0(dig0s), .q1(dig1s), .q2(dig2s), .q3(dig3s),  // shifter output
  .q0in(q0), .q1in(q1), .q2in(q2), .q3in(q3), .q4in(q4), .q5in(q5), .q6in(q6), .q7in(q7), .q8in(q8),
  .en(switch_left),
  .clk(clk_1),  // global clock
  .rst_n(rst_n)//state_shift[0])  // active low reset
);


assign dig0 = (state_shift == 4'b1) ? dig0s : dig0c;
assign dig1 = (state_shift == 4'b1) ? dig1s : dig1c;
assign dig2 = (state_shift == 4'b1) ? dig2s : dig2c;
assign dig3 = (state_shift == 4'b1) ? dig3s : dig3c;

scan_ctl U_SC(
  .ssd_ctl(ssd_ctl), // ssd display control signal 
  .ssd_in(ssd_in), // output to ssd display
  .in0(dig0), // 1st input
  .in1(dig1), // 2nd input
  .in2(dig2), // 3rd input
  .in3(dig3),  // 4th input
  .ssd_ctl_en(clk_2k), // divided clock for scan control
  .rst_n(rst_n)
);

display U_D(
  .segs(segs), // 14-segment segs output
  .bin(ssd_in)  // binary input
);

endmodule
