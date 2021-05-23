module multiplier(
  input [3:0] a1,
  input [3:0] a0,
  input [3:0] b1,
  input [3:0] b0,
  output [3:0] ans3_mul,
  output [3:0] ans2_mul,
  output [3:0] ans1_mul,
  output [3:0] ans0_mul
);

wire [15:0] a;
wire [15:0] b;
wire [15:0] ans;

assign a = 10*a1 + a0;
assign b = 10*b1 + b0;
assign ans = a * b;

BinaryToBCD U_B2B_add(
  .binary(ans),
  .Thousands(ans3_mul),
  .Hundreds(ans2_mul),
  .Tens(ans1_mul),
  .Ones(ans0_mul)
);

endmodule
