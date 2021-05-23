`timescale 1ns / 1ps
`include "global.v"
module all_led(
  leds, // connected to all 16 LEDs
  // {digit1},{digit0}
  digit1,  // 2nd (tens) digit of the down counter
  digit0  // 1st (units) digit of the down counter
);

output [`LED_NUM-1:0] leds; // output to all 16 LEDs
input [`BCD_BIT_WIDTH-1:0] digit1; // 2nd digit of the down counter
input [`BCD_BIT_WIDTH-1:0] digit0; // 1st digit of the down counter

assign leds[0] = (digit0==`BCD_ZERO)&&(digit1==`BCD_ZERO);
assign leds = {`LED_NUM{leds[0]}};

endmodule
