module Clear (
    input logic[2:0] gameboard[219:0],
    output logic[2:0] out[219:0],
	output logic cleared
);
//logic [2:0] temp1[219:0];
//logic [2:0] temp2[219:0];
//logic [2:0] temp3[219:0];
//logic [2:0] temp4[219:0];

logic [19:0] line_full;
//logic [19:0] line_full1;
//logic [19:0] line_full2;
//logic [19:0] line_full3;
//logic [19:0] line_full4;

int y;		//lowest full line
//assign out = temp4;

    always_comb begin
		cleared = 1'b0;
		y=0;
		for (int i=0;i<220;i++)	begin
				out[i] = gameboard[i];
		end
		//get lowest full line index and clear all full lines
		for(int i=0;i<20;i++)	begin
			if(line_full[i]==1'b1)	begin
				y=i+2;
				cleared = 1'b1;
				for(int j=0;j<10;j++)	begin
					out[y*10+j] = 3'b0;
				end
			end
		end
		//drop the above tiles down
		if(cleared)	begin
			for(int i=219;i>9;i--)	begin
				if(i<(y*10))	begin
					if(out[i]!=3'b0)	begin
						for(int a=1;a<22;a++)	begin
							if((i+10*a)<220)	begin
								if( out[i+10*a]!=3'b0 )	begin
									out[(a-1)*10+i] = out[i];
									out[i] = 3'b0;
									break;
								end
							end
							else	begin
								out[(a-1)*10+i] = out[i];
								out[i] = 3'b0;
								break;
							end
						end
					end
				end
			end
		end
    end



//	
//	for(int i = 0; i <20; i++)
//	begin
//		if(line_full[i] == 1'b1)
//		begin
//			for(int j = i; j >0; j--)
//			begin
//				out[(j+2)*10 +:10] = out[(j+1)*10 +:10];
//				for(int k = 20; k < 29; k++)
//				begin
//					out[k] = 3'b0;
//				end
//			end
//		end
//		else
//			begin
//				out[(i+2)*10 +:10] = gameboard[(i+2)*10 +: 10];
//			end
//		for(int i = 0; i<19; i++)
//		out[i] = gameboard[i];
//	end

//		y=0;
//		for(int i=0;i<20;i++)	begin
//			if(line_full[i]==1'b1)
//				y=i;
//		end
//		for(int i=30;i<220;i++)	begin
//			if(i<(y*10+10))
//				out[i] = gameboard[i-10];
//			else
//				out[i] = gameboard[i];
//		end
//		for(int j=0;j<10;j++)   begin
//            out[2*10+j] = 3'b000;
//      end
//end
	
//Lineclear lineclear(.din(gameboard), .flag(line_full), .dout(temp1), .flagout(line_full1));
//Lineclear lineclear1(.din(temp1), .flag(line_full1), .dout(temp2), .flagout(line_full2));
//Lineclear lineclear2(.din(temp2), .flag(line_full2), .dout(temp3), .flagout(line_full3));
//Lineclear lineclear3(.din(temp3), .flag(line_full3), .dout(temp4), .flagout(line_full4));
	
Linecheck line2(.line(gameboard[29:20]),.full(line_full[0]));
Linecheck line3(.line(gameboard[39:30]),.full(line_full[1]));
Linecheck line4(.line(gameboard[49:40]),.full(line_full[2]));
Linecheck line5(.line(gameboard[59:50]),.full(line_full[3]));
Linecheck line6(.line(gameboard[69:60]),.full(line_full[4]));
Linecheck line7(.line(gameboard[79:70]),.full(line_full[5]));
Linecheck line8(.line(gameboard[89:80]),.full(line_full[6]));
Linecheck line9(.line(gameboard[99:90]),.full(line_full[7]));
Linecheck line10(.line(gameboard[109:100]),.full(line_full[8]));
Linecheck line11(.line(gameboard[119:110]),.full(line_full[9]));
Linecheck line12(.line(gameboard[129:120]),.full(line_full[10]));
Linecheck line13(.line(gameboard[139:130]),.full(line_full[11]));
Linecheck line14(.line(gameboard[149:140]),.full(line_full[12]));
Linecheck line15(.line(gameboard[159:150]),.full(line_full[13]));
Linecheck line16(.line(gameboard[169:160]),.full(line_full[14]));
Linecheck line17(.line(gameboard[179:170]),.full(line_full[15]));
Linecheck line18(.line(gameboard[189:180]),.full(line_full[16]));
Linecheck line19(.line(gameboard[199:190]),.full(line_full[17]));
Linecheck line20(.line(gameboard[209:200]),.full(line_full[18]));
Linecheck line21(.line(gameboard[219:210]),.full(line_full[19]));

	
endmodule

module Lineclear(input logic[2:0] din[219:0],
					  input logic[19:0] flag,
					  output logic[2:0] dout[219:0],
					  output logic[19:0] flagout);
					  logic [4:0]a;
					  always_comb
					  begin
					   flagout = flag;
						//dout = din;
						for(int i=0;i<220;i++)	begin
							dout[i] = din[i];
						end
						for(int i = 0; i <20; i++)
						begin 
							if(flag[i] == 1'b1)
							begin
								flagout[i] = 1'b0;
								for(int j = 10; j < (i+3)*10 ; j++)
									begin
									dout[j] = din[j-10];
									end
								break;
							end
						end
					end
endmodule

module Linecheck(input logic[2:0] line[9:0],output logic full);
	always_comb	begin
		full = 1'b1;
		for(int j=0;j<10;j++)	begin
			if(line[j]==3'b0)
				full = 1'b0;
		end
	end
endmodule
