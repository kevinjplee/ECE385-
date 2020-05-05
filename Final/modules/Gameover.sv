module Gameover(
    input logic[2:0] gameboard[219:0],
    output logic gameover
);
    always_comb begin
        gameover = 1'b0;
        for(int j=0;j<10;j++)   begin
            if(gameboard[10+j] != 3'b000)   begin
                gameover = 1'b1;
            end
        end
    end
endmodule