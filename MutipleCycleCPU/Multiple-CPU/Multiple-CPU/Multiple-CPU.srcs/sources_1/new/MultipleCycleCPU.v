`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/22 09:26:20
// Design Name: 
// Module Name: MultipleCycleCPU
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


module MultipleCycleCPU(clk, rst, state, curpc, nextpc, readdata1, readdata2, rs, rt, aluout, dataout);
    input clk, rst;
    output [31:0] curpc, nextpc;
    output [31:0] readdata1, readdata2;
    output [4:0] rs, rt;
    output [31:0] aluout, dataout;
    output [2:0] state;

    wire Zero, Sign, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRW, mRD, mWR, IRWre, ExtSel;
    wire [1:0] PCSrc, RegDst;
    wire [2:0] ALUOp, State;
    wire [4:0] WriteReg;
    wire [31:0] nextPC, IAddr, jumpPC, IDataIn, IDataOut, InsOut;
    wire [31:0] extendOut, WriteData, ReadData1, ReadData2;
    wire [31:0] ADROut, BDROut, extendSa, A, B, Y, ALUOutDROut;
    wire [31:0] DataOut, DBDRDataIn, DBDRDataOut;

    parameter [4:0] tempReg = 5'b11111;

    PC pc(clk, rst, nextPC, PCWre, IAddr);
    InstructionMemory insmem(InsMemRW, IAddr, IDataIn, IDataOut);
    IR ir(clk, IRWre, IDataOut, InsOut);

    ControlUnit cu(InsOut[31:26], clk, rst, Sign, Zero, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc,
    InsMemRW, mRD, mWR, IRWre, ExtSel, PCSrc, RegDst, ALUOp, State);

    selector_3to1 writeReg(tempReg, InsOut[20: 16], InsOut[15: 11], RegDst, WriteReg);
    selector_2to1 writeData(IAddr + 4, DBDRDataOut, WrRegDSrc, WriteData);
    RegisterFile regfile(clk, RegWre, rst, InsOut[25:21], InsOut[20:16], WriteReg, WriteData, ReadData1, ReadData2);

    SignZeroExtend extend(ExtSel, Sign, InsOut[15:0], extendOut);
    JPC jpc(IAddr, InsOut[25:0], jumpPc);
    NextPC next(rst, PCSrc, IAddr, extendOut, ReadData1, jumpPC, nextPC);

    ADR adr(ReadData1, clk, ADROut);
    BDR bdr(ReadData2, clk, BDROut);

    assign extendSa = {{27{0}}, InsOut[10:6]};
    selector_2to1 selectA(ADROut, extendSa, ALUSrcA, A);
    selector_2to1 selectB(BDROut, extendOut, ALUSrcB, B);
    ALU alu(A, B, ALUOp, Zero, Sign, Y);
    ALUOutDR aluoutdr(Y, clk, ALUOutDROut);

    DataMemory datamem(clk, mRD, mWR, ALUOutDR, BDROut, DataOut);
    selector_2to1 selectDBData(Y, DataOut, DBDataSrc, DBDRDataIn);
    DBDR dbdr(DBDRDataIn, clk, DBDRDataOut);

    assign curpc = IAddr;
    assign nextpc = nextPC;
    assign readdata1 = ReadData1;
    assign readdata2 = ReadData2;
    assign rs = InsOut[25:21];
    assign rt = InsOut[20:16];
    assign aluout = Y;
    assign dataout = DataOut;
    assign state = State;
endmodule
