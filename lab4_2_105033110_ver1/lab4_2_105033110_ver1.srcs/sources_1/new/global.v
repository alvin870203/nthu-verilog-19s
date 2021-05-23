`timescale 1ns / 1ps

// freq1Hz
`define FREQ1HZ_BIT 26
`define FREQ1HZ_LIMIT `FREQ1HZ_BIT'd49_999_999

// bincnt
`define BINCNT_BIT 4

// ssd
`define SSD_BIT 8 // ssd display control
`define SSD_NUM 4 // number of ssd (scan)
`define SS_0 `SSD_BIT'b0000_0011
`define SS_1 `SSD_BIT'b1001_1111
`define SS_2 `SSD_BIT'b0010_0101
`define SS_3 `SSD_BIT'b0000_1101
`define SS_4 `SSD_BIT'b1001_1001
`define SS_5 `SSD_BIT'b0100_1001
`define SS_6 `SSD_BIT'b0100_0001
`define SS_7 `SSD_BIT'b0001_1111
`define SS_8 `SSD_BIT'b0000_0001
`define SS_9 `SSD_BIT'b0000_1001
`define SS_A `SSD_BIT'b0001_0001
`define SS_B `SSD_BIT'b1100_0001
`define SS_C `SSD_BIT'b0110_0011
`define SS_D `SSD_BIT'b1000_0101
`define SS_E `SSD_BIT'b0110_0001
`define SS_F `SSD_BIT'b0111_0001
`define SS_NULL `SSD_BIT'b0000_0000 // all lighted