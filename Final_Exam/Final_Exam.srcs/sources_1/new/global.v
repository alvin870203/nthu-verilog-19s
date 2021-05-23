// Clock Generator
`define DIV_BY_50M 50_000_000
`define DIV_BY_50M_BIT_WIDTH 27
`define DIV_BY_500K 500_000
`define DIV_BY_500K_BIT_WIDTH 20
`define DIV_BY_25K 25_000
`define DIV_BY_25K_BIT_WIDTH 15
`define DIV_BY_50K 50_000
`define DIV_BY_50K_BIT_WIDTH 16
`define DIV_BY_500 500
`define DIV_BY_500_BIT_WIDTH 9
`define DIV_BY_20 20
`define DIV_BY_20_BIT_WIDTH 5
`define BCD_BIT_WIDTH 4

//7-segment display
`define SSD_BIT_WIDTH 8 // 7-segment display control
`define SSD_NUM 4 //number of 7-segment display
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
`define SSD_NULL   `SSD_BIT_WIDTH'b1111_1111 // all turned off

// FSM State
`define RESET 3'b0_00
`define START 3'b0_01
`define PAUSE 3'b0_10
`define STW_SETMIN 3'b1_10
`define STW_SETSEC 3'b1_01
`define SETMIN 2'b10
`define SETSEC 2'b01


`define ENABLED 1'b1
`define DISABLED 1'b0

`define F_NULL 4'd15 // for NULL SSD display
`define NINE 4'd9
`define EIGHT 4'd8
`define SEVEN 4'd7
`define SIX 4'd6
`define FIVE 4'd5
`define FOUR 4'd4
`define THREE 4'd3
`define TWO 4'd2
`define ONE 4'd1
`define ZERO 4'd0

`define MON_TWELVE 8'b0001_0010
`define MON_ELEVEN 8'b0001_0001
`define MON_TEN 8'b0001_0000
`define MON_NINE 8'd9
`define MON_EIGHT 8'd8
`define MON_SEVEN 8'd7
`define MON_SIX 8'd6
`define MON_FIVE 8'd5
`define MON_FOUR 8'd4
`define MON_THREE 8'd3
`define MON_TWO 8'd2
`define MON_ONE 8'd1
`define MON_ZERO 8'd0

// Debounce Circuit
`define DEBOUNCE_WINDOW_SIZE 4
