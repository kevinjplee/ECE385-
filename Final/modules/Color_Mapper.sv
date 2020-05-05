//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper ( input              [2:0]is_tile,            // Whether current pixel belongs to ball 
                                                              //   or background (computed in ball.sv)
                       input        [9:0] DrawX, DrawY,       // Current pixel coordinates
                       output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    
    logic [7:0] Red, Green, Blue;
    
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
    
    // Assign color based on is_ball signal
    always_comb
    begin
	 if(DrawX < 10'd420 && DrawY <10'd440 && DrawX > 10'd219 && DrawY > 10'd39)
	 begin
		  case(is_tile)
		  3'b0:
			begin
            Red = 8'h00;
            Green = 8'h00;
            Blue = 8'h00;
        end
		  3'd1:
		  begin
            Red = 8'h34; 
            Green = 8'hCC;
            Blue = 8'hFF;
        end
		  3'd2:
		  begin
            Red = 8'h03; 
            Green = 8'h41;
            Blue = 8'hAE;
        end
		  
		  3'd3:
		   begin
            Red = 8'hFF; 
            Green = 8'hD5;
            Blue = 8'h00;
        end
		  3'd4:
		    begin
            Red = 8'hFF; 
            Green = 8'hD5;
            Blue = 8'h00;
        end
		  3'd5:
		  begin
            Red = 8'h47; 
            Green = 8'hD1;
            Blue = 8'h47;
        end
		  3'd6:
		   begin
            Red = 8'h99; 
            Green = 8'h33;
            Blue = 8'hFF;
        end
		  3'd7:
		   begin
            Red = 8'hFF; 
            Green = 8'h33;
            Blue = 8'h33;
        end
		  default:
		  begin
            Red = 8'h00;
            Green = 8'h00;
            Blue = 8'h00;
        end
		  endcase
		  
		  /*
        if (is_tile == 3'b0) 
        begin
            
            Red = 8'h00;
            Green = 8'h00;
            Blue = 8'h00;
        end
        else if(is_tile == 3'd1)
        begin
            Red = 8'h34; 
            Green = 8'hCC;
            Blue = 8'hFF;
        end
		  else if(is_tile == 3'd2)
        begin
            Red = 8'h03; 
            Green = 8'h41;
            Blue = 8'hAE;
        end
		  else if(is_tile == 3'd3)
        begin
            Red = 8'hFF; 
            Green = 8'h97;
            Blue = 8'h1C;
        end
		  else if(is_tile == 3'd4)
        begin
            Red = 8'hFF; 
            Green = 8'hD5;
            Blue = 8'h00;
        end
		  else if(is_tile == 3'd5)
        begin
            Red = 8'h47; 
            Green = 8'hD1;
            Blue = 8'h47;
        end
		  else if(is_tile == 3'd6)
        begin
            Red = 8'h99; 
            Green = 8'h33;
            Blue = 8'hFF;
        end
		  else
        begin
            Red = 8'hFF; 
            Green = 8'h33;
            Blue = 8'h33;
        end
		  */
	 end
	 else
		begin
            Red = 8'hFF; 
            Green = 8'hFF;
            Blue = 8'hFF;
        end 
    end 
    
endmodule
