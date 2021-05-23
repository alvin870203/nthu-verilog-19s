`include "global.v"
module time_select(
  output reg [`BCD_BIT_WIDTH-1:0] dig0, // right most SSD
  output reg [`BCD_BIT_WIDTH-1:0] dig1,
  output reg [`BCD_BIT_WIDTH-1:0] dig2,
  output reg [`BCD_BIT_WIDTH-1:0] dig3,
  input [`BCD_BIT_WIDTH-1:0] sec0,
  input [`BCD_BIT_WIDTH-1:0] sec1,
  input [`BCD_BIT_WIDTH-1:0] min0,
  input [`BCD_BIT_WIDTH-1:0] min1,
  input [`BCD_BIT_WIDTH-1:0] hr0,
  input [`BCD_BIT_WIDTH-1:0] hr1,
  input switch // 1 for 00:second, 0 for hour:minute
);

always @*
  if (switch)
  begin
    dig0 = sec0;
    dig1 = sec1;
    dig2 = `F_NULL;
    dig3 = `F_NULL;
  end
  else
  begin
    dig0 = min0;
    dig1 = min1;
    dig2 = hr0;
    dig3 = hr1;
  end

endmodule
