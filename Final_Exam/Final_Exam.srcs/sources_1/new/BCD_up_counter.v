`include "global.v"
module BCD_up_counter(
  output reg [`BCD_BIT_WIDTH-1:0] q, // counter value
  output reg time_carry, // counter carry
  input count_enable, // counting enabled control signal
  input [`BCD_BIT_WIDTH-1:0] count_limit, // limit of the up counter
  input clear_and_carry,
  input [`BCD_BIT_WIDTH-1:0] clear_value,
  input [`BCD_BIT_WIDTH-1:0] initial_value,
  input clk, // clock
  input rst_n, // low active reset
  output reg [3:0] dig0,
  output reg [3:0] dig1,
  output reg [3:0] dig2,
  output reg [3:0] dig3,
  output reg [3:0] q0,
  output reg [3:0] q1,
  output reg [3:0] q2,
  output reg [3:0] q3,
  output reg [3:0] q4,
  output reg [3:0] q5,
  output reg [3:0] q6,
  output reg [3:0] q7,
  output reg [3:0] q8,
  input [3:0] state
);

reg [`BCD_BIT_WIDTH-1:0] q_next;
/*
wire [`BCD_BIT_WIDTH-1:0] dig0s, dig1s, dig2s, dig3s;

shifter U_S(
  .q0(dig0s), .q1(dig1s), .q2(dig2s), .q3(dig3s),  // shifter output
  .q0in(q0), .q1in(q1), .q2in(q2), .q3in(q3), .q4in(q4), .q5in(q5), .q6in(q6), .q7in(q7), .q8in(q8),
  .en(`DISABLED),
  .clk(clk_1),  // global clock
  .rst_n(rst_n)  // active low reset
);
*/

reg [`BCD_BIT_WIDTH-1:0] q0_next, q1_next, q2_next, q3_next, q4_next, q5_next, q6_next, q7_next, q8_next;

always @(posedge clk or negedge rst_n)
  if (~rst_n)
    q <= initial_value;
  else
    q <= q_next;

always @*
begin
  q_next = q;
  time_carry = `DISABLED;
  if (clear_and_carry)
  begin
    q_next = clear_value;
    time_carry = `ENABLED;
  end
  else if (count_enable && (q == count_limit))
  begin
    q_next = `BCD_BIT_WIDTH'b0;
    time_carry = `ENABLED;
  end
  else if (count_enable)
    q_next = q + `ONE;
end

always @*
begin
  q0_next = q0;
  q1_next = q1;
  q2_next = q2;
  q3_next = q3;
  q4_next = q4;
  q5_next = q5;
  q6_next = q6;
  q7_next = q7;
  q8_next = q8;
  case (state)
    4'd0:
    begin
      q0_next = q;
      dig0 = q0;
      dig1 = `F_NULL;
      dig2 = `F_NULL;
      dig3 = `F_NULL;
    end
    4'd1:
    begin
      q1_next = q;
      dig0 = q1;
      dig1 = q0;
      dig2 = `F_NULL;
      dig3 = `F_NULL;
    end
    4'd2:
    begin
      q2_next = q;
      dig0 = q2;
      dig1 = q1;
      dig2 = q0;
      dig3 = `F_NULL;
    end  
    4'd3:
    begin
      q3_next = q;
      dig0 = q3;
      dig1 = q2;
      dig2 = q1;
      dig3 = q0;
    end      
    4'd4:
    begin
      q4_next = q;
      dig0 = q4;
      dig1 = q3;
      dig2 = q2;
      dig3 = q1;
    end       
    4'd5:
    begin
      q5_next = q;
      dig0 = q5;
      dig1 = q4;
      dig2 = q3;
      dig3 = q2;
    end       
    4'd6:
    begin
      q6_next = q;
      dig0 = q6;
      dig1 = q5;
      dig2 = q4;
      dig3 = q3;
    end
    4'd7:
    begin
      q7_next = q;
      dig0 = q7;
      dig1 = q6;
      dig2 = q5;
      dig3 = q4;
    end       
    4'd8:
    begin
      q8_next = q;
      dig0 = q8;
      dig1 = q7;
      dig2 = q6;
      dig3 = q5;
    end                    
  endcase
end


always @(posedge clk or negedge rst_n)
if (~rst_n) begin
  q0 <= `F_NULL;
  q1 <= `F_NULL;
  q2 <= `F_NULL;
  q3 <= `F_NULL;
  q4 <= `F_NULL;
  q5 <= `F_NULL;
  q6 <= `F_NULL;
  q7 <= `F_NULL;
  q8 <= `F_NULL; end
else begin
    q0 <= q0_next;
q1 <= q1_next;
q2 <= q2_next;
q3 <= q3_next;
q4 <= q4_next;
q5 <= q5_next;
q6 <= q6_next;
q7 <= q7_next;
q8 <= q8_next; end

endmodule

