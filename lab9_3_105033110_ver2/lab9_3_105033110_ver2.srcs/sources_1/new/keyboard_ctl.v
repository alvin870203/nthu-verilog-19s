`include "global.v"
module keyboard_ctl(
  output reg [6:0] key_num, // ascii
  input [2:0] state,
  input [511:0] key_down,
  input [8:0] last_change,
  input key_valid,
  input clk, // 100MHz
  input rst_n
);

parameter [2:0] STATE_NUM0_1 = 3'b000;
parameter [2:0] STATE_NUM0_0 = 3'b001;
parameter [2:0] STATE_OPERATOR = 3'b010;
parameter [2:0] STATE_NUM1_1 = 3'b011;
parameter [2:0] STATE_NUM1_0 = 3'b100;
parameter [2:0] STATE_ANS = 3'b101;

reg [6:0] key_num_next;

always @*
  case (state)
    STATE_NUM0_1:
      case (last_change)
        9'h70: // 0
          key_num_next = 7'd48;
        9'h69: // 1
          key_num_next = 7'd49;
        9'h72: // 2
          key_num_next = 7'd50;
        9'h7A: // 3
          key_num_next = 7'd51;
        9'h6B: // 4
          key_num_next = 7'd52;
        9'h73: // 5
          key_num_next = 7'd53;
        9'h74: // 6
          key_num_next = 7'd54;
        9'h6C: // 7
          key_num_next = 7'd55;
        9'h75: // 8
          key_num_next = 7'd56;
        9'h7D: // 9
          key_num_next = 7'd57;
        9'h5A: // Enter
          key_num_next = 7'd10; // ASCII: new line
        default:
          key_num_next = key_num;
      endcase
    STATE_NUM0_0:
      case (last_change)
        9'h70: // 0
          key_num_next = 7'd48;
        9'h69: // 1
          key_num_next = 7'd49;
        9'h72: // 2
          key_num_next = 7'd50;
        9'h7A: // 3
          key_num_next = 7'd51;
        9'h6B: // 4
          key_num_next = 7'd52;
        9'h73: // 5
          key_num_next = 7'd53;
        9'h74: // 6
          key_num_next = 7'd54;
        9'h6C: // 7
          key_num_next = 7'd55;
        9'h75: // 8
          key_num_next = 7'd56;
        9'h7D: // 9
          key_num_next = 7'd57;
        9'h5A: // Enter
            key_num_next = 7'd10; // ASCII: new line
        default:
          key_num_next = key_num;
      endcase
    STATE_OPERATOR:
      case (last_change)
        9'h79: // +
          key_num_next = 7'd43;
        9'h7B: // -
          key_num_next = 7'd45;
        9'h7C: // *
          key_num_next = 7'd42;
        9'h5A: // Enter
          key_num_next = 7'd10; // ASCII: new line
        default:
          key_num_next = key_num;
      endcase
    STATE_NUM1_1:
      case (last_change)
        9'h70: // 0
          key_num_next = 7'd48;
        9'h69: // 1
          key_num_next = 7'd49;
        9'h72: // 2
          key_num_next = 7'd50;
        9'h7A: // 3
          key_num_next = 7'd51;
        9'h6B: // 4
          key_num_next = 7'd52;
        9'h73: // 5
          key_num_next = 7'd53;
        9'h74: // 6
          key_num_next = 7'd54;
        9'h6C: // 7
          key_num_next = 7'd55;
        9'h75: // 8
          key_num_next = 7'd56;
        9'h7D: // 9
          key_num_next = 7'd57;
        9'h5A: // Enter
          key_num_next = 7'd10; // ASCII: new line
        default:
          key_num_next = key_num;
      endcase
    STATE_NUM1_0:
        case (last_change)
          9'h70: // 0
            key_num_next = 7'd48;
          9'h69: // 1
            key_num_next = 7'd49;
          9'h72: // 2
            key_num_next = 7'd50;
          9'h7A: // 3
            key_num_next = 7'd51;
          9'h6B: // 4
            key_num_next = 7'd52;
          9'h73: // 5
            key_num_next = 7'd53;
          9'h74: // 6
            key_num_next = 7'd54;
          9'h6C: // 7
            key_num_next = 7'd55;
          9'h75: // 8
            key_num_next = 7'd56;
          9'h7D: // 9
            key_num_next = 7'd57;
          9'h5A: // Enter
            key_num_next = 7'd10; // ASCII: new line
          default:
            key_num_next = key_num;
        endcase
    default:
      key_num_next = 7'd10;  
  endcase
  



always @(posedge clk or negedge rst_n)
  if (~rst_n)
    key_num <= 7'd10;
  else
    key_num <= key_num_next;


endmodule
