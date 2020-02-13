module carry_select_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a carry select.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
     logic c1,c10,c11,c2,c20,c21,c3,c30,c31,a1,a2,a3;
 logic [15:0] SumA,SumB;
 
 four_bit_ra FRA0(.x(A[3:0]),.y(B[3:0]),.ci(0),.s(Sum[3:0]),.co(c1));
 
 four_bit_ra FRA10(.x(A[7:4]),.y(B[7:4]),.ci(0),.s(SumA[7:4]),.co(c10));
 four_bit_ra FRA11(.x(A[7:4]),.y(B[7:4]),.ci(1),.s(SumB[7:4]),.co(c11));
 two_one_mux M1(.x(SumA[7:4]),.y(SumB[7:4]),.ci(c1),.s(Sum[7:4]));
 AND_gate AND1(.x(c1),.y(c11),.z(a1));
 OR_gate OR1(.x(a1),.y(c10),.z(c2));
 
 four_bit_ra FRA20(.x(A[11:8]),.y(B[11:8]),.ci(0),.s(SumA[11:8]),.co(c20));
 four_bit_ra FRA21(.x(A[11:8]),.y(B[11:8]),.ci(1),.s(SumB[11:8]),.co(c21));
 two_one_mux M2(.x(SumA[11:8]),.y(SumB[11:8]),.ci(c2),.s(Sum[11:8]));
 AND_gate AND2(.x(c2),.y(c21),.z(a2));
 OR_gate OR2(.x(a2),.y(c20),.z(c3));
 
 four_bit_ra FRA30(.x(A[15:12]),.y(B[15:12]),.ci(0),.s(SumA[15:12]),.co(c30));
 four_bit_ra FRA31(.x(A[15:12]),.y(B[15:12]),.ci(1),.s(SumB[15:12]),.co(c31));
 two_one_mux M3(.x(SumA[15:12]),.y(SumB[15:12]),.ci(c3),.s(Sum[15:12]));
 AND_gate AND3(.x(c3),.y(c31),.z(a3));
 OR_gate OR3(.x(a3),.y(c30),.z(CO));
 
endmodule


module two_one_mux(input [3:0] x, y,input ci, output logic[3:0] s);
always_comb
begin
if(ci)
begin
s[0]=y[0];
s[1]=y[1];
s[2]=y[2];
s[3]=y[3];
end
else
begin
s[0]=x[0];
s[1]=x[1];
s[2]=x[2];
s[3]=x[3];
end
end
endmodule


/*  already difined
module four_bit_ra(input [3:0] x,y,input ci, output [3:0] s, output co);
logic c1,c2,c3;

full_adder FA0(.x(x[0]),.y(y[0]),.ci(ci),.s(s[0]),.co(c1));
full_adder FA1(.x(x[1]),.y(y[1]),.ci(c1),.s(s[1]),.co(c2));
full_adder FA2(.x(x[2]),.y(y[2]),.ci(c2),.s(s[2]),.co(c3));
full_adder FA3(.x(x[3]),.y(y[3]),.ci(c3),.s(s[3]),.co(co));

endmodule

module full_adder(input x,y,ci, output s,co);
assign s=x^y^ci;
assign c=(x&y)|(y&ci)|(x&ci);

endmodule
*/
module AND_gate(input x,y, output z);
assign z=x&y;

endmodule

module OR_gate(input x,y, output z);
assign z=x|y;

endmodule