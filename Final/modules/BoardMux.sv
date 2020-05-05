module BoardMux(
    input logic[2:0] A[219:0], 
    input logic[2:0] B[219:0],
    input logic Select,
    output logic[2:0] out[219:0]
);
    always_comb begin
        if(Select==1'b0)    begin
            for(int i=0;i<220;i++)  begin
                out[i] = A[i];
            end
        end        
        else begin
            for(int i=0;i<220;i++)  begin
                out[i] = B[i];
            end
        end
    end
endmodule