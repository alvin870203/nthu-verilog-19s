// Clock Generator
`define DIV_BY_50M 50_000_000
`define DIV_BY_50M_BIT_WIDTH 27
`define DIV_BY_25K 25_000
`define DIV_BY_25K_BIT_WIDTH 15

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
`define SSD_E   `SSD_BIT_WIDTH'b0110_0001 // E
`define SSD_F   `SSD_BIT_WIDTH'b0111_0001 // F
`define SSD_G   `SSD_BIT_WIDTH'b0100_0001 // G
`define SSD_DEF    `SSD_BIT_WIDTH'b0000_0000 // default, all LEDs being lighted
`define SSD_NULL   `SSD_BIT_WIDTH'b1111_1111 // all turned off

`define ENABLED 1'b1
`define DISABLED 1'b0

`define F_NULL 4'd15 // for NULL SSD display
`define FOURTEEN 4'd14
`define THIRTEEN 4'd13
`define TWELVE 4'd12
`define ELEVEN 4'd11
`define TEN 4'd10
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
