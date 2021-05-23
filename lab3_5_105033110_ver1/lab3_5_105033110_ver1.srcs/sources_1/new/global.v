`timescale 1ns / 1ps

// Frequency divider
`define FREQ_DIV_BIT 27 
`define SSD_SCAN_CTL_BIT_WIDTH 2 // scan control bit with for 7-segment display

// 14-segment display
`define SSD_BIT_WIDTH 8 // 7-segment display control
`define SSD_NUM 4 //number of 7-segment display
`define BCD_BIT_WIDTH 4 // BCD bit width
`define SSD_N   `SSD_BIT_WIDTH'b1101_0101 // n
`define SSD_T   `SSD_BIT_WIDTH'b1110_0001 // t
`define SSD_H   `SSD_BIT_WIDTH'b1001_0001 // H
`define SSD_U   `SSD_BIT_WIDTH'b1000_0011 // U
`define SSD_E   `SSD_BIT_WIDTH'b0110_0001 // E
`define SSD_DEF    `SSD_BIT_WIDTH'b0000_0000 // default, all LEDs being lighted
