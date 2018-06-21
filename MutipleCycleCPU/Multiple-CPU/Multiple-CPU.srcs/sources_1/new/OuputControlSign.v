`include "head.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/21 17:34:42
// Design Name: 
// Module Name: OuputControlSign
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


module OuputControlSign(state, opcode, zero, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc,
    InsMemRW, mRD, mWR, IRWre, ExtSel, PCSrc, RegDst, ALUOp);
    input [2:0] state;
    input [5:0] opcode;
    input zero;
    output reg PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRW, mRD, mWR, IRWre;
    output reg [1:0] ExtSel, PCSrc, RegDst;
    output reg [2:0] ALUOp;
    
    always @(state) begin
      if (state == `sIF && opcode != `opHalt)   PCWre = 1;
      else PCWre = 0;
      
      if (opcode == `opSll) ALUSrcA = 1;
      else ALUSrcA = 0;
      
      if (opcode == `opAddi || opcode == `opOri || opcode == `opSltiu || opcode == `opLw || opcode == `opSw) ALUSrcB = 1;
      else ALUSrcB = 0;

      if (opcode == `opLw)  DBDataSrc = 1;
      else DBDataSrc = 0;

      if ()
    end
endmodule
