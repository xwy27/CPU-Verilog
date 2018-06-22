`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/21 14:54:39
// Design Name: 
// Module Name: selector_2to1
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


module selector_2to1(A, B, Sign, Out);
  input [31:0] A, B;
  input Sign;
  output reg [31:0] Out;
  always @(Sign or A or B) begin
    case (Sign)
      1'b0:  Out <= A;
      1'b1:  Out <= B;
      default:  Out <= 0;
    endcase
  end
endmodule
