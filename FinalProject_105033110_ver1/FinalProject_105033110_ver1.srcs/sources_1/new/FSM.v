// 6-1
`timescale 1ns / 1ps
`include "global.v"
module FSM(
  output reg [1:0] light_mode,
  input btn_led,
  input clk, // 1Hz
  input rst_n
);

reg [1:0] state;
reg [1:0] state_next;
reg [1:0] press_count;
reg btn_led_delay;
wire [1:0] press_count_next;
wire long_press, short_press;

//  btn_lap_reset: Counter for press time
assign press_count_next = (btn_led) ? (press_count + 1'b1) : 2'd0;
always @(posedge clk)
    press_count <= press_count_next;
    
// btn_lap_reset delay
    always @(posedge clk)
        btn_led_delay <= btn_led;

// Determine short press or long press
assign short_press = (~btn_led) & btn_led_delay & (~(press_count[1]&press_count[0]));
assign long_press = (press_count == 2'b11);

// state transition
always @*
begin
  case (state)
  `DARK:
    begin
      if (short_press) // DARK -> ONE_LIGHT_BLINK
      begin
        light_mode = `ONE_LIGHT_BLINK;
        state_next = `ONE_LIGHT_BLINK;
      end
      else // DARK -> DARK
      begin
        light_mode = `DARK;
        state_next = `DARK;
      end
    end
  `ONE_LIGHT_BLINK:
    begin
      if (long_press) // ONE_LIGHT_BLINK -> DARK
      begin
        light_mode = `DARK;
        state_next = `DARK;
      end
      else if (short_press) // ONE_LIGHT_BLINK -> TWO_LIGHT_BLINK
      begin
        light_mode = `TWO_LIGHT_BLINK;
        state_next = `TWO_LIGHT_BLINK;
      end
      else // ONE_LIGHT_BLINK -> ONE_LIGHT_BLINK
      begin
        light_mode = `ONE_LIGHT_BLINK;
        state_next = `ONE_LIGHT_BLINK;
      end
    end
  `TWO_LIGHT_BLINK:
    begin
      if (long_press) // TWO_LIGHT_BLINK -> DARK
      begin
        light_mode = `DARK;
        state_next = `DARK;
      end
      else if (short_press) // TWO_LIGHT_BLINK -> TWO_LIGHT_BRIGHT
      begin
        light_mode = `TWO_LIGHT_BRIGHT;
        state_next = `TWO_LIGHT_BRIGHT;
      end
      else // TWO_LIGHT_BLINK -> TWO_LIGHT_BLINK
      begin
        light_mode = `TWO_LIGHT_BLINK;
        state_next = `TWO_LIGHT_BLINK;
      end
    end
  `TWO_LIGHT_BRIGHT:
    begin
      if (long_press) // TWO_LIGHT_BRIGHT -> DARK
      begin
        light_mode = `DARK;
        state_next = `DARK;
      end
      else if (short_press) // TWO_LIGHT_BRIGHT -> DARK
      begin
        light_mode = `DARK;
        state_next = `DARK;
      end
      else // TWO_LIGHT_BRIGHT -> TWO_LIGHT_BRIGHT
      begin
        light_mode = `TWO_LIGHT_BRIGHT;
        state_next = `TWO_LIGHT_BRIGHT;
      end
    end
  default:
    begin
      light_mode = `DARK;
      state_next = `DARK;
    end
  endcase
end

// state register
always @(posedge clk)
  if (~rst_n)
    state <= `DARK;
  else
    state <= state_next;  

endmodule
