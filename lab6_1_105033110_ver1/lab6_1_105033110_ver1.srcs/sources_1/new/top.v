`include "global.v"
module top(
  output [1:0] state_led,
  output clk_led,
  output [`SSD_BIT_WIDTH-1:0] segs,  // 7-segment display
  output [`SSD_NUM-1:0] ssd_ctl, // scan control for 7-segment display
  input btn_start_stop,
  input btn_lap_reset,
  input clk  // clock from oscillator
);

wire clk_1, clk_100, clk_2k; //divided clock
wire in_db; // debounce circuit output
wire in_1pulse; // one pulse output
wire [`BCD_BIT_WIDTH-1:0] ssd_in;
wire [`BCD_BIT_WIDTH-1:0] q_sec0, q_sec1, q_min0, q_min1;
wire [`BCD_BIT_WIDTH-1:0] sec0, sec1,min0, min1; // Binary counter output
wire rst;  // active high reset
wire lap;
wire count_enable;
wire restart_enable;

assign clk_led = clk_1;

// clock generator
clock_generator Uclkgen(
  .clk_1(clk_1), // generated 1 Hz clock
  .clk_100(clk_100), // generated 100 Hz clock
  .clk_2k(clk_2k), // generated 100 Hz clock
  .clk(clk), // clock from crystal
  .rst(rst) // active high reset
);

// debounce circuit
debounce_circuit U_db(
  .pb_debounced(in_db), // debounced push button output
  .pb_in(btn_start_stop), //push button input
  .clk(clk_100), // clock control
  .rst(rst) // reset
);

// 1 pulse generation circuit
one_pulse U_OP(
  .out_pulse(in_1pulse), // output one pulse
  .in_trig(in_db), // input trigger
  .clk(clk_1),  // clock input
  .rst(rst) //active high reset 
);

fsm U_FSM(
  .state_led(state_led),
  .count_enable(count_enable),
  .restart_enable(restart_enable),
  .lap(lap),
  .rst(rst),
  .btn_start_stop(in_1pulse),
  .btn_lap_reset(btn_lap_reset),
  .clk(clk_1)
);

// stopwatch without lap
stopwatch U_stw(
  .q_sec0(q_sec0),
  .q_sec1(q_sec1),
  .q_min0(q_min0),
  .q_min1(q_min1),
  .count_enable(count_enable),
  .restart_enable(restart_enable), // restart after stop, load initial value control
  .clk(clk_1),
  .rst(rst)
);

// lap for stopwatch
lap U_lap(
  .sec0(sec0),
  .sec1(sec1),
  .min0(min0),
  .min1(min1),
  .lap(lap),
  .q_sec0(q_sec0),
  .q_sec1(q_sec1),
  .q_min0(q_min0),
  .q_min1(q_min1),
  .rst(rst)
);

// Scan control
scan_ctl U_SC(
  .ssd_ctl(ssd_ctl), // ssd display control signal
  .ssd_in(ssd_in), // output to ssd display
  .in0(sec0), // 1st input
  .in1(sec1), // 2nd input
  .in2(min0), // 3rd input
  .in3(min1),  // 4th input
  .ssd_ctl_en(clk_2k), // divided clock for scan control
  .rst(rst)
);

// binary to 7-segment display decoder
display U_display(
  .segs(segs), // 7-segment display output
  .bin(ssd_in)  // BCD number input
);

endmodule
