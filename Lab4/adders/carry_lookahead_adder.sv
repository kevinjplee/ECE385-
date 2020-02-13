module carry_lookahead_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

logic pg0, pg4, pg8, pg12;
logic gg0, gg4, gg8, gg12;
logic c4, c8, c12;
four_bit_la FBL0(.x(A[3:0]), .y(B[3:0]), .cin(0), .s(Sum[3:0]), .pg(pg0), .gg(gg0));
assign c4 = (0 & pg0)| gg0;
four_bit_la FBL1(.x(A[7:4]), .y(B[7:4]), .cin(c4), .s(Sum[7:4]), .pg(pg4), .gg(gg4));
assign c8 = (c4 & pg4)| gg4;
four_bit_la FBL2(.x(A[11:8]), .y(B[11:8]), .cin(c8), .s(Sum[11:8]), .pg(pg8), .gg(gg8));
assign c12 = (c8 & pg8)| gg8;
four_bit_la FBL3(.x(A[15:12]), .y(B[15:12]), .cin(c12), .s(Sum[15:12]), .pg(pg12), .gg(gg12));
assign CO = (c12 & pg12) || gg12;

    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
     
endmodule

module four_bit_la(
						
	input [3:0] x,
	input [3:0] y,
	input cin,
	output logic [3:0] s,
	output logic pg,
	output logic gg
);

logic [2:0] c;
logic [3:0] p;
logic [3:0] g;

full_adder_la fa0( .x(x[0]), .y(y[0]), .cin(cin), .s(s[0]), .p(p[0]), .g(g[0]));
assign c[0] = (cin & p[0]) | g[0];

full_adder_la fa1( .x(x[1]), .y(y[1]), .cin(c[0]), .s(s[1]), .p(p[1]), .g(g[1]));
assign c[1] = (c[0] & p[1]) | g[1];

full_adder_la fa2( .x(x[2]), .y(y[2]), .cin(c[1]), .s(s[2]), .p(p[2]), .g(g[2]));
assign c[2] = (c[1] & p[2]) | g[2];

full_adder_la fa3( .x(x[3]), .y(y[3]), .cin(c[2]), .s(s[3]), .p(p[3]), .g(g[3]));


assign pg = p[0] & p[1] & p[2] & p[3];
assign gg = g[3] | (g[2] & p[3]) | (g[1] & p[3] & p[2] ) | (g[0] & p[3] & p[2] & p[1]);


endmodule

module full_adder_la(
						input x,
						input y,
						input cin,
						output logic s,
						output logic p,
						output logic g

);
assign s = x^y^cin;
assign p = x | y;
assign g = x & y;

endmodule
