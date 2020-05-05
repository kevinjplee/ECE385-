module Move(input logic [5:0]  xin, yin,
				input logic [2:0] piece [15:0],
				input logic select,
				input logic [2:0] gameboard [219:0],
				output logic [4:0] xout
);

	logic [15:0] leftwall, rightwall;
	

	always_comb
	begin
		if(select == 1'b1)
		begin
			if(leftwall == 16'b0)
			begin
				xout = xin - 1'b1;
			end
			else
				xout = xin;
		end
		else
		begin
			if(rightwall == 16'b0)
			begin
				xout = xin + 1'b1;
			end
			else
				xout = xin;
		end
	end
		
		
		
	leftwallcheck leftwallcheck0 (.piece(piece[0]),  .xin(xin), .yin(yin), .xcoord(2'b0),  .ycoord(2'b0) ,.gameboard(gameboard),.condition(leftwall[0]));
	leftwallcheck leftwallcheck1 (.piece(piece[1]),  .xin(xin), .yin(yin), .xcoord(2'b01), .ycoord(2'b0) ,.gameboard(gameboard),.condition(leftwall[1]));
	leftwallcheck leftwallcheck2 (.piece(piece[2]),  .xin(xin), .yin(yin), .xcoord(2'b10), .ycoord(2'b0) ,.gameboard(gameboard),.condition(leftwall[2]));
	leftwallcheck leftwallcheck3 (.piece(piece[3]),  .xin(xin), .yin(yin), .xcoord(2'b11), .ycoord(2'b0) ,.gameboard(gameboard),.condition(leftwall[3]));
	leftwallcheck leftwallcheck4 (.piece(piece[4]),  .xin(xin), .yin(yin), .xcoord(2'b0),  .ycoord(2'b01),.gameboard(gameboard),.condition(leftwall[4]));
	leftwallcheck leftwallcheck5 (.piece(piece[5]),  .xin(xin), .yin(yin), .xcoord(2'b01), .ycoord(2'b01),.gameboard(gameboard),.condition(leftwall[5]));
	leftwallcheck leftwallcheck6 (.piece(piece[6]),  .xin(xin), .yin(yin), .xcoord(2'b10), .ycoord(2'b01),.gameboard(gameboard),.condition(leftwall[6]));
	leftwallcheck leftwallcheck7 (.piece(piece[7]),  .xin(xin), .yin(yin), .xcoord(2'b11), .ycoord(2'b10),.gameboard(gameboard),.condition(leftwall[7]));
	leftwallcheck leftwallcheck8 (.piece(piece[8]),  .xin(xin), .yin(yin), .xcoord(2'b00), .ycoord(2'b10),.gameboard(gameboard),.condition(leftwall[8]));
	leftwallcheck leftwallcheck9 (.piece(piece[9]),  .xin(xin), .yin(yin), .xcoord(2'b01), .ycoord(2'b10),.gameboard(gameboard),.condition(leftwall[9]));
	leftwallcheck leftwallcheck10(.piece(piece[10]), .xin(xin), .yin(yin), .xcoord(2'b10), .ycoord(2'b10),.gameboard(gameboard),.condition(leftwall[10]));
	leftwallcheck leftwallcheck11(.piece(piece[11]), .xin(xin), .yin(yin), .xcoord(2'b11), .ycoord(2'b10),.gameboard(gameboard),.condition(leftwall[11]));
	leftwallcheck leftwallcheck12(.piece(piece[12]), .xin(xin), .yin(yin), .xcoord(2'b0),  .ycoord(2'b11),.gameboard(gameboard),.condition(leftwall[12]));
	leftwallcheck leftwallcheck13(.piece(piece[13]), .xin(xin), .yin(yin), .xcoord(2'b01), .ycoord(2'b11),.gameboard(gameboard),.condition(leftwall[13]));
	leftwallcheck leftwallcheck14(.piece(piece[14]), .xin(xin), .yin(yin), .xcoord(2'b10), .ycoord(2'b11),.gameboard(gameboard),.condition(leftwall[14]));
	leftwallcheck leftwallcheck15(.piece(piece[15]), .xin(xin), .yin(yin), .xcoord(2'b11), .ycoord(2'b11),.gameboard(gameboard),.condition(leftwall[15]));
	
	
		
	rightwallcheck rightwallcheck0 (.piece(piece[0]),  .xin(xin),.yin(yin), .xcoord(2'b0),  .ycoord(2'b0) ,.gameboard(gameboard), .condition(rightwall[0]));
	rightwallcheck rightwallcheck1 (.piece(piece[1]),  .xin(xin),.yin(yin), .xcoord(2'b01), .ycoord(2'b0) ,.gameboard(gameboard), .condition(rightwall[1]));
	rightwallcheck rightwallcheck2 (.piece(piece[2]),  .xin(xin),.yin(yin), .xcoord(2'b10), .ycoord(2'b0) ,.gameboard(gameboard), .condition(rightwall[2]));
	rightwallcheck rightwallcheck3 (.piece(piece[3]),  .xin(xin),.yin(yin), .xcoord(2'b11), .ycoord(2'b0) ,.gameboard(gameboard), .condition(rightwall[3]));
	rightwallcheck rightwallcheck4 (.piece(piece[4]),  .xin(xin),.yin(yin), .xcoord(2'b0),  .ycoord(2'b01),.gameboard(gameboard), .condition(rightwall[4]));
	rightwallcheck rightwallcheck5 (.piece(piece[5]),  .xin(xin),.yin(yin), .xcoord(2'b01), .ycoord(2'b01),.gameboard(gameboard), .condition(rightwall[5]));
	rightwallcheck rightwallcheck6 (.piece(piece[6]),  .xin(xin),.yin(yin), .xcoord(2'b10), .ycoord(2'b01),.gameboard(gameboard), .condition(rightwall[6]));
	rightwallcheck rightwallcheck7 (.piece(piece[7]),  .xin(xin),.yin(yin), .xcoord(2'b11), .ycoord(2'b10),.gameboard(gameboard), .condition(rightwall[7]));
	rightwallcheck rightwallcheck8 (.piece(piece[8]),  .xin(xin),.yin(yin), .xcoord(2'b00), .ycoord(2'b10),.gameboard(gameboard), .condition(rightwall[8]));
	rightwallcheck rightwallcheck9 (.piece(piece[9]),  .xin(xin),.yin(yin), .xcoord(2'b01), .ycoord(2'b10),.gameboard(gameboard), .condition(rightwall[9]));
	rightwallcheck rightwallcheck10(.piece(piece[10]), .xin(xin),.yin(yin), .xcoord(2'b10), .ycoord(2'b10),.gameboard(gameboard), .condition(rightwall[10]));
	rightwallcheck rightwallcheck11(.piece(piece[11]), .xin(xin),.yin(yin), .xcoord(2'b11), .ycoord(2'b10),.gameboard(gameboard), .condition(rightwall[11]));
	rightwallcheck rightwallcheck12(.piece(piece[12]), .xin(xin),.yin(yin), .xcoord(2'b0),  .ycoord(2'b11),.gameboard(gameboard), .condition(rightwall[12]));
	rightwallcheck rightwallcheck13(.piece(piece[13]), .xin(xin),.yin(yin), .xcoord(2'b01), .ycoord(2'b11),.gameboard(gameboard), .condition(rightwall[13]));
	rightwallcheck rightwallcheck14(.piece(piece[14]), .xin(xin),.yin(yin), .xcoord(2'b10), .ycoord(2'b11),.gameboard(gameboard), .condition(rightwall[14]));
	rightwallcheck rightwallcheck15(.piece(piece[15]), .xin(xin),.yin(yin), .xcoord(2'b11), .ycoord(2'b11),.gameboard(gameboard), .condition(rightwall[15]));
	
	
	
	
endmodule

module leftwallcheck(input logic [2:0] piece,
							input logic [5:0] xin, yin,
							input logic [1:0] xcoord, ycoord,	
							input logic [2:0] gameboard [219:0],
							output logic condition
							);
							
always_comb
if(piece != 3'b0)
begin
	if(xin + xcoord < 2 || gameboard[9'd10*(yin+ycoord-1)+(xin+xcoord-2)] != 3'b0)
	begin
		condition = 1'b1; // if off the left wall, return true
	end
	else
		condition = 1'b0;
end
else
	condition = 1'b0;
endmodule


module rightwallcheck(input logic [2:0] piece,
							input logic [5:0] xin, yin,
							input logic [1:0] xcoord, ycoord,
							input logic [2:0] gameboard [219:0],
							output logic condition
							);
							
always_comb
begin
if(piece != 3'b0)
begin
	if(xin + xcoord > 9 || gameboard[9'd10*(yin+ycoord-1)+(xin+xcoord)] != 3'b0)
	begin
		condition = 1'b1; // if off the right wall, return true
	end
	else condition = 1'b0;
	end
	else
		condition = 1'b0;
end
endmodule