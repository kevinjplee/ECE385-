module Rotate(
    input logic [2:0] gameboard[219:0],
    input logic [2:0] piece[15:0],
    input logic [4:0] piece_x,piece_y,
    input logic [2:0] piece_type,
    input logic [3:0] piece_r,
    input logic clockwise,
    output logic [2:0]  out[15:0],
    output logic [4:0]  out_x,out_y,
    output logic [2:0]  out_type,
    output logic [3:0]  out_r
);
logic [2:0] temp[15:0];
int relative_x,relative_y,relative_x_new,relative_y_new,x_center,y_center,x_center_glob,y_center_glob,x_center_I,y_center_I;
int Offset_table_I[4][5][2];    //4 rotation index, 5 offset test, 2 values for data vector(x,y)
int Offset_table_JLSTZ[4][5][2];
logic havetile;
int offset_x,offset_y,board_x,board_y;
logic can_rotate;
//initialize var
assign x_center = 1;
assign y_center = 1;
assign x_center_glob = piece_x;
assign y_center_glob = piece_y;
//initialize tables
    assign    Offset_table_I[0][0][0]=0;
    assign    Offset_table_I[0][0][1]=0;
    assign    Offset_table_I[0][1][0]=0;
    assign    Offset_table_I[0][1][1]=0;
    assign    Offset_table_I[0][2][0]=0;
    assign    Offset_table_I[0][2][1]=0;
    assign    Offset_table_I[0][3][0]=0;
    assign    Offset_table_I[0][3][1]=0;
    assign    Offset_table_I[0][4][0]=0;
    assign    Offset_table_I[0][4][1]=0;
    assign    Offset_table_I[1][0][0]=1;
    assign    Offset_table_I[1][0][1]=0;
    assign    Offset_table_I[1][1][0]=0;
    assign    Offset_table_I[1][1][1]=0;
    assign    Offset_table_I[1][2][0]=-2;
    assign    Offset_table_I[1][2][1]=0;
    assign    Offset_table_I[1][3][0]=1;
    assign    Offset_table_I[1][3][1]=1;
    assign    Offset_table_I[1][4][0]=1;
    assign    Offset_table_I[1][4][1]=2;
    assign    Offset_table_I[2][0][0]=1;
    assign    Offset_table_I[2][0][1]=1;
    assign    Offset_table_I[2][1][0]=0;
    assign    Offset_table_I[2][1][1]=-1;
    assign    Offset_table_I[2][2][0]=-3;
    assign    Offset_table_I[2][2][1]=1;
    assign    Offset_table_I[2][3][0]=0;
    assign    Offset_table_I[2][3][1]=0;
    assign    Offset_table_I[2][4][0]=1;
    assign    Offset_table_I[2][4][1]=2;
    assign    Offset_table_I[3][0][0]=0;
    assign    Offset_table_I[3][0][1]=1;
    assign    Offset_table_I[3][1][0]=0;
    assign    Offset_table_I[3][1][1]=-1;
    assign    Offset_table_I[3][2][0]=-2;
    assign    Offset_table_I[3][2][1]=1;
    assign    Offset_table_I[3][3][0]=-1;
    assign    Offset_table_I[3][3][1]=1;
    assign    Offset_table_I[3][4][0]=1;
    assign    Offset_table_I[3][4][1]=3;
    assign    Offset_table_JLSTZ[0][0][0]=0;
    assign    Offset_table_JLSTZ[0][0][1]=0;
    assign    Offset_table_JLSTZ[0][1][0]=0;
    assign    Offset_table_JLSTZ[0][1][1]=0;
    assign    Offset_table_JLSTZ[0][2][0]=0;
    assign    Offset_table_JLSTZ[0][2][1]=0;
    assign    Offset_table_JLSTZ[0][3][0]=0;
    assign    Offset_table_JLSTZ[0][3][1]=0;
    assign    Offset_table_JLSTZ[0][4][0]=0;
    assign    Offset_table_JLSTZ[0][4][1]=0;
    assign    Offset_table_JLSTZ[1][0][0]=0;
    assign    Offset_table_JLSTZ[1][0][1]=0;
    assign    Offset_table_JLSTZ[1][1][0]=1;
    assign    Offset_table_JLSTZ[1][1][1]=0;
    assign    Offset_table_JLSTZ[1][2][0]=1;
    assign    Offset_table_JLSTZ[1][2][1]=1;
    assign    Offset_table_JLSTZ[1][3][0]=0;
    assign    Offset_table_JLSTZ[1][3][1]=-2;
    assign    Offset_table_JLSTZ[1][4][0]=1;
    assign    Offset_table_JLSTZ[1][4][1]=-2;
    assign    Offset_table_JLSTZ[2][0][0]=0;
    assign    Offset_table_JLSTZ[2][0][1]=0;
    assign    Offset_table_JLSTZ[2][1][0]=0;
    assign    Offset_table_JLSTZ[2][1][1]=0;
    assign    Offset_table_JLSTZ[2][2][0]=0;
    assign    Offset_table_JLSTZ[2][2][1]=0;
    assign    Offset_table_JLSTZ[2][3][0]=0;
    assign    Offset_table_JLSTZ[2][3][1]=0;
    assign    Offset_table_JLSTZ[2][4][0]=0;
    assign    Offset_table_JLSTZ[2][4][1]=0;
    assign    Offset_table_JLSTZ[3][0][0]=0;
    assign    Offset_table_JLSTZ[3][0][1]=0;
    assign    Offset_table_JLSTZ[3][1][0]=-1;
    assign    Offset_table_JLSTZ[3][1][1]=0;
    assign    Offset_table_JLSTZ[3][2][0]=-1;
    assign    Offset_table_JLSTZ[3][2][1]=1;
    assign    Offset_table_JLSTZ[3][3][0]=0;
    assign    Offset_table_JLSTZ[3][3][1]=-2;
    assign    Offset_table_JLSTZ[3][4][0]=-1;
    assign    Offset_table_JLSTZ[3][4][1]=-2;

