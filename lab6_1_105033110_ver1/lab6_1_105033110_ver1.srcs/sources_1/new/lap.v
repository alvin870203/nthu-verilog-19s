`include "global.v"
module lap(
  output reg [`BCD_BIT_WIDTH-1:0] sec0,
  output reg [`BCD_BIT_WIDTH-1:0] sec1,
  output reg [`BCD_BIT_WIDTH-1:0] min0,
  output reg [`BCD_BIT_WIDTH-1:0] min1,
  input lap,
  input [`BCD_BIT_WIDTH-1:0] q_sec0,
  input [`BCD_BIT_WIDTH-1:0] q_sec1,
  input [`BCD_BIT_WIDTH-1:0] q_min0,
  input [`BCD_BIT_WIDTH-1:0] q_min1,
  input rst
);

always @*
  if (rst)
  begin
    sec0 = `BCD_BIT_WIDTH'b0; // initial value
    sec1 = `BCD_BIT_WIDTH'b0; // initial value
    min0 = `BCD_BIT_WIDTH'b0; // initial value
    min1 = `BCD_BIT_WIDTH'b0; // initial value
  end
  else if (~lap)
  begin
    sec0 = q_sec0;
    sec1 = q_sec1;
    min0 = q_min0;
    min1 = q_min1;
  end

endmodule
