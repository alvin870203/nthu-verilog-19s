`timescale 1ns / 1ps
`include "global.v"
module stopwatch(
  segs, // 7 segment display control
  ssd_ctl, // scan control for 7-segment display
  leds, // light up all LEDs when counter at 00
  clk, // clock
  in, // input control from push button for FSM stop,start,reset
  in_mode // input control from push button for FSM mode control
);

output [`SSD_BIT_WIDTH-1:0] segs; // 7 segment display control
output [`SSD_DIGIT_NUM-1:0] ssd_ctl; // scan control for 7-segment display
output [`LED_NUM-1:0] leds; // output to all 16 LEDs
input clk; // 100MHz crystal clock
input in; // input control for FSM stop,start,reset
input in_mode; // input control for FSM mode control

wire clk_100; // 100Hz divided clock
wire in_db; // debounce circuit output
wire in_1pulse; // one pulse output

wire [`SSD_SCAN_CTL_BIT_WIDTH-1:0] ssd_ctl_en; // divided output for ssd scan control
wire clk_d; // 1Hz divided clock

wire rst; // high active reset
wire rst_init_mode; // high active reset to initial value for mode control
wire rst_init; // high active reset to initial value for stop,start,reset
wire count_enable; // if count is enabled
wire [`BCD_BIT_WIDTH-1:0] init2; // initial value of digit2
wire [`BCD_BIT_WIDTH-1:0] init1; // initial value of digit1
wire [`BCD_BIT_WIDTH-1:0] init0; // initial value of digit0

wire [`BCD_BIT_WIDTH-1:0] dig0,dig1,dig2; // counter output
wire [`BCD_BIT_WIDTH-1:0] ssd_in; // input to 7-segment display decoder

//**************************************************************
// Functional block
//**************************************************************
// clock generator
clock_generator U_CG(
  .clk_100(clk_100), // generated 100 Hz clock
  .clk_1(clk_d), // generated 1 Hz clock
  .clk_ctl(ssd_ctl_en), // divided clock for 7-segment display scan
  .clk(clk), // clock from 100MHz crystal oscillator
  .rst(rst) // high active reset  
);

// debounce circuit
debounce_circuit U_DC(
  .pb_debounced(in_db), // debounced push button output
  .pb_in(in_mode), //push button input
  .clk(clk_100), // clock control
  .rst(rst) // reset
);

// 1 pulse generation circuit
one_pulse U_OP(
  .out_pulse(in_1pulse), // output one pulse
  .in_trig(in_db), // input trigger
  .clk(clk_d),  // clock input
  .rst(rst) //active high reset 
);

// fsm for mode control
fsm_mode U_FM(
  .rst_init(rst_init_mode), // reset to initial value
  .init2(init2), // initial value of digit2
  .init1(init1), // initial value of digit1
  .init0(init0), // initial value of digit0
  .in(in_1pulse), // input from push button
  .clk(clk_d) // clock for fsm
);

// finite state machine for stop,start,reset
fsm U_FSM(
  .count_enable(count_enable), // if counter is enable
  .rst(rst), // if counter is reset, high active
  .rst_init(rst_init), // high active reset to initial value  
  .pb(in), // input from push button, pb(t)
  .clk(clk_d) // clock for fsm
);

// stopwatch module
downcounter_2d U_sw(
  .digit2(dig2),  // 3rd digit of the down counter
  .digit1(dig1),  // 2nd digit of the down counter
  .digit0(dig0),  // 1st digit of the down counter
  .clk(clk_d),  // global clock
  .rst(rst),  // high active reset
  .rst_init(rst_init || rst_init_mode), // high active reset to initial value
  .en(count_enable), // enable/disable for the stopwatch
  .init2(init2), // initial value of digit2
  .init1(init1), // initial value of digit1
  .init0(init0) // initial value of digit0
);

//**************************************************************
// Display block
//**************************************************************
// light up all leds when counter is at 00
all_led U_LED(
  .leds(leds), // connected to all 16 LEDs
  .digit2(dig2),  // 3rd (hundreds) digit of the down counter
  .digit1(dig1),  // 2nd (tens) digit of the down counter
  .digit0(dig0)  // 1st (units) digit of the down counter
);

// Scan control
scan_ctl U_SC(
  .ssd_ctl(ssd_ctl), // ssd display control signal 
  .ssd_in(ssd_in), // output to ssd display
  .in0(4'b1111), // 1st input
  .in1(dig2), // 2nd input
  .in2(dig1), // 3rd input
  .in3(dig0),  // 4th input
  .ssd_ctl_en(ssd_ctl_en) // divided clock for scan control
);

// BCD to 7-segment display decoder
display U_display(
  .segs(segs), // 7-segment display output
  .bcd(ssd_in)  // BCD number input
);

endmodule
