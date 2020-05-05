/************************************************************************
Avalon-MM Interface for AES Decryption IP Core

Dong Kai Wang, Fall 2017

For use with ECE 385 Experiment 9
University of Illinois ECE Department

Register Map:

 0-3 : 4x 32bit AES Key
 4-7 : 4x 32bit AES Encrypted Message
 8-11: 4x 32bit AES Decrypted Message
   12: Not Used
	13: Not Used
   14: 32bit Start Register
   15: 32bit Done Register

************************************************************************/

module avalon_interface (
	// Avalon Clock Input
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic AVL_CS,						// Avalon-MM Chip Select
	input  logic [3:0] AVL_BYTE_EN,		// Avalon-MM Byte Enable
	input  logic [3:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,	// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,	// Avalon-MM Read Data
	input  logic [9:0]   DrawX, DrawY,
	output logic is_tile
	
	// Exported Conduit Signal to LEDs
);
	logic [31:0] register [49:0];


	always_ff @(posedge CLK)
	begin
		if(RESET) begin
			for(int i = 0; i< 16; i++)begin
			register[i][31:0] <= 32'b0;
			end
		end	
		else if(AVL_WRITE  && AVL_CS )
			begin
			if(AVL_BYTE_EN == 4'b1111)
				begin
				register[AVL_ADDR][31:0] <= AVL_WRITEDATA[31:0];
				end
			else if(AVL_BYTE_EN == 4'b1100)
				begin
				register[AVL_ADDR][31:16] <= AVL_WRITEDATA[31:16];
				end
			else if(AVL_BYTE_EN == 4'b0011)
				begin
				register[AVL_ADDR][15:0] <= AVL_WRITEDATA[15:0];
				end
			else if(AVL_BYTE_EN == 4'b1000)
				begin
				register[AVL_ADDR][31:24] <= AVL_WRITEDATA[31:24];
				end
			else if(AVL_BYTE_EN == 4'b0100)
				begin
				register[AVL_ADDR][23:16] <= AVL_WRITEDATA[23:16];
				end
			else if(AVL_BYTE_EN == 4'b0010)
				begin
				register[AVL_ADDR][15:8] <= AVL_WRITEDATA[15:8];
				end
			else if(AVL_BYTE_EN == 4'b0001)
				begin
				register[AVL_ADDR][7:0] <= AVL_WRITEDATA[7:0];
				end
			else
				register[AVL_ADDR] <= register[AVL_ADDR];
				
			end
		else
		begin
				register[0] <= register[0];
				register[1] <= register[1];
				register[2] <= register[2];
				register[3] <= register[3];
				register[4] <= register[4];
				register[5] <= register[5];
				register[6] <= register[6];
				register[7] <= register[7];
				register[8] <= register[8];
				register[9] <= register[9];
				register[10] <= register[10];
				register[11] <= register[11];
				register[12] <= register[12];
				register[13] <= register[13];
				register[14] <= register[14];
				register[15] <= register[15];
				
				end
	end
	
	always_comb
	begin
		if(AVL_READ && AVL_CS)
		begin
			AVL_READDATA[31:0] = register[AVL_ADDR][31:0];
		end
		else
			AVL_READDATA = 32'b0;
	end
	
endmodule
