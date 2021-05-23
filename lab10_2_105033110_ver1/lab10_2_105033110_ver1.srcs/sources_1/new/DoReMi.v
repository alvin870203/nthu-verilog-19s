`include "global.v"
module DoReMi(
  output reg [21:0] note_div,
  output reg mute,
  input [`BCD_BIT_WIDTH-1:0] freq
);

always @*
begin
  mute = 1'b1;
  note_div = 22'd191571;
  case (freq)
    `ONE:
    begin
      mute = 1'b0;
      note_div = 22'd191571;
    end
    `TWO:
    begin
      mute = 1'b0;
      note_div = 22'd170648;
    end
    `THREE:
    begin
      mute = 1'b0;
      note_div = 22'd151515;
    end
    `FOUR:
    begin
      mute = 1'b0;
      note_div = 22'd143266;
    end
    `FIVE:
    begin
      mute = 1'b0;
      note_div = 22'd127551;
    end
    `SIX:
    begin
      mute = 1'b0;
      note_div = 22'd113636;
    end      
    `SEVEN:
    begin
      mute = 1'b0;
      note_div = 22'd101215;
    end     
    `EIGHT:
    begin
      mute = 1'b0;
      note_div = 22'd95420;
    end     
    `NINE:
    begin
      mute = 1'b0;
      note_div = 22'd85034;
    end
    `TEN:
    begin
      mute = 1'b0;
      note_div = 22'd75758;
    end      
    `ELEVEN:
    begin
      mute = 1'b0;
      note_div = 22'd71633;
    end     
    `TWELVE:
    begin
      mute = 1'b0;
      note_div = 22'd63776;
    end    
    `THIRTEEN:
    begin
      mute = 1'b0;
      note_div = 22'd56818;
    end      
    `FOURTEEN:
    begin
      mute = 1'b0;
      note_div = 22'd50607;
    end      
  endcase
end

endmodule
