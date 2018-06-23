`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/21 14:34:42
// Design Name: 
// Module Name: ADR
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


module ADR(dataIn, clk, dataOut);
  input clk;
  input [31:0] dataIn;
  output reg [31:0] dataOut;

  always @(negedge clk) begin
    dataOut <= dataIn;
  end
endmodule
