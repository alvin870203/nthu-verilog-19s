`timescale 1ns / 1ps
module DoReMi(
  output reg [21:0] note_div,
  output reg mute,
  input Do_pb,
  input Re_pb,
  input Mi_pb
);

always @*
begin
  mute = 1'b1;
  note_div = 22'd191571;
  if (Do_pb)
  begin
    mute = 1'b0;
    note_div = 22'd191571;
  end
  else if (Re_pb)
  begin
    mute = 1'b0;
    note_div = 22'd170648;
  end
  else if (Mi_pb)
  begin
    mute = 1'b0;
    note_div = 22'd151515;
  end
end

endmodule
