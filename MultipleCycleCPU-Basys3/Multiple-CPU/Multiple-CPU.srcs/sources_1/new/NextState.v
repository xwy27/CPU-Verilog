`include "head.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/21 16:29:35
// Design Name: 
// Module Name: NextState
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


module NextState(clk, rst, stateIn, opCode, stateOut);
    input clk, rst;
    input [2:0] stateIn;
    input [5:0] opCode;
    output reg [2:0] stateOut;

    // 状态二进制码
    parameter [2:0] sIF = 3'b000;
    parameter [2:0] sID = 3'b001;
    parameter [2:0] sEXE = 3'b010;
    parameter [2:0] sWB = 3'b011;
    parameter [2:0] sMEM = 3'b100;

    always @(stateIn or opCode) begin
      if (rst) begin
        case (stateIn)
          sIF: stateOut = sID;
          sID: begin
              if (opCode == `opJ || opCode == `opJal || opCode == `opJr || opCode == `opHalt) stateOut = sIF;
              else if (opCode == `opAdd || opCode == `opSub || opCode == `opAddi || opCode == `opOr || opCode == `opAnd ||
              opCode == `opOri || opCode == `opSll || opCode == `opSlt || opCode == `opSltiu || opCode == `opBeq ||
              opCode == `opBltz || opCode == `opSw || opCode ==`opLw) stateOut = sEXE;
          end
          sEXE: begin
              if (opCode == `opAdd || opCode == `opSub || opCode == `opAddi || opCode == `opOr || opCode == `opAnd ||
                  opCode == `opOri || opCode == `opSll || opCode == `opSlt || opCode == `opSltiu) stateOut = sWB;
              else if (opCode == `opBeq || opCode == `opBltz) stateOut = sIF;
              else if (opCode == `opSw || opCode == `opLw) stateOut = sMEM;
          end
          sWB:   stateOut = sIF;
          sMEM: begin
              if (opCode == `opSw)    stateOut = sIF;
              else if (opCode == `opLw)   stateOut = sWB;
          end
          default: stateOut = sIF;
        endcase
      end else begin
        stateOut = sIF;
      end
    end
endmodule
