module Land(input logic [5:0]  yin, xin,
				input logic [2:0] gameboard [219:0],
				input logic [2:0] piece [15:0],
				input logic is_land,
				output logic[2:0] landout [219:0]
);

always_comb
begin
	for(int i = 0; i < 220; i++) begin
			landout[i] = gameboard[i];  //first copy all the gameboard to landout
		end
	if(is_land)
	begin
		for(int j = 0; j < 4; j++)begin
			if(piece[j] != 3'b0) //then if each piece cell isn't 0, connect that value to the output
			begin
			landout[9'd10*(yin-1'b1)+(xin-1'b1)+j] = piece[j];
			end
		else landout[9'd10*(yin-1'b1)+(xin-1)+j] = gameboard[9'd10*(yin-1'b1)+(xin-1'b1)+j];
		end
		for(int j = 4; j < 8; j++)begin
			if(piece[j] != 3'b0)  //y increases every loop
			begin
			landout[9'd10*(yin)+(xin-1'b1)+(j-3'd4)] = piece[j];
			end
		else landout[9'd10*(yin)+(xin-1'b1)+(j-3'd4)] = gameboard[9'd10*(yin)+(xin-1'b1)+(j-3'd4)];
		end
		
		for(int j = 8; j < 12; j++)begin
			if(piece[j] != 3'b0)  //y increases every loop
			begin
			landout[9'd10*(yin+1'b1)+(xin-1'b1)+(j-4'd8)] = piece[j];
			end
		else landout[9'd10*(yin+1'b1)+(xin-1'b1)+(j-4'd8)] = gameboard[9'd10*(yin+1'b1)+(xin-1'b1)+(j-4'd8)];
		end
		
		for(int j = 12; j < 16; j++)begin
			if(piece[j] != 3'b0)  //y increases every loop
			begin
			landout[9'd10*(yin+2'd2)+(xin-1'b1)+(j-4'd12)] = piece[j];
			end
		else landout[9'd10*(yin+2'd2)+(xin-1'b1)+(j-4'd12)] = gameboard[9'd10*(yin+2'd2)+(xin-1'b1)+(j-4'd12)];
		end
		//if(is_land && (i >= ((yin-1)*10+(xin-1))) && (i <= ((yin+2)*10+(xin+2))))
	end
	
end

endmodule