`timescale 1ns / 1ps
module test_BinaryToBCD();

reg [15:0] binary;
wire [3:0] Thousands;
wire [3:0] Hundreds;
wire [3:0] Tens;
wire [3:0] Ones;

BinaryToBCD U0(
  .binary(binary),
  .Thousands(Thousands),
  .Hundreds(Hundreds),
  .Tens(Tens),
  .Ones(Ones)
);

initial
begin
binary = 16'd999;
#5 binary = 16'd1000;
#5 binary = 16'd1001;
#5 binary = 16'd9801;
#5 binary = 16'd9;
#5 binary = 16'd10;
#5 binary = 16'd11;
#5 binary = 16'd100;
#5 binary = 16'd255;
end

endmodule
