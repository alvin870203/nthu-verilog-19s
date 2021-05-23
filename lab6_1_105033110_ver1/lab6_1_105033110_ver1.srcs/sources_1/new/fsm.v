`include "global.v"
module fsm(
  output reg [1:0] state_led,
  output reg count_enable,
  output reg restart_enable,
  output reg lap,
  output reg rst,
  input btn_start_stop,
  input btn_lap_reset,
  input clk
);

reg [1:0] state;
reg [1:0] state_next;
reg [1:0] press_count;
reg btn_lap_reset_delay;
wire [1:0] press_count_next;
wire long_press, short_press;

//  btn_lap_reset: Counter for press time
assign press_count_next = (btn_lap_reset) ? (press_count + 1'b1) : 2'd0;
always @(posedge clk)
    press_count <= press_count_next;

// btn_lap_reset delay
always @(posedge clk)
    btn_lap_reset_delay <= btn_lap_reset;

// Determine short press or long press
assign short_press = (~btn_lap_reset) & btn_lap_reset_delay & (~(press_count[1]&press_count[0]));
assign long_press = (press_count == 2'b11);

  
// state transition
always @*
begin
  case (state)
  `RESET:
    begin
      state_led = `RESET;
      if (btn_lap_reset) // RESET -> RESET
      begin
        rst = `ENABLED;
        count_enable = `DISABLED;
        restart_enable = `DISABLED;
        lap = `DISABLED;
        state_next = `RESET;
      end
      else // RESET -> STOP
      begin
        rst = `DISABLED;
        state_next = `STOP;
      end
    end
  `STOP:
    begin
      state_led = `STOP;
      if (long_press) // STOP -> RESET
      begin
        state_next = `RESET;
      end
      else if (btn_start_stop) // STOP -> START
      begin
        restart_enable = `ENABLED;
        state_next = `START;
      end
      else // STOP -> STOP
      begin
        count_enable = `DISABLED;
        state_next = `STOP;
      end
    end
  `START:
    begin
      state_led = `START;
      if (long_press) // START -> RESET
      begin
        state_next = `RESET;
      end
      else if (btn_start_stop) // START -> STOP
      begin
        count_enable = `DISABLED;
        state_next = `STOP;
      end
      else if (short_press) // START -> LAP
      begin
        lap = `ENABLED;
        state_next = `LAP;
      end
      else // START -> START
      begin
        count_enable = `ENABLED;
        restart_enable = `DISABLED;
        lap = `DISABLED;
        state_next = `START;
      end
    end
  `LAP:
    begin
      state_led = `LAP;
      if (long_press) // LAP -> RESET
      begin
        state_next = `RESET;
      end
      else if (btn_start_stop) // LAP -> STOP
      begin
        count_enable = `DISABLED;
        lap = `DISABLED;
        state_next = `STOP;
      end
      else if (short_press) // LAP -> START
      begin
        lap = `DISABLED;
        state_next = `START;
      end
      else // LAP -> LAP
      begin
        lap = `ENABLED;
        state_next = `LAP;
      end
    end
  default:
    begin
      rst = `DISABLED;
      count_enable = `DISABLED;
      restart_enable = `DISABLED;
      lap = `DISABLED;
      state_next = `STOP;
    end
  endcase
end

// state register
always @(posedge clk)
  state <= state_next;    

endmodule
