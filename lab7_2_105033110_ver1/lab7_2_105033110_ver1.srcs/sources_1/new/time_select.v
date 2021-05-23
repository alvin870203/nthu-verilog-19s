`include "global.v"
module time_select(
  output reg [`BCD_BIT_WIDTH-1:0] dig0, // right most SSD
  output reg [`BCD_BIT_WIDTH-1:0] dig1,
  output reg [`BCD_BIT_WIDTH-1:0] dig2,
  output reg [`BCD_BIT_WIDTH-1:0] dig3,
  input [`BCD_BIT_WIDTH-1:0] day0,
  input [`BCD_BIT_WIDTH-1:0] day1,
  input [`BCD_BIT_WIDTH-1:0] mon0,
  input [`BCD_BIT_WIDTH-1:0] mon1,
  input [`BCD_BIT_WIDTH-1:0] year0,
  input [`BCD_BIT_WIDTH-1:0] year1,
  input switch // 1 for 00:year, 0 for month:day
);

always @*
  if (switch)
  begin
    dig0 = year0;
    dig1 = year1;
    dig2 = `F_NULL;
    dig3 = `F_NULL;
  end
  else
  begin
    dig0 = day0;
    dig1 = day1;
    dig2 = mon0;
    dig3 = mon1;
  end

endmodule
