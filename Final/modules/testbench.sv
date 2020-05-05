module testbench();

timeunit 10ns;

timeprecision 1ns;
	logic CLK;
/*		//Rotate module
	logic [2:0] gameboard[219:0];
    logic [2:0] piece[15:0];
    logic [5:0] piece_x,piece_y;
    logic [2:0] piece_type;
    logic [3:0] piece_r;
    logic clockwise;
     logic [2:0]  out[15:0];
     logic [5:0]  out_x,out_y;
     logic [2:0]  out_type;
     logic [3:0]  out_r;
*/	//Land module
	logic [5:0]  yin, xin;
	logic [2:0] gameboard [219:0];
	logic [2:0] piece [15:0];
	logic is_land;
	logic[2:0] landout [219:0];
/*		//Clear module
	logic[2:0] gameboard[219:0];
	logic[2:0] out[219:0];
	logic cleared;
*/
always begin: CLOCK_GENERATION

#1 CLK=~CLK;

end

initial begin : CLOCK_INITIALIZATION
	CLK=0;
end

//Rotate rotate0(.*);
Land land0(.*);
//Clear clear0(.*);

/*
initial begin: TEST_CLEAR
for(int i=0;i<220;i++)	begin
	if(i>196&&i<218)
		gameboard[i] = 3'b001;
	else
		gameboard[i] = 3'b0;
end
#2;
end
*/
initial begin: TEST_LAND

for(int i=0;i<210;i++)	begin
	gameboard[i] = 3'b0;
end
for(int j=210;j<220;j++)	begin
	gameboard[j] = 3'b001;
end
for(int i=0;i<16;i++)   begin
    if( (i==4)||(i==5)||(i==6)||(i==0) )
        piece[i] = 3'b010;
    else 
        piece[i] = 3'b0;
end
xin = 6'd1;
yin = 6'd20;
is_land = 1'b1;
#2;
end/*
initial begin: TEST_ROTATE

for(int i=0;i<220;i++)	begin
	 if( (i==210)||(i==212)||(i==213)||(i==200)||(i==190) )
			gameboard[i] = 3'b001;
	 else
			gameboard[i] = 3'b0;
end
for(int i=0;i<16;i++)   begin
    if( (i==4)||(i==5)||(i==6)||(i==0) )
        piece[i] = 3'b010;
    else 
        piece[i] = 3'b0;
end
clockwise = 1'b1;
piece_type = 3'b010;
piece_x = 6'd2;
piece_y = 6'd20;
piece_r = 4'b0000;
#2;
end
*/
endmodule
