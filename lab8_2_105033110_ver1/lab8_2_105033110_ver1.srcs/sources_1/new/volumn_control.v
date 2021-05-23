`timescale 1ns / 1ps
`include "global.v"
module volumn_control(
  output reg [15:0] volumn,
  output reg [`BCD_BIT_WIDTH-1:0] volumn_cnt0,
  output reg [`BCD_BIT_WIDTH-1:0] volumn_cnt1,
  input up_cnt_en, // one_pulse input
  input down_cnt_en, // one_pulse input
  input clk,
  input rst_n
);

wire [7:0] volumn_cnt; // {volumn_cnt1, volumn_cnt0}
reg [`BCD_BIT_WIDTH-1:0] volumn_cnt0_next;
reg [`BCD_BIT_WIDTH-1:0] volumn_cnt1_next;
reg borrow, carry;
wire up_bound;

// up to 16, or down to 0
assign up_bound = ((volumn_cnt0 == `SIX) && (volumn_cnt1 == `ONE)) ? `ENABLED : `DISABLED;
assign down_bound = ((volumn_cnt0 == `ZERO) && (volumn_cnt1 == `ZERO)) ? `ENABLED : `DISABLED;

// LSB counter buffer
always @*
begin
  volumn_cnt0_next = volumn_cnt0;
  borrow = `DISABLED;
  carry = `DISABLED;
  if (up_cnt_en && (~up_bound) && (volumn_cnt0 == `NINE))
  begin
    volumn_cnt0_next = `ZERO;
    carry = `ENABLED;
  end
  else if (up_cnt_en && (~up_bound))
    volumn_cnt0_next = volumn_cnt0 + 1'b1;
  else if (down_cnt_en && (~down_bound) && (volumn_cnt0 == `ZERO))
  begin
    volumn_cnt0_next = `NINE;
    borrow = `ENABLED;
  end
  else if (down_cnt_en && (~down_bound))
    volumn_cnt0_next = volumn_cnt0 - 1'b1;
end

// MSB counter buffer
always @*
begin
  volumn_cnt1_next = volumn_cnt1;
  if (carry && (~up_bound))
    volumn_cnt1_next = volumn_cnt1 + 1'b1;
  else if (borrow && (~down_bound))
    volumn_cnt1_next = volumn_cnt1 - 1'b1;
end

// Counter register
always @(posedge clk or negedge rst_n)
  if (~rst_n)
  begin
    volumn_cnt0 <= `ZERO;
    volumn_cnt1 <= `ZERO;
  end
  else
  begin
    volumn_cnt0 <= volumn_cnt0_next;
    volumn_cnt1 <= volumn_cnt1_next;
  end

// Counter to Volume
assign volumn_cnt = {volumn_cnt1, volumn_cnt0};
always @*
  case (volumn_cnt)
    `VOL_ZERO: volumn = 16'h0000;
    `VOL_ONE: volumn = 16'h0800;
    `VOL_TWO: volumn = 16'h1000;
    `VOL_THREE: volumn = 16'h1800;
    `VOL_FOUR: volumn = 16'h2000;
    `VOL_FIVE: volumn = 16'h2800;
    `VOL_SIX: volumn = 16'h3000;
    `VOL_SEVEN: volumn = 16'h3800;
    `VOL_EIGHT: volumn = 16'h4000;
    `VOL_NINE: volumn = 16'h4800;
    `VOL_TEN: volumn = 16'h5000;
    `VOL_ELEVEN: volumn = 16'h5800;
    `VOL_TWELVE: volumn = 16'h6000;
    `VOL_THIRTEEN: volumn = 16'h6800;
    `VOL_FOURTEEN: volumn = 16'h7000;
    `VOL_FIFTEEN: volumn = 16'h7800;
    `VOL_SIXTEEN: volumn = 16'h7FFF;
    default: volumn = 16'h0000;
  endcase

endmodule
