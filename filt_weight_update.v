`timescale 1ns / 1ps

module filt_weight_update( clk,rst,xd0,xd1,xd2,xd3,hn0,hn1,hn2,hn3, errr);

    input signed [9:0] errr;
    input clk,rst;
    input signed [7:0] xd0, xd1, xd2, xd3;
    output reg signed [7:0] hn0, hn1, hn2, hn3;
    
    always@( posedge clk or posedge rst)
    begin
    if(rst)
        begin
         hn0 <= 8'd1;
         hn1 <= 8'd1;
         hn2 <= 8'd1;
         hn3 <= 8'd1;
        end
     else
        begin
         hn0 <= hn0 + (((errr*xd0)>>>4) - ((errr*xd0)>>>6));
         hn1 <= hn1 + (((errr*xd1)>>>4) - ((errr*xd1)>>>6));
         hn2 <= hn2 + (((errr*xd2)>>>4) - ((errr*xd2)>>>6));
         hn3 <= hn3 + (((errr*xd3)>>>4) - ((errr*xd3)>>>6));
        end
    end

endmodule
