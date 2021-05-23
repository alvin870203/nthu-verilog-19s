`include "global.v"
module calculator(
  output reg [3:0] dig0, // BCD nmber to input to scan_ctl
  output reg [3:0] dig1,
  output reg [3:0] dig2,
  output reg [3:0] dig3,
  //input en,
  input [6:0] key_num, // ASCII
  input [2:0] state,
  input clk, // 100MHz
  input rst_n
);

parameter [2:0] STATE_NUM0_1 = 3'b000;
parameter [2:0] STATE_NUM0_0 = 3'b001;
parameter [2:0] STATE_OPERATOR = 3'b010;
parameter [2:0] STATE_NUM1_1 = 3'b011;
parameter [2:0] STATE_NUM1_0 = 3'b100;
parameter [2:0] STATE_ANS = 3'b101;

parameter [3:0] ADD = 4'd10;
parameter [3:0] SUBTRACT = 4'd11;
parameter [3:0] MULTIPLY = 4'd12;

reg [3:0] a0_next, a1_next;
reg [3:0] b0_next, b1_next;
reg [3:0] operator_next;
reg [3:0] a0, a1;
reg [3:0] b0, b1;
reg [3:0] operator;
wire [3:0] ans0_add, ans1_add, ans2_add;
wire [3:0] ans0_sub, ans1_sub, ans2_sub;
wire [3:0] ans0_mul, ans1_mul, ans2_mul, ans3_mul;
reg [3:0] dig0_next;
reg [3:0] dig1_next;
reg [3:0] dig2_next;
reg [3:0] dig3_next;



adder U_A(
  .a1(a1),
  .a0(a0),
  .b1(b1),
  .b0(b0),
  .ans2_add(ans2_add),
  .ans1_add(ans1_add),
  .ans0_add(ans0_add)
);

subtractor U_S(
  .a1(a1),
  .a0(a0),
  .b1(b1),
  .b0(b0),
  .ans2_sub(ans2_sub),
  .ans1_sub(ans1_sub),
  .ans0_sub(ans0_sub)
);

multiplier U_M(
  .a1(a1),
  .a0(a0),
  .b1(b1),
  .b0(b0),
  .ans3_mul(ans3_mul),
  .ans2_mul(ans2_mul),
  .ans1_mul(ans1_mul),
  .ans0_mul(ans0_mul)  
);


always @*
begin
  a1_next = a1;
  a0_next = a0;
  b1_next = b1;
  b0_next = b0;
  operator_next = operator;
  dig3_next = `F_NULL;
  dig2_next = `F_NULL;
  dig1_next = `F_NULL;
  dig0_next = `F_NULL;
  case (state)
    STATE_NUM0_1: begin
      if (a1_next == `F_NULL)
        case (key_num)
          7'd48: a1_next = `ZERO;
          7'd49: a1_next = `ONE;
          7'd50: a1_next = `TWO;
          7'd51: a1_next = `THREE;
          7'd52: a1_next = `FOUR;
          7'd53: a1_next = `FIVE;
          7'd54: a1_next = `SIX;
          7'd55: a1_next = `SEVEN;
          7'd56: a1_next = `EIGHT;
          7'd57: a1_next = `NINE;
          default: a1_next = a1;
        endcase
      else
        a1_next = a1;
      dig1_next = a1_next; // if(key_num == 7'd10) dig3_next = `F_NULL; // if(dig3 != `F_NULL) dig2_next = a_next;
      a0_next = `F_NULL;
      b1_next = `F_NULL;
      b0_next = `F_NULL;
      dig3_next = `F_NULL;
      dig2_next = `F_NULL;
      dig0_next = `F_NULL;
    end
    STATE_NUM0_0: begin
      if (a0_next == `F_NULL)
        case (key_num)
          7'd48: a0_next = `ZERO;
          7'd49: a0_next = `ONE;
          7'd50: a0_next = `TWO;
          7'd51: a0_next = `THREE;
          7'd52: a0_next = `FOUR;
          7'd53: a0_next = `FIVE;
          7'd54: a0_next = `SIX;
          7'd55: a0_next = `SEVEN;
          7'd56: a0_next = `EIGHT;
          7'd57: a0_next = `NINE;
          default: a0_next = a0;
        endcase
      else
        a0_next = a0;
//      if (key_num == 7'd10)
//        dig0_next = `F_NULL;
//      else
        dig0_next = a0_next;
      a1_next = a1;
      dig1_next = dig1;
      b1_next = `F_NULL;
      b0_next = `F_NULL;
      dig3_next = `F_NULL;
      dig2_next = `F_NULL;
    end
    STATE_OPERATOR: begin
      if (operator_next == `F_NULL)
        case (key_num)
          7'd43: operator_next = ADD;
          7'd45: operator_next = SUBTRACT;
          7'd42: operator_next = MULTIPLY;
          default: operator_next = operator;
        endcase
      else
        operator_next = operator;
//      if (key_num == 7'd10)
//        dig0_next = `F_NULL;
//      else
        dig0_next = operator_next;
      a1_next = a1;
      a0_next = a0;
      b1_next = `F_NULL;
      b0_next = `F_NULL;
      dig3_next = `F_NULL;
      dig2_next = `F_NULL;
      dig1_next = `F_NULL;
    end
    STATE_NUM1_1: begin
      if (b1_next == `F_NULL)
        case (key_num)
          7'd48: b1_next = `ZERO;
          7'd49: b1_next = `ONE;
          7'd50: b1_next = `TWO;
          7'd51: b1_next = `THREE;
          7'd52: b1_next = `FOUR;
          7'd53: b1_next = `FIVE;
          7'd54: b1_next = `SIX;
          7'd55: b1_next = `SEVEN;
          7'd56: b1_next = `EIGHT;
          7'd57: b1_next = `NINE;
          default: b1_next = b1; 
        endcase
      else
        b1_next = b1;
      a1_next = a1;
      a0_next = a0;
      dig1_next = b1_next; // if(key_num == 7'd10) dig3_next = `F_NULL; // if(dig3 != `F_NULL) dig2_next = a_next;
      b0_next = `F_NULL;
      dig3_next = `F_NULL;
      dig2_next = `F_NULL;
      dig0_next = `F_NULL;
    end
    STATE_NUM1_0: begin
      if (b0_next == `F_NULL)
        case (key_num)
          7'd48: b0_next = `ZERO;
          7'd49: b0_next = `ONE;
          7'd50: b0_next = `TWO;
          7'd51: b0_next = `THREE;
          7'd52: b0_next = `FOUR;
          7'd53: b0_next = `FIVE;
          7'd54: b0_next = `SIX;
          7'd55: b0_next = `SEVEN;
          7'd56: b0_next = `EIGHT;
          7'd57: b0_next = `NINE;
          default: b0_next = b0; 
        endcase
      else
        b0_next = b0;
      a1_next = a1;
      a0_next = a0;
      b1_next = b1;
      dig1_next = dig1;      
      dig0_next = b0_next;
      dig3_next = `F_NULL;
      dig2_next = `F_NULL;
    end
    STATE_ANS:
      case (operator)
        ADD: begin
          dig2_next = ans2_add;        
          dig1_next = ans1_add;
          dig0_next = ans0_add;          
          dig3_next = `F_NULL;
        end
        SUBTRACT: begin
          dig2_next = ans2_sub;        
          dig1_next = ans1_sub;
          dig0_next = ans0_sub;
          dig3_next = `F_NULL;
        end
        MULTIPLY: begin
          dig3_next = ans3_mul;
          dig2_next = ans2_mul;        
          dig1_next = ans1_mul;
          dig0_next = ans0_mul;
        end
        default: begin
        /*
          dig2_next = ans2_add;        
          dig1_next = ans1_add;
          dig0_next = ans0_add;
        */
          dig2_next = `ONE;        
          dig1_next = `ONE;
          dig0_next = `ONE; 
          dig3_next = `F_NULL;
        end
      endcase   
  endcase
end

always @(posedge clk or negedge rst_n)
  if (~rst_n) begin
    a0 <= `F_NULL;
    a1 <= `F_NULL;
    b0 <= `F_NULL;
    b1 <= `F_NULL;
    operator <= `F_NULL;
    dig3 <= `F_NULL;
    dig2 <= `F_NULL;
    dig1 <= `F_NULL;
    dig0 <= `F_NULL;
  end else begin
    a0 <= a0_next;
    a1 <= a1_next;
    b0 <= b0_next;
    b1 <= b1_next;
    operator <= operator_next;
    dig3 <= dig3_next;
    dig2 <= dig2_next;
    dig1 <= dig1_next;
    dig0 <= dig0_next;
  end



endmodule
