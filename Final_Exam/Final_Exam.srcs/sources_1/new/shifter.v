`include "global.v"
module shifter(
  q0, q1, q2, q3,  // shifter output
  q0in, q1in, q2in, q3in, q4in, q5in, q6in, q7in, q8in,
  en,
  clk,  // global clock
  rst_n  // active low reset
);

output [`BCD_BIT_WIDTH-1:0] q0;  // output of first ssd
output [`BCD_BIT_WIDTH-1:0] q1;  // output of second ssd
output [`BCD_BIT_WIDTH-1:0] q2;  // output of third ssd
output [`BCD_BIT_WIDTH-1:0] q3;  // output of fourth ssd
input clk;  // global clock
input rst_n;  // active low reset
input [`BCD_BIT_WIDTH-1:0] q0in, q1in, q2in, q3in, q4in, q5in, q6in, q7in, q8in; 
input en;

reg [`BCD_BIT_WIDTH-1:0] q0;  // output
reg [`BCD_BIT_WIDTH-1:0] q1;  // output
reg [`BCD_BIT_WIDTH-1:0] q2;  // output
reg [`BCD_BIT_WIDTH-1:0] q3;  // output
reg [`BCD_BIT_WIDTH-1:0] q4;  // unshowed
reg [`BCD_BIT_WIDTH-1:0] q5;  // unshowed
reg [`BCD_BIT_WIDTH-1:0] q6;  // unshowed
reg [`BCD_BIT_WIDTH-1:0] q7;  // unshowed
reg [`BCD_BIT_WIDTH-1:0] q8;  // unshowed



// Sequential logics: Flip flops
always @(posedge clk or negedge rst_n)
  if ((en)|(~rst_n)) // somehow the ((~rst_n) | (en)) won't work ???
  begin
    /*q0 <= `ONE;
    q1 <= `ZERO;
    q2 <= `FIVE;
    q3 <= `ZERO;
    q4 <= `THREE;
    q5 <= `THREE;
    q6 <= `ONE;
    q7 <= `ONE;
    q8 <= `ONE;*/  
    q0 <= q3in;
    q1 <= q2in;
    q2 <= q1in;
    q3 <= q0in;
    q4 <= q8in;
    q5 <= q7in;
    q6 <= q6in;
    q7 <= q5in;
    q8 <= q4in;  
  end  
  else
  begin
    q0 <= q8;
    q1 <= q0;
    q2 <= q1;
    q3 <= q2;
    q4 <= q3;
    q5 <= q4;
    q6 <= q5;
    q7 <= q6;
    q8 <= q7;
  end
endmodule
