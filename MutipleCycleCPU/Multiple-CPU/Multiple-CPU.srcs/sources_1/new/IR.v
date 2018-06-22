`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/21 14:34:42
// Design Name: 
// Module Name: IR
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


module IR(clk, IRWre, dataIn, dataOut);
  input clk;
  input IRWre;
  input [31:0] dataIn;
  output reg [31:0] dataOut;

  always @(negedge clk) begin
    if (IRWre) begin
      dataOut <= dataIn;
    end
  end
endmodule
