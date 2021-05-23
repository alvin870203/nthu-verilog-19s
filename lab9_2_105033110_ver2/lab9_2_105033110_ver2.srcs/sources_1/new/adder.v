module adder(
  input [3:0] a,
  input [3:0] b,
  output reg [3:0] s,
  output reg co
);
    
assign gt=((a+b)>9) ? 1 : 0;
always @*
  if(gt)
  begin
    s = a+b+6;
    co = 1;
  end
  else
  begin
    s = a+b;
    co = 0;
  end
    
endmodule
