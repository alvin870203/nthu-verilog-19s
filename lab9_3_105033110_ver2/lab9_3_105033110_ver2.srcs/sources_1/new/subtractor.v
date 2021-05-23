`include "global.v"
module subtractor(
  input [3:0] a1,
  input [3:0] a0,
  input [3:0] b1,
  input [3:0] b0,
  output reg [3:0] ans2_sub,
  output [3:0] ans1_sub,
  output [3:0] ans0_sub
);

wire [15:0] a;
wire [15:0] b;
reg [15:0] ans;

assign a = 10*a1 + a0;
assign b = 10*b1 + b0;

always @*
  if (a < b)
  begin
    ans = b - a;
    ans2_sub = `MINUS;
  end
  else 
  begin
    ans = a - b;
    ans2_sub = `F_NULL;
  end

BinaryToBCD U_B2B_add(
  .binary(ans),
  .Thousands(),
  .Hundreds(),
  .Tens(ans1_sub),
  .Ones(ans0_sub)
);

endmodule
