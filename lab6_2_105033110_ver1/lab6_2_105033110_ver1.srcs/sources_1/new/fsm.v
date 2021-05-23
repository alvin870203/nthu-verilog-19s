`include "global.v"
module fsm(
  output reg rst_n,
  output reg [2:0] state_led,
  output reg set_enable,
  output reg stopwatch_count_enable,
  output reg data_load_enable,
  output reg reg_load_enable,
  output reg [1:0] set_min_sec,
  output reg [2:0] state,
  input press,
  input switch,
  input mode,
  input clk
);

reg [2:0] state_next;
reg [1:0] press_count; 
wire [1:0] press_count_next;
reg press_delay;
wire long_press, short_press;

//  Counter for press time
assign press_count_next = (press) ? (press_count + 1'b1) : 2'd0;
always @(posedge clk)
    press_count <= press_count_next;

// press delay
always @(posedge clk)
  press_delay <= press;

// Determine short press or long press
assign short_press = (~press) & press_delay & (~(press_count[1]&press_count[0]));
assign long_press = (press_count == 2'b11);


// state transition
always @*
begin
  set_enable = `DISABLED;
  stopwatch_count_enable = `DISABLED;
  data_load_enable = `DISABLED;
  set_min_sec = {2{`DISABLED}};
  reg_load_enable = `DISABLED;
  state_next = `PAUSE;
  state_led = state;
  //rst_n = `ENABLED; // rst_n can't be here, might error trigered
  case (state)
    `RESET:
      begin
        state_led = `RESET;        
        if (~press) // RESET -> PAUSE
        begin
          rst_n = `ENABLED;
          state_next = `PAUSE;
        end
        else // RESET -> RESET
        begin
          rst_n = `DISABLED;
          state_next = `RESET;
        end
      end
    `PAUSE: // STOP(or PAUSE)
      begin
        state_led = `PAUSE;
        stopwatch_count_enable = `DISABLED;
        if (long_press) // STOP(or PAUSE) -> RESET
          state_next = `RESET;
        else if (mode) // STOP(or PAUSE) -> STW_SETMIN
        begin
          reg_load_enable = `ENABLED;
          state_next = `STW_SETMIN;
        end
        else if (short_press) // STOP -> START
        begin
          data_load_enable = `ENABLED;
          state_next = `START;
        end
        else if (switch) // PAUSE -> RESUME
          state_next = `START;
        else // STOP(or PAUSE) -> STOP(or PAUSE)
          state_next = `PAUSE;
      end
    `START: // START(or RESUME)
      begin
        state_led = `START;
        stopwatch_count_enable = `ENABLED;
        if (long_press) // START(or RESUME) -> RESET
          state_next = `RESET;
        else if (mode) // START(or RESUME) -> STW_SETMIN
        begin
          reg_load_enable = `ENABLED;
          state_next = `STW_SETMIN;
        end
        else if (short_press || switch) // START(or RESUME) -> STOP(or PAUSE)
          state_next = `PAUSE;
        else // START(or RESUME) -> START(or RESUME)
          state_next = `START;
      end
    `STW_SETMIN:
      begin
        state_led = `STW_SETMIN;
        set_enable = switch;
        set_min_sec = `SETMIN;
        if (long_press) // STW_SETMIN -> RESET
          state_next = `RESET;
        else if (~mode) // STW_SETMIN -> STOP(or PAUSE)
        begin
          data_load_enable = `ENABLED;
          state_next =  `PAUSE;
        end
        else if (short_press) // STW_SETMIN -> STW_SETSEC
          state_next = `STW_SETSEC;
        else // STW_SETMIN -> STW_SETMIN
          state_next = `STW_SETMIN;
      end
    `STW_SETSEC:
      begin
        state_led = `STW_SETSEC;
        set_enable = switch;
        set_min_sec = `SETSEC;
        if (long_press) // STW_SETSEC -> RESET
          state_next = `RESET;
        else if (~mode) // STW_SETSEC -> STOP(or PAUSE)
        begin
          data_load_enable = `ENABLED;
          state_next =  `PAUSE;
        end
        else if (short_press) // STW_SETSEC -> STW_SETMIN
          state_next = `STW_SETMIN;
        else // STW_SETSEC -> STW_SETSEC
          state_next = `STW_SETSEC;
      end
  endcase
end

// state register
always @(posedge clk)
  state <= state_next;  

endmodule