always_comb begin
    //initialize temp and other var
    for(int i=0;i<16;i++)   begin
        temp[i] = 3'b0;
    end
	out_r[3:0]=4'b0;
    relative_x = 0;
    relative_y = 0;
    relative_x_new = 0;
    relative_y_new = 0;
    offset_x = 0;
    offset_y = 0;
    board_x = 0;
    board_y = 0;
    can_rotate = 1'b0;
    havetile = 1'b0;
    //update rotation index
    if(piece_r[1:0] == 2'b00)   begin
        if(~clockwise)  
            out_r[3:2] = 2'b11;
        else begin
            out_r[1:0] = 2'b01;
        end
    end
    else if(piece_r[1:0] == 2'b11)   begin
        if(~clockwise)  
            out_r[3:2] = 2'b10;
        else begin
            out_r[1:0] = 2'b00;
        end
    end
    else  if(piece_r[1:0] == 2'b01) begin
        if(~clockwise)  
            out_r[3:2] = 2'b00;
        else begin
            out_r[3:2] = 2'b10;
        end
    end
    else   begin
        if(~clockwise)  
            out_r[3:2] = 2'b01;
        else begin
            out_r[3:2] = 2'b11;
        end
    end
    //assign special rotated center value fo type 1 piece
    if(out_r[3:2] == 2'b00)   begin
        x_center_I = 1;
        y_center_I = 1;
    end
    else if (out_r[3:2] == 2'b01)    begin
        x_center_I = 2;
        y_center_I = 1;
    end
    else if (out_r[3:2] == 2'b10)    begin
        x_center_I = 2;
        y_center_I = 2;
    end
    else     begin
        x_center_I = 1;
        y_center_I = 2;
    end
    //rotate each tile and stored in temp   
        //x=i%width, y=i/width, i=y*width+x
    if(piece_type == 3'b001)    begin
        //temp[(relative_y_new+y_center_I)*4+(relative_x_new+x_center_I)]=piece_type;
        if(out_r[3:2] == 2'b0)   begin
            temp[4] = 3'b001;
            temp[5] = 3'b001;
            temp[6] = 3'b001;
            temp[7] = 3'b001;
        end
        else if (out_r[3:2] == 2'b01)    begin
            temp[2] = 3'b001;
            temp[6] = 3'b001;
            temp[10] = 3'b001;
            temp[14] = 3'b001;
        end
        else if (out_r[3:2] == 2'b10)    begin
            temp[8] = 3'b001;
            temp[9] = 3'b001;
            temp[10] = 3'b001;
            temp[11] = 3'b001;
        end
        else     begin
            temp[1] = 3'b001;
            temp[5] = 3'b001;
            temp[9] = 3'b001;
            temp[13] = 3'b001;
        end
    end
    else    begin
        for(int i=0;i<16;i++)   begin
            if( (piece[i] != 3'b0) && (piece[i] != 3'b100) )    begin       //do not rotate O
                relative_x =  i%4 - x_center;
                relative_y =  i/4 - y_center;
                if(clockwise)   begin
                    relative_x_new = -relative_y;
                    relative_y_new = relative_x;
                end
                else    begin
                    relative_x_new = relative_y;
                    relative_y_new = -relative_x;
                end
            end
            temp[(relative_y_new+y_center)*4+(relative_x_new+x_center)]=piece_type;
        end
    end
    //check offset
    for(int o=0;o<1;o++)    begin           //debug,origin : o<5
        havetile = 1'b0;
        if(piece_type != 3'b100)  begin
            if(piece_type == 3'b001)    begin
                offset_x = 0; //Offset_table_I[(out_r[1:0])][o][0]-Offset_table_I[(piece_r[3:2])][o][0];
                offset_y = 0; //Offset_table_I[(out_r[1:0])][o][1]-Offset_table_I[(piece_r[3:2])][o][1];
            end
            else    begin
                offset_x = Offset_table_JLSTZ[(out_r[1:0])][o][0]-Offset_table_JLSTZ[(piece_r[3:2])][o][0];
                offset_y = Offset_table_JLSTZ[(out_r[1:0])][o][1]-Offset_table_JLSTZ[(piece_r[3:2])][o][1];
            end
        end
        for(int i=0;i<16;i++)   begin
            if(temp[i] != 3'b0)    begin
                if(piece_type == 3'b001)    begin
                    board_x = (i%4)- x_center_I + offset_x + x_center_glob;
                    board_y = (i/4)- y_center_I + offset_y + y_center_glob;
                end
                else begin
                    board_x = (i%4)- x_center + offset_x + x_center_glob;
                    board_y = (i/4)- y_center + offset_y + y_center_glob;
                end
                if((board_y<0)||(board_y>21)||(board_x<0)||(board_x>9)||(gameboard[board_y*10+board_x]!=3'b0))
                    havetile = 1'b1;
            end
        end
        if(havetile == 1'b0)    begin
            can_rotate = 1'b1;
            if(piece_type == 3'b100)    begin   //it's O type, can't rotate
                can_rotate = 1'b0;
            end
            break;
        end
        else
            can_rotate = 1'b0;
    end
    //giving output
    if(can_rotate)  begin
        out_x = offset_x + piece_x;         //not sure if int can be casted to logic
        out_y = offset_y + piece_y;
        out_r[1:0] = out_r[3:2];
        for (int i = 0 ; i<16 ; i++) begin
            out[i] = temp[i];
        end
    end
    else    begin
        out_x = piece_x;
        out_y = piece_y;
        out_r[3:2] = piece_r[1:0];
        out_r[1:0] = piece_r[1:0];
        for (int i = 0 ; i<16 ; i++) begin
            out[i] = piece[i];
        end
    end
end

endmodule