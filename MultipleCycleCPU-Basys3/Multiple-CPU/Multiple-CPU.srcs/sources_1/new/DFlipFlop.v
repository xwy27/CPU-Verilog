`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/21 16:21:52
// Design Name: 
// Module Name: DFlipFlop
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DFlipFlop(stateIn, reset, clk, stateOut);
    input reset, clk;
    input [2:0] stateIn;
    output reg [2:0] stateOut;

    always @(posedge clk) begin
      if (!reset)    stateOut = 3'b000;
      else  stateOut = stateIn;
    end
endmodule
