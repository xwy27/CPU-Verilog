`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/21 14:54:39
// Design Name: 
// Module Name: selector_3to1
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


module selector_3to1(A, B, C, Sign, Out);
  input [4:0] A, B, C;
  input [1:0] Sign;
  output reg [4:0] Out;
  always @(Sign or A or B or C) begin
    case (Sign)
      2'b00:  Out <= A;
      2'b01:  Out <= B;
      2'b10:  Out <= C;
      default:  Out <= 0;
    endcase
  end
endmodule
