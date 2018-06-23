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


module OuputControlSign(state, opcode, sign ,zero, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc,
    InsMemRW, mRD, mWR, IRWre, ExtSel, PCSrc, RegDst, ALUOp);
    input [2:0] state;
    input [5:0] opcode;
    input zero, sign;
    output reg PCWre, ALUSrcA, ALUSrcB, ExtSel, DBDataSrc, RegWre, WrRegDSrc, InsMemRW, mRD, mWR, IRWre;
    output reg [1:0] PCSrc, RegDst;
    output reg [2:0] ALUOp;

    always @(state or opcode or zero or sign) begin
      case (state)
        `sIF: begin
          RegWre = 0;
          mRD = 0;
          mWR = 0;
          PCWre = (opcode == `opHalt) ? 0 : 1;
          InsMemRW = 1;
          IRWre = 1;
        end
        
        `sID: begin
          InsMemRW = 0;
          PCWre = 0;
          IRWre = 0;
          RegWre = 0;
          mRD = 0;
          mWR = 0;
          WrRegDSrc = (opcode == `opJal) ? 0 : 1;
          ExtSel = (opcode == `opOri || opcode == `opSltiu) ? 0 : 1;
          //RegDst
          case(opcode)
            `opJal:
              RegDst = 2'b00;
            `opAddi, `opOri, `opSltiu, `opLw:
              RegDst = 2'b01;
            `opAdd, `opSub, `opOr, `opAnd, `opSll, `opSlt:
              RegDst = 2'b10;
            default: RegDst = 2'b11;
          endcase
          //PCSrc
          case(opcode)
            `opAdd, `opSub, `opAddi, `opOr, `opAnd, `opOri, 
            `opSll, `opSlt, `opSltiu, `opSw, `opLw:
              PCSrc = 2'b00;
            `opBeq:
              PCSrc = (zero) ? 2'b01 : 2'b00;
            `opBltz: begin 
              if (!sign && zero) begin
                PCSrc = 2'b00;
              end else if (!sign && zero) begin
                PCSrc = 2'b01;
              end
            end
            `opJ, `opJal:
              PCSrc = 2'b11;
            `opJr:
              PCSrc = 2'b10;
          endcase
        end

        `sEXE: begin
          IRWre = 0;
          RegWre = 0;
          mRD = 0;
          mWR = 0;
          PCWre = 0;
          ALUSrcA = (opcode == `opSlt) ? 1 : 0;
          ALUSrcB = (opcode == `opAddi || opcode == `opOri ||
            opcode == `opSltiu || opcode == `opSw || opcode == `opLw) ? 1 : 0;
          //ALUOp
          case(opcode)
            `opAdd, `opAddi:
              ALUOp = 3'b000;
            `opSub:
              ALUOp = 3'b001;
            `opOr, `opOri:
              ALUOp = 3'b101;
            `opAnd:
              ALUOp = 3'b110;
            `opSll:
              ALUOp = 3'b100;
            `opSlt:
              ALUOp = 3'b011;
            `opSltiu:
              ALUOp = 3'b010;
            `opBeq, `opBltz:
              ALUOp = 3'b111;
          endcase
          DBDataSrc = (opcode == `opLw) ? 1 : 0;
        end

        `sMEM: begin
          mRD = (opcode == `opLw) ? 1 : 0;
          mWR = (opcode == `opSw) ? 1 : 0;
        end
        
        `sWB: begin
          RegWre = (opcode == `opSw || opcode == `opBeq || opcode == `opBltz ||
            opcode == `opJ || opcode == `opJr || opcode == `opHalt) ? 0 : 1;
        end
      endcase
    end
endmodule
