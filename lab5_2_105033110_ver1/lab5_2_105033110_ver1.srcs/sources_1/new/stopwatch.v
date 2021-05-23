`timescale 1ns / 1ps
`include "global.v"
module stopwatch(
  segs, // 7 segment display control
  ssd_ctl, // scan control for 7-segment display
  leds, // light up all LEDs when counter at 00
  clk, // clock
  in // input control from push button for FSM
);

output [`SSD_BIT_WIDTH-1:0] segs; // 7 segment display control
output [`SSD_DIGIT_NUM-1:0] ssd_ctl; // scan control for 7-segment display
output [`LED_NUM-1:0] leds; // output to all 16 LEDs
input clk; // 100MHz crystal clock
input in; // input control for FSM

wire clk_100; // 100Hz divided clock (unused)

wire [`SSD_SCAN_CTL_BIT_WIDTH-1:0] ssd_ctl_en; // divided output for ssd scan control
wire clk_d; // 1Hz divided clock

wire rst; // high active reset
wire count_enable; // if count is enabled

wire [`BCD_BIT_WIDTH-1:0] dig0,dig1; // second counter output
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

// finite state machine
fsm U_FSM(
  .count_enable(count_enable), // if counter is enable
  .rst(rst), // if counter is reset, high active
  .pb(in), // input from push button, pb(t)
  .clk(clk_d) // clock for fsm
);

// stopwatch module
downcounter_2d U_sw(
  .digit1(dig1),  // 2nd digit of the down counter
  .digit0(dig0),  // 1st digit of the down counter
  .clk(clk_d),  // global clock
  .rst(rst),  // low active reset
  .en(count_enable) // enable/disable for the stopwatch
);

//**************************************************************
// Display block
//**************************************************************
// light up all leds when counter is at 00
all_led U_LED(
  .leds(leds), // connected to all 16 LEDs
  .digit1(dig1),  // 2nd (tens) digit of the down counter
  .digit0(dig0)  // 1st (units) digit of the down counter
);

// Scan control
scan_ctl U_SC(
  .ssd_ctl(ssd_ctl), // ssd display control signal 
  .ssd_in(ssd_in), // output to ssd display
  .in0(4'b1111), // 1st input
  .in1(4'b1111), // 2nd input
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
