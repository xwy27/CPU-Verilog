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


module ControlUnit(opcode, clk, rst, sign, zero, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc,
    InsMemRW, mRD, mWR, IRWre, ExtSel, PCSrc, RegDst, ALUOp, State);
    
    input [5:0] opcode;
    input sign, zero, clk, rst;
    output reg PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRW, mRD, mWR, IRWre;
    output reg [1:0] ExtSel, PCSrc, RegDst;
    output reg [2:0] ALUOp;
    output [2:0] State;

    wire [2:0] stateIn, stateOut;

    DFlipFlop dflipflop(stateIn, rst, clk, stateOut);
    NextState nextstate(stateOut, opcode, stateIn);
    OuputControlSign out(stateOut, opcode, zero, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc,
        InsMemRW, mRD, mWR, IRWre, ExtSel, PCSrc, RegDst, ALUOp);

    assign State = stateIn;
endmodule
