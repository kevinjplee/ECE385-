module ripple_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a ripple adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
logic c1,c2,c3;
four_bit_ra FRA0(.x(A[3:0]),.y(B[3:0]),.ci(0),.s(Sum[3:0]),.co(c1));
four_bit_ra FRA1(.x(A[7:4]),.y(B[7:4]),.ci(c1),.s(Sum[7:4]),.co(c2));
four_bit_ra FRA2(.x(A[11:8]),.y(B[11:8]),.ci(c2),.s(Sum[11:8]),.co(c3));
four_bit_ra FRA3(.x(A[15:12]),.y(B[15:12]),.ci(c3),.s(Sum[15:12]),.co(CO));
     
endmodule


module four_bit_ra(input [3:0] x,y,input ci, output [3:0] s, output co);
logic c1,c2,c3;

full_adder FA0(.x(x[0]),.y(y[0]),.ci(ci),.s(s[0]),.co(c1));
full_adder FA1(.x(x[1]),.y(y[1]),.ci(c1),.s(s[1]),.co(c2));
full_adder FA2(.x(x[2]),.y(y[2]),.ci(c2),.s(s[2]),.co(c3));
full_adder FA3(.x(x[3]),.y(y[3]),.ci(c3),.s(s[3]),.co(co));

endmodule

module full_adder(input x,y,ci, output s,co);
assign s=x^y^ci;
assign co=(x&y)|(y&ci)|(x&ci);

endmodule

