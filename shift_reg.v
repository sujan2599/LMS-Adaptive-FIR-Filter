`timescale 1ns / 1ps

module shift_reg(xin,clk,rst,x0,x1,x2,x3);
    
    input signed [7:0] xin;
    input clk,rst;
    output reg signed [7:0] x0,x1,x2,x3;
    
    always@(posedge clk or posedge rst)
    if(rst)
    begin
        x3<=8'd0; 
        x2<=8'd0;
        x1<=8'd0;
        x0<=8'd0;
    end
    else
    begin
        x3<=x2; 
        x2<=x1;
        x1<=x0;
        x0<=xin;
    end
    
endmodule
