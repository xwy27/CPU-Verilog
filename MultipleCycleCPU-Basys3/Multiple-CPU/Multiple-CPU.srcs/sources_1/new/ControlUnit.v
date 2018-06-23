`include "head.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/21 19:33:01
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(opCode, clk, rst, sign, zero, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc,
    InsMemRW, mRD, mWR, IRWre, ExtSel, PCSrc, RegDst, ALUOp, State);
    
    input [5:0] opCode;
    input sign, zero, clk, rst;
    output reg PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRW, mRD, mWR, ExtSel, IRWre;
    output reg [1:0] PCSrc, RegDst;
    output reg [2:0] ALUOp;
    output reg [2:0] State;

    // wire [2:0] stateIn, stateOut;

    // DFlipFlop dflipflop(stateIn, rst, clk, stateOut);
    // NextState nextstate(clk, rst, stateOut, opCode, stateIn);
    // OuputControlSign out(stateOut, opCode, sign ,zero, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc,
    //     InsMemRW, mRD, mWR, IRWre, ExtSel, PCSrc, RegDst, ALUOp);
    
    // assign State = stateIn;
    
    initial begin
      State = 3'b000;
      PCWre = 1;
      ALUSrcA = 0;
      ALUSrcB = 0;
      DBDataSrc = 0;
      RegWre = 1;
      InsMemRW = 1;
      mRD = 1;
      mWR = 1;
      RegDst = 2'b10;
      ExtSel = 0;
      PCSrc = 2'b00;
      ALUOp = 3'b000;
      IRWre = 0;
      WrRegDSrc = 1;
    end
    
    always @(posedge clk or negedge rst) begin
      if (!rst) begin
        State <= 3'b000;
      end
      else begin
        case (State)
          `sIF: State <= `sID;
          
          `sID: begin
              if (opCode == `opJ || opCode == `opJal || opCode == `opJr || opCode == `opHalt) State = `sIF;
              else  State <= `sEXE;
          end
          
          `sEXE: begin
              if (opCode == `opBeq || opCode == `opBltz) State <= `sIF;
              else if (opCode == `opSw || opCode == `opLw) State <= `sMEM;
              else  State <= `sWB;
          end
          
          `sMEM: begin
              if (opCode == `opSw)    State <= `sIF;
              else if (opCode == `opLw)   State <= `sWB;
          end
          
          `sWB:   State <= `sIF;
          
          default: State <= `sIF;
        endcase
      end
    end

    always @(rst or State or zero or sign or opCode) begin
      ALUSrcA = (State == `sEXE && opCode == `opSll) ? 1 : 0;
      
      ALUSrcB = (State == `sEXE && (opCode == `opAddi || opCode == `opOri ||
        opCode == `opSltiu || opCode == `opSw || opCode == `opLw)) ? 1 : 0;
      
      DBDataSrc = (opCode == `opLw) ? 1 : 0;

      mRD = (State == `sMEM && opCode == `opLw) ? 1 : 0;
      mWR = (State == `sMEM && opCode == `opSw) ? 1 : 0;

      ExtSel = (State == `sEXE && (opCode == `opOri || opCode == `opSltiu)) ? 0 : 1;

      if (State == `sID && opCode == `opJal)  RegDst = 2'b00;
      else if (State == `sWB && (opCode == `opAddi || opCode == `opOri || opCode == `opSltiu || opCode == `opLw)) RegDst = 2'b01;
      else  RegDst = 2'b10;

      WrRegDSrc = (State == `sID && opCode == `opJal) ? 0 : 1;

      RegWre = ((State == `sID && opCode == `opJal) || State == `sWB) ? 1 : 0;

      IRWre = (State == `sIF) ? 1 : 0;

      if ((State == `sID) && (opCode == `opJr)) PCSrc = 2'b10;
      else if ((State == `sID) && (opCode == `opJ || opCode == `opJal)) PCSrc = 2'b11;
      else if (State == `sEXE && ((opCode == `opBeq && zero) || (opCode == `opBltz && sign && !zero)))  PCSrc = 2'b01;
      else  PCSrc = 2'b00;

      // if (opCode == `opHalt)  PCWre = 0;

      case(opCode)
        `opSub, `opBeq, `opBltz:
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
        default:
          ALUOp = 3'b000;
      endcase
    end

    always @(negedge clk) begin
      case (State)
        `sID: begin
          if (opCode == `opJ || opCode == `opJal || opCode == `opJr)  PCWre <= 1;
        end

        `sEXE: begin
          if (opCode == `opBeq || opCode == `opBltz)  PCWre <= 1;
        end
        
        `sMEM: begin
          if (opCode == `opSw)  PCWre <= 1;
        end
        
        `sWB: PCWre <= 1;
        
        default:  PCWre <= 0;
      endcase
    end
endmodule
