`include "global.v"
module timedisplay(
  output [`BCD_BIT_WIDTH-1:0] sec0,
  output [`BCD_BIT_WIDTH-1:0] sec1,
  output [`BCD_BIT_WIDTH-1:0] min0,
  output [`BCD_BIT_WIDTH-1:0] min1,
  output reg [`BCD_BIT_WIDTH-1:0] hr0,
  output reg [`BCD_BIT_WIDTH-1:0] hr1,
  output reg ampm_led, // 1 for am, 0 for pm
  input count_enable,
  input mode, // 1 for AM/PM, 0 for 24HR
  input freq_faster, // 1 for faster clock, 0 for 1Hz clock
  input clk1,
  input clk1k,
  input rst_n
);

reg clk;
wire carry_sec0, carry_sec1, carry_min0, carry_min1, carry_hr0_24, carry_hr0_12;
wire [`BCD_BIT_WIDTH-1:0] hr0_24, hr1_24, hr0_12, hr1_12;
reg CAC_hr_24, CAC_hr_12; // clear_and_carry
reg ampm, ampm_next;

// clk freq selection
always @*
  case (freq_faster)
    1'b0:
      clk = clk1;
    1'b1:
      clk = clk1k;
    default:
      clk = clk1;
  endcase

//second0 counter
counterx Usec0(
  .q(sec0), // counter value
  .time_carry(carry_sec0), // counter carry
  .count_enable(count_enable), // counting enabled control signal
  .count_limit(`NINE), // limit of the up counter
  .clear_and_carry(`DISABLED),
  .clear_value(`ZERO),
  .initial_value(`ZERO),
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

//second1 counter
counterx Usec1(
  .q(sec1), // counter value
  .time_carry(carry_sec1), // counter carry
  .count_enable(carry_sec0), // counting enabled control signal
  .count_limit(`FIVE), // limit of the up counter
  .clear_and_carry(`DISABLED),
  .clear_value(`ZERO),
  .initial_value(`ZERO),
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

//minute0 counter
counterx Umin0(
  .q(min0), // counter value
  .time_carry(carry_min0), // counter carry
  .count_enable(carry_sec0 && carry_sec1), // counting enabled control signal
  .count_limit(`NINE), // limit of the up counter
  .clear_and_carry(`DISABLED),
  .clear_value(`ZERO),
  .initial_value(`ZERO),
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

//minute1 counter
counterx Umin1(
  .q(min1), // counter value
  .time_carry(carry_min1), // counter carry
  .count_enable(carry_sec0 && carry_sec1 && carry_min0), // counting enabled control signal
  .count_limit(`FIVE), // limit of the up counter
  .clear_and_carry(`DISABLED),
  .clear_value(`ZERO),
  .initial_value(`ZERO),
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

//24HR hour0 counter
counterx Uhr0_24(
  .q(hr0_24), // counter value
  .time_carry(carry_hr0_24), // counter carry
  .count_enable(carry_sec0 && carry_sec1 && carry_min0 && carry_min1), // counting enabled control signal
  .count_limit(`NINE), // limit of the up counter
  .clear_and_carry(CAC_hr_24),
  .clear_value(`ZERO),
  .initial_value(`ZERO),
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

//24HR hour1 counter
counterx Uhr1_24(
  .q(hr1_24), // counter value
  .time_carry(), // counter carry
  .count_enable(carry_sec0 && carry_sec1 && carry_min0 && carry_min1 && carry_hr0_24), // counting enabled control signal
  .count_limit(`TWO), // limit of the up counter
  .clear_and_carry(CAC_hr_24),
  .clear_value(`ZERO),
  .initial_value(`ZERO),
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

// clear and carry for hour_24
always @*
  if (carry_sec0 && carry_sec1 && carry_min0 && carry_min1 && (hr0_24 == `THREE) && (hr1_24 == `TWO))
    CAC_hr_24 = `ENABLED;
  else
    CAC_hr_24 = `DISABLED;

//AM/PM hour0 counter
counterx Uhr0_12(
  .q(hr0_12), // counter value
  .time_carry(carry_hr0_12), // counter carry
  .count_enable(carry_sec0 && carry_sec1 && carry_min0 && carry_min1), // counting enabled control signal
  .count_limit(`NINE), // limit of the up counter
  .clear_and_carry(CAC_hr_12),
  .clear_value(`ONE),
  .initial_value(`TWO),
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

//AM/PM hour1 counter
counterx Uhr1_12(
  .q(hr1_12), // counter value
  .time_carry(), // counter carry
  .count_enable(carry_sec0 && carry_sec1 && carry_min0 && carry_min1 && carry_hr0_12), // counting enabled control signal
  .count_limit(`ONE), // limit of the up counter
  .clear_and_carry(CAC_hr_12),
  .clear_value(`ZERO),
  .initial_value(`ONE),
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

// clear and carry for hour_12
always @*
  if (carry_sec0 && carry_sec1 && carry_min0 && carry_min1 && (hr0_12 == `TWO) && (hr1_12 == `ONE))
    CAC_hr_12 = `ENABLED;
  else
    CAC_hr_12 = `DISABLED;
    
//24HR or AM/PM mode
always @*
  if (mode)
  begin
    hr0 = hr0_12;
    hr1 = hr1_12;
    ampm_led = ampm;
  end
  else
  begin
    hr0 = hr0_24;
    hr1 = hr1_24;
    ampm_led = 1'b0;
  end

//AM or PM
always @*
  if (carry_sec0 && carry_sec1 && carry_min0 && carry_min1 && (hr0_12 == `ONE) && (hr1_12 == `ONE))
    ampm_next = ~ampm;
  else
    ampm_next = ampm;

always @(posedge clk or negedge rst_n)
  if (~rst_n)
    ampm <= 1'b1;
  else
    ampm <= ampm_next;

endmodule
