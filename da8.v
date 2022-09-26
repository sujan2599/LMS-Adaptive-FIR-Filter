`timescale 1ns / 1ps

module da8 (clk,rst,x0,x1,x2,x3,h0,h1,h2,h3,filter_out);
	
	input clk,rst;
    wire [79:0]yy;   
    reg signed [18:0] y_out;  // filter output 
    input signed [7:0] x0,x1,x2,x3;   //input data 
	input signed [7:0] h0,h1,h2,h3;  // filter co-efficients
	integer i;
	output signed [9:0] filter_out;
	 
	 ////////////////////////////////////////
	 /////assigning address - ROM contents///
	 ////////////////////////////////////////
	 
	 wire	[3:0]	lut_addr [0:7]  ;
	 
	 assign	lut_addr[0]  = {x3[0],x2[0], x1[0], x0[0]};
     assign	lut_addr[1]  = {x3[1],x2[1], x1[1], x0[1]};
     assign	lut_addr[2]  = {x3[2],x2[2], x1[2], x0[2]};
     assign	lut_addr[3]  = {x3[3],x2[3], x1[3], x0[3]};
     assign	lut_addr[4]  = {x3[4],x2[4], x1[4], x0[4]};
     assign	lut_addr[5]  = {x3[5],x2[5], x1[5], x0[5]};
     assign	lut_addr[6]  = {x3[6],x2[6], x1[6], x0[6]};
     assign lut_addr[7]  = {x3[7],x2[7], x1[7], x0[7]};
   
      reg signed  [9:0]	C_out [0:7];
	 
	 always @(lut_addr)
        begin
            for (i=0 ; i<8 ; i=i+1 )
              begin
                case(lut_addr[i])
                4'b0000:	C_out[i] = 0;
                4'b0001:	C_out[i] = h0;	
                4'b0010:	C_out[i] = h1;
                4'b0011:	C_out[i] = h1+h0;
                4'b0100:	C_out[i] = h2;
                4'b0101:	C_out[i] = h2+h0;
                4'b0110:	C_out[i] = h2+h1;
                4'b0111:	C_out[i] = h2+h1+h0;
                4'b1000:	C_out[i] = h3;
                4'b1001:	C_out[i] = h3+h0;
                4'b1010:	C_out[i] = h3+h1;
                4'b1011:	C_out[i] = h3+h1+h0;
                4'b1100:	C_out[i] = h3+h2;
                4'b1101:	C_out[i] = h3+h2+h0;
                4'b1110:	C_out[i] = h3+h2+h1;
                4'b1111:	C_out[i] = h3+h2+h1+h0;
                default:    C_out[i] = 0;
                endcase
                if( i == 7 )
                 C_out[7] = -C_out[7];
            end
        end

	 assign yy = {C_out[7],C_out[6],C_out[5],C_out[4],C_out[3],C_out[2],C_out[1],C_out[0]};
    
    ///////////////////////////////////
    /// shift accumulation process/////
    ///////////////////////////////////	 
    
	 always @ (posedge clk or posedge rst)
	 begin
	      if(rst)
	       y_out <= 0;
	      else
	        begin  
	          y_out = 0;
              for(i=10;i<81;i=i+10)
                 begin
                   case(i) 
	                  10: begin
	                       y_out = (({yy[10-1:10-10],8'b0})+y_out) ;
	                       y_out = y_out >>> 1;
	                     end  
	                  
	                  20: begin
	                       y_out = (({yy[20-1:20-10],8'b0000000000})+y_out) ;
	                       y_out = y_out >>> 1;
	                      end  
	                  
	                  30: begin
	                        y_out = (({yy[30-1:30-10],8'b0000000000})+y_out) ;
	                        y_out = y_out >>> 1;
	                      end  
	                  
	                  40: begin
	                        y_out = (({yy[40-1:40-10],8'b0000000000})+y_out) ;
	                        y_out = y_out >>> 1;
	                      end  
	                  50: begin
	                       y_out = (({yy[50-1:50-10],8'b0000000000})+y_out) ;
	                       y_out = y_out >>> 1;
	                     end  
	                  
	                  60: begin
	                       y_out = (({yy[60-1:60-10],8'b0000000000})+y_out) ;
	                       y_out = y_out >>> 1;
	                      end  
	                  
	                  70: begin
	                        y_out = (({yy[70-1:70-10],8'b0000000000})+y_out) ;
	                        y_out = y_out >>> 1;
	                      end  
	                  
	                  80: begin
	                        y_out = (({yy[80-1:80-10],8'b0000000000})+y_out) ;
	                        y_out = y_out >>> 1;
	                      end
	                  default: y_out<= 0;
	               endcase
	             end
	        end
	  end     
	  
    assign filter_out = y_out[9:0];
    
endmodule
