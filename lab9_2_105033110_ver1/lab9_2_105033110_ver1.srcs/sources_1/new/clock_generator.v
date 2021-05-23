`include "global.v"
module clock_generator(
  output reg clk_2k, // generated 2k clock for scan control
  input clk, // clock from crystal
  input rst_n // active low reset
);

// Declare internal nodes
reg [`DIV_BY_25K_BIT_WIDTH-1:0] count_25K, count_25K_next;
reg clk_2k_next;


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

endmodule
