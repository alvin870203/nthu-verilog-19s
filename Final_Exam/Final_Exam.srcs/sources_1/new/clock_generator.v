`include "global.v"
module clock_generator(
  output reg clk_1, // generated 1 Hz clock
  output reg clk_100, // generated 100 Hz clock
  output reg clk_2k, // generated 2k clock for scan control
  output reg clk_1k, // generated 1000 Hz clock, for faster hr display
  output reg clk_100k, // slow year, fast day
  output reg clk_2500k, // fast year
  input  clk, // clock from crystal
  input rst_n // active low reset
);

// Declare internal nodes
reg [`DIV_BY_50M_BIT_WIDTH-1:0] count_50M, count_50M_next;
reg [`DIV_BY_500K_BIT_WIDTH-1:0] count_500K, count_500K_next;
reg [`DIV_BY_25K_BIT_WIDTH-1:0] count_25K, count_25K_next;
reg [`DIV_BY_50K_BIT_WIDTH-1:0] count_50K, count_50K_next;
reg [`DIV_BY_500_BIT_WIDTH-1:0] count_500, count_500_next;
reg [`DIV_BY_20_BIT_WIDTH-1:0] count_20, count_20_next;
reg clk_1_next;
reg clk_100_next;
reg clk_2k_next;
reg clk_1k_next;
reg clk_100k_next;
reg clk_2500k_next;

// *******************
// Clock divider for 1 Hz
// *******************
// Clock Divider: Counter operation
always @*
  if (count_50M == `DIV_BY_50M-1)
  begin
    count_50M_next = `DIV_BY_50M_BIT_WIDTH'd0;
    clk_1_next = ~clk_1;
  end
  else
  begin
    count_50M_next = count_50M + 1'b1;
    clk_1_next = clk_1;
  end

// Counter flip-flops
always @(posedge clk or negedge rst_n)
  if (~rst_n)
  begin
    count_50M <=`DIV_BY_50M_BIT_WIDTH'b0;
    clk_1 <=1'b0;
  end
  else
  begin
    count_50M <= count_50M_next;
    clk_1 <= clk_1_next;
  end

// *********************
// Clock divider for 100 Hz
// *********************
// Clock Divider: Counter operation 
always @*
  if (count_500K == `DIV_BY_500K-1)
  begin
    count_500K_next = `DIV_BY_500K_BIT_WIDTH'd0;
    clk_100_next = ~clk_100;
  end
  else
  begin
    count_500K_next = count_500K + 1'b1;
    clk_100_next = clk_100;
  end


// Counter flip-flops
always @(posedge clk or negedge rst_n)
  if (~rst_n)
  begin
    count_500K <=`DIV_BY_500K_BIT_WIDTH'b0;
    clk_100 <=1'b0;
  end
  else
  begin
    count_500K <= count_500K_next;
    clk_100 <= clk_100_next;
  end

// *********************
// Clock divider for 2k Hz
// *********************
// Clock Divider: Counter operation 
always @*
  if (count_25K == `DIV_BY_25K-1)
  begin
    count_25K_next = `DIV_BY_25K_BIT_WIDTH'd0;
    clk_2k_next = ~clk_2k;
  end
  else
  begin
    count_25K_next = count_25K + 1'b1;
    clk_2k_next = clk_2k;
  end


// Counter flip-flops
always @(posedge clk or negedge rst_n)
  if (~rst_n)
  begin
    count_25K <=`DIV_BY_25K_BIT_WIDTH'b0;
    clk_2k <=1'b0;
  end
  else
  begin
    count_25K <= count_25K_next;
    clk_2k <= clk_2k_next;
  end
  
// *********************
// Clock divider for 1k Hz
// *********************
// Clock Divider: Counter operation 
always @*
  if (count_50K == `DIV_BY_50K-1)
  begin
    count_50K_next = `DIV_BY_50K_BIT_WIDTH'd0;
    clk_1k_next = ~clk_1k;
  end
  else
  begin
    count_50K_next = count_50K + 1'b1;
    clk_1k_next = clk_1k;
  end


// Counter flip-flops
always @(posedge clk or negedge rst_n)
  if (~rst_n)
  begin
    count_50K <=`DIV_BY_50K_BIT_WIDTH'b0;
    clk_1k <=1'b0;
  end
  else
  begin
    count_50K <= count_50K_next;
    clk_1k <= clk_1k_next;
  end
  
// *********************
// Clock divider for 100k Hz
// *********************
// Clock Divider: Counter operation 
always @*
  if (count_500 == `DIV_BY_500-1)
  begin
    count_500_next = `DIV_BY_500_BIT_WIDTH'd0;
    clk_100k_next = ~clk_100k;
  end
  else
  begin
    count_500_next = count_500 + 1'b1;
    clk_100k_next = clk_100k;
  end


// Counter flip-flops
always @(posedge clk or negedge rst_n)
  if (~rst_n)
  begin
    count_500 <=`DIV_BY_500_BIT_WIDTH'b0;
    clk_100k <=1'b0;
  end
  else
  begin
    count_500 <= count_500_next;
    clk_100k <= clk_100k_next;
  end
  
// *********************
  // Clock divider for 2500k Hz
  // *********************
  // Clock Divider: Counter operation 
  always @*
  if (count_20 == `DIV_BY_20-1)
  begin
    count_20_next = `DIV_BY_20_BIT_WIDTH'd0;
    clk_2500k_next = ~clk_2500k;
  end
  else
  begin
    count_20_next = count_20 + 1'b1;
    clk_2500k_next = clk_2500k;
  end


// Counter flip-flops
always @(posedge clk or negedge rst_n)
  if (~rst_n)
  begin
    count_20 <=`DIV_BY_20_BIT_WIDTH'b0;
    clk_2500k <=1'b0;
  end
  else
  begin
    count_20 <= count_20_next;
    clk_2500k <= clk_2500k_next;
  end

endmodule
