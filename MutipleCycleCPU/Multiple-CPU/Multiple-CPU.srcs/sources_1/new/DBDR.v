`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/21 14:34:42
// Design Name: 
// Module Name: DBDR
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


module DBDR(dataIn, clk, dataOut);
  input [31:0] dataIn;
  input clk;
  output reg [31:0] dataOut;

  always @(negedge clk) begin
    dataOut <= dataIn;
  end
endmodule
