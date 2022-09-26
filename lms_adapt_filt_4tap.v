`timescale 1ns / 1ps

module lms_adapt_filt_4tap (clk,rst,xin,din,errr,filt_out);
                                    
    input signed [7:0] xin;
    input signed [9:0] din;
    input clk,rst;
    output signed [9:0] filt_out;
    output signed [9:0] errr;
            
    ///////////////////////////////////////////////////////////////
    wire signed [7:0] x[0:3] ,xd[0:3];
    wire signed [7:0] hn[0:3], h[0:3];
    wire signed [9:0] y_out0;
    
    shift_reg ad16(xin,clk,rst,x[0],x[1],x[2],x[3]);
    
    filt_weight_update co_eff( clk,rst,xd[0],xd[1],xd[2],xd[3],hn[0],hn[1],hn[2],hn[3], errr);
    
    da8 block0(clk,rst,x[0],x[1],x[2],x[3],hn[0],hn[1],hn[2],hn[3],y_out0);
    
    dff8 D0(x[0],xd[0],clk,rst);
    dff8 D1(x[1],xd[1],clk,rst);
    dff8 D2(x[2],xd[2],clk,rst);
    dff8 D3(x[3],xd[3],clk,rst);
    
    assign filt_out = y_out0;
    assign errr = din - filt_out;
    
endmodule






