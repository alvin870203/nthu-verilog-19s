`include "global.v"
module top(
  output ampm_led,
  output state_led,
  output [`SSD_BIT_WIDTH-1:0] segs,  // 7-segment display
  output [`SSD_NUM-1:0] ssd_ctl, // scan control for 7-segment display
  input mode, // 24HR or AM/PM // DIP
  input switch, // 00:second or hour:minute // DIP
  input freq, // 1Hz or 1kHz // push button
  input clk,  // clock from oscillator
  input rst_n // DIP
);

wire clk_1, clk_100, clk_2k, clk_1k; // divided clock
wire freq_db; // debounce circuit output
wire freq_1pulse; // one pulse output
wire freq_faster; // freq control
wire [`BCD_BIT_WIDTH-1:0] sec0, sec1, min0, min1, hr0, hr1; // timedisplay outputs
wire [`BCD_BIT_WIDTH-1:0] dig0, dig1, dig2, dig3;
wire [`BCD_BIT_WIDTH-1:0] ssd_in;

// clock generator
clock_generator Uclkgen(
  .clk_1(clk_1), // generated 1 Hz clock
  .clk_100(clk_100), // generated 100 Hz clock
  .clk_2k(clk_2k), // generated 2k clock for scan control
  .clk_1k(clk_1k), // generated 1200 Hz clock, for faster hr display
  .clk(clk), // clock from crystal
  .rst_n(rst_n) // active low reset
);

// debounce circuit
debounce_circuit U_db(
  .pb_debounced(freq_db), // debounced push button output
  .pb_in(freq), //push button input
  .clk(clk_100), // clock control
  .rst_n(rst_n) // reset
);

// 1 pulse generation circuit
one_pulse U_OP(
  .out_pulse(freq_1pulse), // output one pulse
  .in_trig(freq_db), // input trigger
  .clk(clk_100),  // clock input
  .rst_n(rst_n) //active high reset 
);

// FSM
fsm U_FSM(
  .freq_faster(freq_faster),
  .state_led(state_led),
  .freq_pb(freq_1pulse), // push button
  .clk(clk_100), // clock control
  .rst_n(rst_n) // reset
);

// Time display (clock)
timedisplay U_TD(
  .sec0(sec0),
  .sec1(sec1),
  .min0(min0),
  .min1(min1),
  .hr0(hr0),
  .hr1(hr1),
  .ampm_led(ampm_led),
  .count_enable(`ENABLED),
  .mode(mode), // 1 for AM/PM, 0 for 24HR
  .freq_faster(freq_faster), // 1 for faster clock, 0 for 1Hz clock
  .clk1(clk_1),
  .clk1k(clk_1k),
  .rst_n(rst_n)
);

// Time selection
time_select U_TS(
  .dig0(dig0), // right most SSD
  .dig1(dig1),
  .dig2(dig2),
  .dig3(dig3),
  .sec0(sec0),
  .sec1(sec1),
  .min0(min0),
  .min1(min1),
  .hr0(hr0),
  .hr1(hr1),
  .switch(switch) // 1 for 00:second, 0 for hour:minute
);

// Scan control
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

// binary to 7-segment display decoder
display U_display(
  .segs(segs), // 7-segment display output
  .bin(ssd_in)  // BCD number input
);

endmodule
