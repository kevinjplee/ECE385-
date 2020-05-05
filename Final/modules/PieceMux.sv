module PieceMux(
    input logic [2:0]   A[15:0],B[15:0],C[15:0],D[15:0],
    input logic [5:0]   A_x,A_y,B_x,B_y,C_x,C_y,D_x,D_y,
    input logic [2:0]   A_type,B_type,C_type,D_type,
    input logic [3:0]   A_r,B_r,C_r,D_r,
    input logic [1:0]   Select,
    output logic [2:0]  out[15:0],
    output logic [5:0]  out_x,out_y,
    output logic [2:0]  out_type,
    output logic [3:0]  out_r
);
    always_comb begin
        if     (Select==2'b00)   begin
            for(int i=0;i<16;i++) begin
                out[i] = A[i];
            end
            out_x = A_x;
            out_y = A_y;
            out_type = A_type;
            out_r = A_r;
        end
        else if(Select==2'b01)   begin
            for(int i=0;i<16;i++) begin
                out[i] = B[i];
            end
            out_x = B_x;
            out_y = B_y;
            out_type = B_type;
            out_r = B_r;
        end
        else if(Select==2'b10)   begin
            for(int i=0;i<16;i++) begin
                out[i] = C[i];
            end
            out_x = C_x;
            out_y = C_y;
            out_type = C_type;
            out_r = C_r;
        end
        else    begin
            for(int i=0;i<16;i++) begin
                out[i] = D[i];
            end
            out_x = D_x;
            out_y = D_y;
            out_type = D_type;
            out_r = D_r;
        end
    end
endmodule