module tetris(input	logic   Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
               output logic  [2:0]is_tile,             // Whether current pixel belongs to ball or background
					input logic    [7:0]	  keycode,
					input logic    gamestart
);

//gameboard struct 
logic [2:0] gameboardout [219:0];
logic gameover;
logic [11:0] score;
//piececontroller struct
logic [2:0] pieceout [15:0];  //current piece
logic [4:0] piece_x,piece_y;
logic [2:0] piece_type;
logic [3:0] piece_r;   //rotation index: [1:0] is previous index, [3:2] is next index
//board mux related
logic boardselect;
logic boardload;
logic [2:0] boardmuxout [219:0];
logic [2:0] landout [219:0];
logic [2:0] clearout [219:0];
//piece mux related
logic [1:0] pieceselect;
logic pieceload;
logic [2:0] piecemuxout [15:0];
logic [4:0] piecemuxout_x, piecemuxout_y, moveout_x, rotateout_x, rotateout_y, fallout_y, spawnout_x, spawnout_y;
logic [2:0] piecemuxout_type, spawnout_type;
logic [3:0] piecemuxout_r, rotateout_r, spawnout_r;
logic [2:0] rotateout [15:0];
logic [2:0] spawnout [15:0];
//other wires
logic  clockwise, moveleftselect,is_land;

logic piecereset;

//modules
PieceController piececontroller(
   .clk(Clk),.load(pieceload),.gamestart(gamestart),
   .Din(piecemuxout),.Din_x(piecemuxout_x),.Din_y(piecemuxout_y),.Din_type(piecemuxout_type),.Din_r(piecemuxout_r),
   .pieceout(pieceout),.piece_x(piece_x),.piece_y(piece_y),.piece_type(piece_type),.piece_r(piece_r), .piecereset(piecereset)
);     //load controlled by FSM

Gameboard board(.clk(Clk),.load(boardload),.gamestart(gamestart),.Din(boardmuxout), .Dout(gameboardout));  //load controlled by FSM

NewTile newtile(.clk(Clk),.out_data(spawnout),.out_x(spawnout_x),.out_y(spawnout_y),.out_type(spawnout_type),.out_r(spawnout_r), .reset(Reset));

Move move(.xin(piece_x), .yin(piece_y), .gameboard(gameboardout), .piece(pieceout), .select(moveleftselect) ,.xout(moveout_x));    //left: moveleft=1; right: moveleft=0

Rotate rotate(
   .gameboard(gameboardout),
   .piece(pieceout),.piece_x(piece_x),.piece_y(piece_y),.piece_type(piece_type),.piece_r(piece_r),
   .clockwise(clockwise),
   .out(rotateout),.out_x(rotateout_x),.out_y(rotateout_y),.out_r(rotateout_r)
);   //clockwise controlled by FSM

Fall fall( .yin(piece_y), .xin(piece_x),
				.gameboard(gameboardout),
				.piece (pieceout),
				.yout(fallout_y),
				.is_land(is_land)); //land logic tells that the piece has to land.

Land land(.gameboard(gameboardout),.piece(pieceout),.xin(piece_x),.yin(piece_y),.landout(landout), .is_land(is_land)); //is Land for moving from piece to gameboard?

Clear clear(.gameboard(gameboardout),.out(clearout));

Gameover gameovertest(.gameboard(gameboardout),.gameover(gameover)); 
BoardMux boardmux(.A(landout),.B(clearout), .Select(boardselect),.out(boardmuxout));   //boardselect controlled by FSM
PieceMux piecemux(
   .A(pieceout),  .A_x(moveout_x),  .A_y(piece_y),    .A_type(piece_type),    .A_r(piece_r),
   .B(rotateout), .B_x(rotateout_x),.B_y(rotateout_y),.B_type(piece_type),    .B_r(rotateout_r),
   .C(pieceout),  .C_x(piece_x),    .C_y(fallout_y),  .C_type(piece_type),    .C_r(piece_r),
   .D(spawnout),  .D_x(spawnout_x), .D_y(spawnout_y), .D_type(spawnout_type), .D_r(spawnout_r),
   .Select(pieceselect),
   .out(piecemuxout),.out_x(piecemuxout_x),.out_y(piecemuxout_y),.out_type(piecemuxout_type),.out_r(piecemuxout_r)
);  //pieceselect controlled by FSM
FSM fsm(
   .Clk(Clk),.Reset(Reset),.gamestart(gamestart),.keycode(keycode),
   .is_land(is_land),.gameover(gameover),.cleared(cleared),
   .boardselect(boardselect),.pieceselect(pieceselect),.boardload(boardload),.pieceload(pieceload),
   .clockwise(clockwise),.moveleft(moveleftselect),.score(score), .piecereset(piecereset)
);
/*
FSMtest fsm(
   .Clk(Clk),.Reset(Reset),.gamestart(gamestart),.keycode(keycode),
   .is_land(is_land),.gameover(gameover),.cleared(cleared),
   .boardselect(boardselect),.pieceselect(pieceselect),.boardload(boardload),.pieceload(pieceload),
   .clockwise(clockwise),.moveleft(moveleftselect),.score(score), .frame_clk(frame_clk)
);*/



  
always_comb
begin
is_tile = 1'b0; //normally white
if(DrawX < 10'd420 && DrawY <10'd440 && DrawX > 10'd219 && DrawY > 10'd39)
begin //if inisde the game grid, 
	is_tile = gameboardout[10'd20+((DrawY-10'd40)/10'd20)*10'd10+((DrawX-10'd220)/10'd20)]; // tile = the gameboard
	if((((DrawX-10'd220)/5'd20) + 1'b1	>= piece_x) && (((DrawX-10'd220)/5'd20) < piece_x + 2'd3)  && 
	(((DrawY-10'd40)/5'd20) + 3'd3 >= piece_y ) && (((DrawY-10'd40)/5'd20) < piece_y + 3'd1 )
	&& (pieceout[10'd4*(((DrawY-10'd40)/10'd20)-piece_y + 10'd3)+(((DrawX-10'd220)/5'd20) - piece_x+10'd1)] != 3'd0))
	begin
	is_tile = pieceout[10'd4*(((DrawY-10'd40)/10'd20)-piece_y + 10'd3)+(((DrawX-10'd220)/5'd20) - piece_x+10'd1)];
	end
end
	/*	if(pieceout[10'd10*((DrawY/10'd20)-piece_y + 10'd1)+((DrawX/5'd20) - piece_x+10'd1)] != 3'd0)
		begin
		is_tile = pieceout[10'd10*((DrawY/10'd20)-piece_y + 10'd1)+((DrawX/5'd20) - piece_x+10'd1)];
		end
		else
		begin
			is_tile = gameboardout[10'd20+(DrawY/10'd20)*10'd10+(DrawX/10'd20)];
		end
	end
	else
	begin
		is_tile = gameboardout[10'd20+(DrawY/10'd20)*10'd10+(DrawX/10'd20)];
	end
	*/
	/*
else 
	begin
		is_tile = 1'b0;
	end
	*/
end


endmodule