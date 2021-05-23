`include "global.v"
module fsm(
  output reg freq_faster,
  output reg state_led,
  input freq_pb, // push button
  input clk, // clock control
  input rst_n // reset
);

reg state;
reg state_next;


// state transition
always @*
begin
  case (state)
  1'b0: // 1Hz
    begin
      state_led = 1'b0;
      freq_faster = 1'b0;
      if (freq_pb)
        state_next = 1'b1;
      else
        state_next = 1'b0;
    end
  1'b1: // 1k Hz
    begin
      state_led = 1'b1;
      freq_faster = 1'b1;
      if (freq_pb)
        state_next = 1'b0;
      else
        state_next = 1'b1;
    end
  default:
    begin
      state_led = 1'b0;
      freq_faster = 1'b0;
      state_next = 1'b0;
    end
  endcase
end

// state register
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    state <=1'b0;
  else
    state <= state_next;

endmodule
