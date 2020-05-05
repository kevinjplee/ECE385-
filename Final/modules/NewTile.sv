module NewTile(
    input logic clk,
    output logic[2:0] out_data[15:0],
    output logic[5:0] out_x,out_y,
    output logic[2:0] out_type,
    output logic[3:0] out_r,
	 input logic reset
);

logic[4:0] random_num2;
logic[7:0] random_num;
lfsr Lfsr (.clk(clk), .reset(reset), .en(1'b1), .q(random_num));
assign random_num2 = (random_num %7) +1;
always_ff @(posedge clk) begin       //may have bug
    case(random_num%7)
    0:  begin
		  out_data[0] <= 3'b0;
        out_data[1] <= 3'b0;
        out_data[2] <= 3'b0;
        out_data[3] <= 3'b0;
        out_data[4] <= 3'b001;
        out_data[5] <= 3'b001;
        out_data[6] <= 3'b001;
        out_data[7] <= 3'b001;
        out_data[8] <= 3'b0;
        out_data[9] <= 3'b0;
        out_data[10] <= 3'b0;
        out_data[11] <= 3'b0;
        out_data[12] <= 3'b0;
        out_data[13] <= 3'b0;
        out_data[14] <= 3'b0;
        out_data[15] <= 3'b0;
        out_type <= 3'b001;
		  end
    1:  begin
	     out_data[0] <= 3'b010;
        out_data[1] <= 3'b0;
        out_data[2] <= 3'b0;
        out_data[3] <= 3'b0;
        out_data[4] <= 3'b010;
        out_data[5] <= 3'b010;
        out_data[6] <= 3'b010;
        out_data[7] <= 3'b0;
        out_data[8] <= 3'b0;
        out_data[9] <= 3'b0;
        out_data[10] <= 3'b0;
        out_data[11] <= 3'b0;
        out_data[12] <= 3'b0;
        out_data[13] <= 3'b0;
        out_data[14] <= 3'b0;
        out_data[15] <= 3'b0;
        out_type <= 3'b010;
		  end
    2:  begin
		  out_data[0] <= 3'b0;
        out_data[1] <= 3'b0;
        out_data[2] <= 3'b011;
        out_data[3] <= 3'b0;
        out_data[4] <= 3'b011;
        out_data[5] <= 3'b011;
        out_data[6] <= 3'b011;
        out_data[7] <= 3'b0;
        out_data[8] <= 3'b0;
        out_data[9] <= 3'b0;
        out_data[10] <= 3'b0;
        out_data[11] <= 3'b0;
        out_data[12] <= 3'b0;
        out_data[13] <= 3'b0;
        out_data[14] <= 3'b0;
        out_data[15] <= 3'b0;
        out_type <= 3'b011;
		  end
    3:  begin
			out_data[0] <= 3'b100;
        out_data[1] <= 3'b100;
        out_data[2] <= 3'b0;
        out_data[3] <= 3'b0;
        out_data[4] <= 3'b100;
        out_data[5] <= 3'b100;
        out_data[6] <= 3'b0;
        out_data[7] <= 3'b0;
        out_data[8] <= 3'b0;
        out_data[9] <= 3'b0;
        out_data[10] <= 3'b0;
        out_data[11] <= 3'b0;
        out_data[12] <= 3'b0;
        out_data[13] <= 3'b0;
        out_data[14] <= 3'b0;
        out_data[15] <= 3'b0;
        out_type <= 3'b100;
		  end
    4:  begin
		  out_data[0] <= 3'b0;
        out_data[1] <= 3'b101;
        out_data[2] <= 3'b101;
        out_data[3] <= 3'b0;
        out_data[4] <= 3'b101;
        out_data[5] <= 3'b101;
        out_data[6] <= 3'b0;
        out_data[7] <= 3'b0;
        out_data[8] <= 3'b0;
        out_data[9] <= 3'b0;
        out_data[10] <= 3'b0;
        out_data[11] <= 3'b0;
        out_data[12] <= 3'b0;
        out_data[13] <= 3'b0;
        out_data[14] <= 3'b0;
        out_data[15] <= 3'b0;
        out_type <= 3'b101;
		  end
    5:  begin
			out_data[0] <= 3'b0;
        out_data[1] <= 3'b110;
        out_data[2] <= 3'b0;
        out_data[3] <= 3'b0;
        out_data[4] <= 3'b110;
        out_data[5] <= 3'b110;
        out_data[6] <= 3'b110;
        out_data[7] <= 3'b0;
        out_data[8] <= 3'b0;
        out_data[9] <= 3'b0;
        out_data[10] <= 3'b0;
        out_data[11] <= 3'b0;
        out_data[12] <= 3'b0;
        out_data[13] <= 3'b0;
        out_data[14] <= 3'b0;
        out_data[15] <= 3'b0;
        out_type <= 3'b110;
		  end
    6:  begin
		  out_data[0] <= 3'b111;
        out_data[1] <= 3'b111;
        out_data[2] <= 3'b0;
        out_data[3] <= 3'b0;
        out_data[4] <= 3'b0;
        out_data[5] <= 3'b111;
        out_data[6] <= 3'b111;
        out_data[7] <= 3'b0;
        out_data[8] <= 3'b0;
        out_data[9] <= 3'b0;
        out_data[10] <= 3'b0;
        out_data[11] <= 3'b0;
        out_data[12] <= 3'b0;
        out_data[13] <= 3'b0;
        out_data[14] <= 3'b0;
        out_data[15] <= 3'b0;
        out_type <= 3'b111;
		  end
    endcase
    out_x <= random_num2;          //may have bug
    out_y <= 5'b00001;
    out_r <= 4'b0;
end

endmodule