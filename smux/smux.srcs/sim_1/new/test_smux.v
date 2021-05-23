module test_smux;
wire OUT;
reg A,B,SEL;

smux U0(.out(OUT),.a(A),.b(B),.sel(SEL));

initial
begin
  A=0;B=0;SEL=0;
  #10 A=0;B=0;SEL=1;
  #10 A=0;B=1;SEL=0;
  #10 A=0;B=1;SEL=1;
  #10 A=1;B=0;SEL=0;
  #10 A=1;B=0;SEL=1;
  #10 A=1;B=1;SEL=0;
  #10 A=1;B=1;SEL=1;
end

endmodule