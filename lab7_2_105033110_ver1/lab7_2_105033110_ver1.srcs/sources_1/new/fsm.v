`include "global.v"
module fsm(
  output reg [1:0] freq_faster,
  output reg [1:0] state_led,
  input freq_pb, // push button
  input clk, // clock control
  input rst_n // reset
);

reg [1:0] state;
reg [1:0] state_next;


// state transition
always @*
begin
  case (state)
  2'd0: // 1Hz
    begin
      state_led = 2'd0;
      freq_faster = 2'd0;
      if (freq_pb)
        state_next = 2'd1;
      else
        state_next = 2'd0;
    end
  2'd1: // 100k Hz
    begin
      state_led = 2'd1;
      freq_faster = 2'd1;
      if (freq_pb)
        state_next = 2'd2;
      else
        state_next = 2'd1;
    end
  2'd2: // 2500k Hz
    begin
      state_led = 2'd2;
      freq_faster = 2'd2;
      if (freq_pb)
        state_next = 2'd0;
      else
        state_next = 2'd2;
    end
  default:
    begin
      state_led = 2'd0;
      freq_faster = 2'd0;
      state_next = 2'd0;
    end
  endcase
end

// state register
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    state <=2'd0;
  else
    state <= state_next;

endmodule
