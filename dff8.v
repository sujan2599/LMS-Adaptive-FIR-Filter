`timescale 1ns / 1ps

module dff8(Din,Q,clk,rst); 

    input signed  [7:0]Din;
    input clk,rst;
    output reg signed [7:0] Q;
    always@(posedge clk or posedge rst)
    begin
    if(rst)
    Q<=0;
    else
    Q<=Din;
    end
    
endmodule
