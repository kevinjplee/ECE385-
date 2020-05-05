module FSM( input logic Clk, Reset, gamestart, 
			input logic [7:0] keycode,
			input logic is_land,gameover,cleared,
			output logic boardselect,
			output logic[2:0] pieceselect,
			output logic boardload,pieceload,
			output logic clockwise,moveleft,
			output logic [11:0] score
);
//clock freq is 50000000 Hz
enum logic [4:0] {Wait, Spawn, Start, Move_left, Move_right, Rotate_clock, Rotate_counter, Fall, 
					Land, Clear, Gameover, Keycode_wait, Land_wait} curr_state, next_state;

logic [31:0] count;
logic countup,counter_reset;
Counter fall_counter(.Clk(Clk),.Reset(counter_reset),.countup(countup),.count(count));


	always_ff @ (posedge Clk)
	begin
		if(Reset)	begin
			curr_state <= Wait;
			end
			
		else begin
			curr_state <= next_state;
			end
		end
		
		always_comb
			begin
			
			next_state = curr_state;
			
			boardload = 1'b0;
			pieceload = 1'b0;
			boardselect = 1'b0;
			pieceselect = 2'b00;
			score = 12'h000;
			clockwise = 1'b0;
			moveleft = 1'b0;
			countup = 1'b0;
			counter_reset = 1'b0;
			
			unique case (curr_state)
			
				Wait: begin 
					if(gamestart == 1'b1)
						next_state = Spawn;
					else
						next_state = Wait;
				end
				Spawn: 	next_state = Start;
				Start: begin
					if(  count > 32'd50000000 )	//force entering Fall state for every 1s
						next_state = Fall;
					else if(keycode == 8'h04)
						next_state = Move_left;
					else if (keycode == 8'h07)
						next_state = Move_right;
					else if (keycode == 8'h16 )
						next_state = Fall;
					else if (keycode == 8'h1d)
						next_state = Rotate_clock;
					else if (keycode == 8'h1b)
						next_state = Rotate_counter;
					else if ( count > 32'd49000000)	begin
						if(is_land)
							next_state = Land;
						else	
							next_state = Start;
					end
					else if (gamestart == 1'b1)
						next_state = Spawn;
					else if (gameover)
						next_state = Gameover;
					else
						next_state = Start;
				end
				Keycode_wait:	begin
					if( count > 32'd50000000)	//force entering Fall state for every 1s
						next_state = Fall;
					else if ( count > 32'd49000000)	begin
						if(is_land)
							next_state = Land;
						else	
							next_state = Keycode_wait;
					end
					else if( (keycode==8'h04)||(keycode==8'h07)||(keycode==8'h16)||(keycode==8'h1d)||(keycode==8'h1b) )
						next_state = Keycode_wait;
					else
						next_state = Start;
				end
				Move_left: 		next_state = Keycode_wait;
				Move_right: 	next_state = Keycode_wait;
				Fall: 			next_state = Keycode_wait;
				Rotate_clock: 	next_state = Keycode_wait;
				Rotate_counter: next_state = Keycode_wait;
				//Land: 			next_state = Clear;	
				Land: 			next_state = Land_wait;
				Land_wait:		next_state = Clear;	
				/*
				Move_left: 		next_state = Start;
				Move_right: 	next_state = Start;
				Fall: 			next_state = Start;
				Rotate_clock: 	next_state = Start;
				Rotate_counter: next_state = Start;
				Land: 			next_state = Clear;
				*/
				Clear: 			begin
					if(cleared)
						next_state = Clear;
					else
						next_state = Spawn;	
				end
				Gameover: begin
					if(~gamestart)
						next_state = Wait;
					else	
						next_state = Gameover;
				end
				default:	next_state = Wait;
			endcase
			
			case (curr_state)
				Wait:
				begin
					boardload = 1'b0;
					pieceload = 1'b0;
					score = 12'h000;
					countup = 1'b0;
					counter_reset = 1'b1;
				end
				Spawn:
				begin
					pieceselect = 2'b11;
					boardload = 1'b0;
					pieceload = 1'b1;
				end
				Start:
				begin
					boardload = 1'b0;
					pieceload = 1'b0;
					countup = 1'b1;		//no need to countup in other states because most time it's start state
					counter_reset = 1'b0;
				end
				Keycode_wait:
				begin
					boardload = 1'b0;
					pieceload = 1'b0;
					countup = 1'b1;		//no need to countup in other states because most time it's start state
					counter_reset = 1'b0;
				end
				Land_wait:
				begin
					boardload = 1'b0;
					pieceload = 1'b0;
				end
				Move_left:
				begin
					moveleft = 1'b1;
					pieceselect = 2'b00;
					boardload = 1'b0;
					pieceload = 1'b1;
				end
				Move_right:	
				begin
					moveleft = 1'b0;
					pieceselect = 2'b00;
					boardload = 1'b0;
					pieceload = 1'b1;
				end
				Fall:
				begin
					pieceselect = 2'b10;
					boardload = 1'b0;
					pieceload = 1'b1;
					counter_reset = 1'b1;	//reset counter after each fall
				end
				Rotate_clock:
				begin
					clockwise = 1'b1;
					pieceselect = 2'b01;
					boardload = 1'b0;
					pieceload = 1'b1;
				end
				Rotate_counter:
				begin
					clockwise = 1'b0;
					pieceselect = 2'b01;
					boardload = 1'b0;
					pieceload = 1'b1;
				end
				Land:
				begin
					boardselect = 1'b0;
					boardload = 1'b1;
					pieceload = 1'b0;
				end
				Clear:
				begin
					boardselect = 1'b1;
					boardload = 1'b1;
					pieceload = 1'b0;	
					score += 12'h002;		//not sure if this is ok
				end
				Gameover:
				begin
					boardload = 1'b0;
					pieceload = 1'b0;
					countup = 1'b0;
				end

			endcase
		end

endmodule
				
						
						
						
						
						