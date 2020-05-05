module Counter( input logic Clk, Reset, countup, output logic[31:0] count);

	 logic[31:0] next_count;
	 
	 always_comb	begin
		  next_count = count + 1;
	 end
    always_ff @(posedge Clk) begin
        if(countup)
            count <= next_count;
			else if(Reset)
				count <= 32'h0;
			else
				count <= count;
    end
 /*   always_ff @(posedge Reset) begin
        count <= 32'h0;
    end*/
endmodule