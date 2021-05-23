`timescale 1ns / 1ps

// Frequency divider 17 for scan_ctl
`define FREQ_DIV_BIT 17 
`define SSD_SCAN_CTL_BIT_WIDTH 2 // scan control bit with for 7-segment display

// freq1Hz for counter
`define FREQ1HZ_BIT 26
`define FREQ1HZ_LIMIT `FREQ1HZ_BIT'd49_999_999

// Down Counter
`define CNT_BIT_WIDTH 4 //number of bits for the counter
`define BCD_ZERO `CNT_BIT_WIDTH'd0 // 4'b0000
`define BCD_NINE `CNT_BIT_WIDTH'd9 // 4'b1001
`define ENABLED  1'b1 // 1
`define DISABLED 1'b0 // 0
`define INCREMENT 1'b1 // +1'b1

// 14-segment display
`define SSD_BIT_WIDTH 8 // 7-segment display control
`define SSD_NUM 4 //number of 7-segment display
`define BCD_BIT_WIDTH 4 // BCD bit width
`define SSD_ZERO   `SSD_BIT_WIDTH'b0000_0011 // 0
`define SSD_ONE    `SSD_BIT_WIDTH'b1001_1111 // 1
`define SSD_TWO    `SSD_BIT_WIDTH'b0010_0101 // 2
`define SSD_THREE  `SSD_BIT_WIDTH'b0000_1101 // 3
`define SSD_FOUR   `SSD_BIT_WIDTH'b1001_1001 // 4
`define SSD_FIVE   `SSD_BIT_WIDTH'b0100_1001 // 5
`define SSD_SIX    `SSD_BIT_WIDTH'b0100_0001 // 6
`define SSD_SEVEN  `SSD_BIT_WIDTH'b0001_1111 // 7
`define SSD_EIGHT  `SSD_BIT_WIDTH'b0000_0001 // 8
`define SSD_NINE   `SSD_BIT_WIDTH'b0000_1001 // 9
`define SSD_A   `SSD_BIT_WIDTH'b0000_0101 // a
`define SSD_B   `SSD_BIT_WIDTH'b1100_0001 // b
`define SSD_C   `SSD_BIT_WIDTH'b1110_0101 // c
`define SSD_D   `SSD_BIT_WIDTH'b1000_0101 // d
`define SSD_E   `SSD_BIT_WIDTH'b0110_0001 // e
`define SSD_F   `SSD_BIT_WIDTH'b0111_0001 // f
`define SSD_DEF    `SSD_BIT_WIDTH'b0000_0000 // default, all LEDs being lighted
`define SSD_NULL   `SSD_BIT_WIDTH'b1111_1111 // null, all LEDs being turned off