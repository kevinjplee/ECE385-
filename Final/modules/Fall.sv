module Fall(input logic [5:0]  yin, xin,
				input logic [2:0] gameboard [219:0],
				input logic [2:0] piece [15:0],
				output logic [4:0] yout,
				output logic is_land
);

	logic [15:0] bottom;
	

	always_comb
	begin
		if(bottom == 16'd0)
			begin
			yout = yin + 1'b1;
			is_land = 1'b0;
			end
		else begin
			yout = yin;
			is_land = 1'b1;
		end
	end
	
	Fallcheck fallcheck0 (.piece(piece[0]),  .xin(xin), .yin(yin), .xcoord(2'b0),  .ycoord(2'b0) , .condition(bottom[0]) , .gameboard(gameboard));
	Fallcheck fallcheck1 (.piece(piece[1]),  .xin(xin), .yin(yin), .xcoord(2'b01), .ycoord(2'b0) , .condition(bottom[1]) , .gameboard(gameboard));
	Fallcheck fallcheck2 (.piece(piece[2]),  .xin(xin), .yin(yin), .xcoord(2'b10), .ycoord(2'b0) , .condition(bottom[2]) , .gameboard(gameboard));
	Fallcheck fallcheck3 (.piece(piece[3]),  .xin(xin), .yin(yin), .xcoord(2'b11), .ycoord(2'b0) , .condition(bottom[3]) , .gameboard(gameboard));
	Fallcheck fallcheck4 (.piece(piece[4]),  .xin(xin), .yin(yin), .xcoord(2'b0),  .ycoord(2'b01), .condition(bottom[4]) , .gameboard(gameboard));
	Fallcheck fallcheck5 (.piece(piece[5]),  .xin(xin), .yin(yin), .xcoord(2'b01), .ycoord(2'b01), .condition(bottom[5]) , .gameboard(gameboard));
	Fallcheck fallcheck6 (.piece(piece[6]),  .xin(xin), .yin(yin), .xcoord(2'b10), .ycoord(2'b01), .condition(bottom[6]) , .gameboard(gameboard));
	Fallcheck fallcheck7 (.piece(piece[7]),  .xin(xin), .yin(yin), .xcoord(2'b11), .ycoord(2'b01), .condition(bottom[7]) , .gameboard(gameboard));
	Fallcheck fallcheck8 (.piece(piece[8]),  .xin(xin), .yin(yin), .xcoord(2'b00), .ycoord(2'b10), .condition(bottom[8]) , .gameboard(gameboard));
	Fallcheck fallcheck9 (.piece(piece[9]),  .xin(xin), .yin(yin), .xcoord(2'b01), .ycoord(2'b10), .condition(bottom[9]) , .gameboard(gameboard));
	Fallcheck fallcheck10(.piece(piece[10]), .xin(xin), .yin(yin), .xcoord(2'b10), .ycoord(2'b10), .condition(bottom[10]), .gameboard(gameboard));
	Fallcheck fallcheck11(.piece(piece[11]), .xin(xin), .yin(yin), .xcoord(2'b11), .ycoord(2'b10), .condition(bottom[11]), .gameboard(gameboard));
	Fallcheck fallcheck12(.piece(piece[12]), .xin(xin), .yin(yin), .xcoord(2'b0),  .ycoord(2'b11), .condition(bottom[12]), .gameboard(gameboard));
	Fallcheck fallcheck13(.piece(piece[13]), .xin(xin), .yin(yin), .xcoord(2'b01), .ycoord(2'b11), .condition(bottom[13]), .gameboard(gameboard));
	Fallcheck fallcheck14(.piece(piece[14]), .xin(xin), .yin(yin), .xcoord(2'b10), .ycoord(2'b11), .condition(bottom[14]), .gameboard(gameboard));
	Fallcheck fallcheck15(.piece(piece[15]), .xin(xin), .yin(yin), .xcoord(2'b11), .ycoord(2'b11), .condition(bottom[15]), .gameboard(gameboard));
endmodule

module Fallcheck(		input logic [2:0] piece,
							input logic [2:0] gameboard [219:0],
							input logic [5:0] xin, yin, //global coordinate
							input logic [1:0] xcoord, ycoord, //xcoord, ycoord of the local piece coordinate
							output logic condition
							);
							
always_comb		begin
	condition = 1'b0;
	if(piece != 3'b0)	begin
		if(gameboard[9'd10*(yin+ycoord)+(xin+xcoord-1)] != 3'b0 || (yin+ycoord) >21)	begin		//changde 22 to 21
			condition = 1'b1; // if the global coordinate one below is a block return true
		end
		else	begin
			condition = 1'b0;
		end
	end
end
endmodule