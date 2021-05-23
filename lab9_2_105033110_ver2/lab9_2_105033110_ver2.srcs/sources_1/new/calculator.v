`include "global.v"
module calculator(
  output reg [3:0] dig0, // BCD nmber to input to scan_ctl
  output reg [3:0] dig1,
  output reg [3:0] dig2,
  output reg [3:0] dig3,
  input en,
  input [511:0] key_down,
  input [6:0] key_num, // ASCII
  input [1:0] state,
  input clk, // 100MHz
  input rst_n
);

parameter [1:0] STATE_NUM0 = 2'b00;
parameter [1:0] STATE_NUM1 = 2'b10;
parameter [1:0] STATE_ANS = 2'b11;

reg [3:0] a_next;
reg [3:0] b_next;
reg [3:0] a;
reg [3:0] b;
wire [3:0] ans0_add;
wire [3:0] ans1_add;
reg [3:0] dig0_next;
reg [3:0] dig1_next;
reg [3:0] dig2_next;
reg [3:0] dig3_next;



adder U_A(
  .a(a),
  .b(b),
  .s(ans0_add),
  .co(ans1_add)
);


always @*
begin
  a_next = a;
  b_next = b;
  dig3_next = dig3;
  dig2_next = dig2;
  dig1_next = dig1;
  dig0_next = dig0;
  case (state)
    STATE_NUM0: begin
      if (en == 1'b1)
        case (key_num)
          7'd48: a_next = `ZERO;
          7'd49: a_next = `ONE;
          7'd50: a_next = `TWO;
          7'd51: a_next = `THREE;
          7'd52: a_next = `FOUR;
          7'd53: a_next = `FIVE;
          7'd54: a_next = `SIX;
          7'd55: a_next = `SEVEN;
          7'd56: a_next = `EIGHT;
          7'd57: a_next = `NINE;
          default: a_next = a; 
        endcase
      else
        a_next = a;
      dig3_next = a_next; // if(key_num == 7'd10) dig3_next = `F_NULL; // if(dig3_next != `F_NULL) dig2_next = a_next;
      b_next = `F_NULL;
      dig2_next = `F_NULL;
      dig1_next = `F_NULL;
      dig0_next = `F_NULL;
    end
    STATE_NUM1: begin
      if (en == 1'b1)
        case (key_num)
          7'd48: b_next = `ZERO;
          7'd49: b_next = `ONE;
          7'd50: b_next = `TWO;
          7'd51: b_next = `THREE;
          7'd52: b_next = `FOUR;
          7'd53: b_next = `FIVE;
          7'd54: b_next = `SIX;
          7'd55: b_next = `SEVEN;
          7'd56: b_next = `EIGHT;
          7'd57: b_next = `NINE;
          default: b_next = b; 
        endcase
      else
        b_next = b;
      //dig3_next = a;
      dig2_next = b_next;
      dig1_next = `F_NULL;
      dig0_next = `F_NULL;
    end
    STATE_ANS: begin
      dig1_next = ans1_add;
      dig0_next = ans0_add;
    end    
  endcase
end

always @(posedge clk or negedge rst_n)
  if (~rst_n) begin
    a <= `F_NULL;
    b <= `F_NULL;
    dig3 <= `F_NULL;
    dig2 <= `F_NULL;
    dig1 <= `F_NULL;
    dig0 <= `F_NULL;
  end else begin
    a <= a_next;
    b <= b_next;
    dig3 <= dig3_next;
    dig2 <= dig2_next;
    dig1 <= dig1_next;
    dig0 <= dig0_next;
  end



endmodule
