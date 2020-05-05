module Gameboard (
    input logic clk,load,gamestart,
    input logic[2:0] Din[219:0],
    output logic[2:0] Dout[219:0]
);
    always_ff @(posedge clk) begin
		  if(gamestart)
			begin
			for(int i=0;i<220;i++) begin
            Dout[i] <= 3'b0;
				end
			end
			else
				begin
					for(int i=0;i<220;i++) begin
							Dout[i] <= Din[i];
					end
				end
    end

endmodule