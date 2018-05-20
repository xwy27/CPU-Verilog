`include "head.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Sun Yat-Sen University
// Engineer: XWY
// 
// Create Date: 2018/05/17 21:30:12
// Module Name: ControlUnit
// Project Name: SingleCPU
// Target Devices: basys3
// Tool Versions: Vivado 2015.3
// Description: 控制单元
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ControlUnit(
    input [5:0] OpCode,     // 操作符
    input Zero,             // ALU 的 Zero 输出
    input Sign,             // ALU 的 Sign 输出
    output PCWre,           // PC 更改信号
    output ALUSrcA,         // ALU 左操作数选择信号
    output ALUSrcB,         // ALU 右操作数选择信号
    output DBDataSrc,       // 写入寄存器数据选择信号
    output RegWre,          // 寄存器组写使能信号
    output InsMemRW,        // 指令存储器读写信号
    output mRD,             // 内存读信号
    output mWR,             // 内存写信号
    output RegDst,          // 写寄存器组地址
    output ExtSel,          // 拓展方式选择信号
    output [1:0] PCSrc,     // 指令分支选择信号
    output [2:0] ALUOp      // ALU 功能选择信号
    );

    assign PCWre = (OpCode == `opHalt) ? 0 : 1;
    assign ALUSrcA = (OpCode == `opSll) ? 1 : 0;
    assign ALUSrcB = (OpCode == `opAddi || OpCode == `opOri || OpCode == `opSlti || OpCode == `opSw || OpCode == `opLw) ? 1 : 0;
    assign DBDataSrc = (OpCode == `opLw) ? 1 : 0;
    assign RegWre = (OpCode == `opSw || OpCode == `opBeq || OpCode == `opBne || OpCode == `opJ || OpCode == `opHalt) ? 0 : 1;
    assign InsMemRW = 1;
    assign mRD = (OpCode == `opLw) ? 1 : 0;
    assign mWR = (OpCode == `opSw) ? 1 : 0;
    assign RegDst = (OpCode == `opAdd || OpCode == `opSub || OpCode == `opAnd || OpCode == `opOr || OpCode == `opSll) ? 1 : 0;
    assign ExtSel = (OpCode == `opOri) ? 0 : 1;
    assign PCSrc[1] = (OpCode == `opJ || OpCode == `opHalt) ? 1 : 0;
    assign PCSrc[0] = ((OpCode == `opBeq && Zero) || (OpCode == `opBne && !Zero) || OpCode == `opHalt) ? 1 : 0;
    assign ALUOp[2] = (OpCode == `opAnd || OpCode == `opSlti) ? 1 : 0;
    assign ALUOp[1] = (OpCode == `opOri || OpCode == `opOr || OpCode == `opSll || OpCode == `opSlti || OpCode == `opJ) ? 1 : 0;
    assign ALUOp[0] = (OpCode == `opSub || OpCode == `opOr || OpCode == `opOri || OpCode == `opBeq || OpCode == `opBne) ? 1 : 0;
endmodule
