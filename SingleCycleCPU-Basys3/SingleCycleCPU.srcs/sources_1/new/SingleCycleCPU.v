`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Sun Yat-Sen University
// Engineer: XWY
// 
// Create Date: 2018/05/17 16:20:29
// Module Name: SingleCycleCPU
// Project Name: SingleCPU
// Target Devices: Basys3
// Tool Versions: Vivado 2015.3
// Description: 单周期 CPU
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module SingleCycleCPU(
    input CLK,
    input Reset,
    output [4:0] Rs,
    output [4:0] Rt,
    output [31:0] CurPC,
    output [31:0] NextPC,
    output [31:0] InsOut,
    output [31:0] ReadData1,
    output [31:0] ReadData2,
    output [4:0] WriteReg,
    output [31:0] WriteData,
    output [31:0] Y,
    output [31:0] DataOut,
    output [31:0] Immediate
    // output Zero,
    // output Sign,
    // output [1:0] PCsrc,
    // output [31:0] A,
    // output [31:0] B
    );
    
    wire [1:0] PCSrc;
    wire [2:0] ALUOp;
    wire PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, InsMemRW, mRD, mWR, RegDst, ExtSel;
    wire Zero, Sign;
    wire [31:0] PC, IAddress, Extend, dataout, IDataIn, IDataOut, JPC, WriteData, y, readdata1, readdata2;
    wire [31:0] ExtSa, A, B;
    wire [15:0] Immediate;
    wire [25:0] address;
    wire [4:0] Rs, Rt, WriteReg;
    //wire [4:0] Rd, Sa;

    assign IDataIn = 0;

    // modules: 
    //      PC(CLK, Reset, PCWre, NextPC, IAddress);
    //
    //      InstructionMemory(InsMemRW, IAddress, IDataIn, IDataOut);
    //
    //      ControlUnit cu(OpCode, Zero, Sign, PCWre, ALUSrcA, ALUSrcB,
    //           DBDataSrc, RegWre, InsMemRW, mRD, mWR, RegDst, ExtSel, PCSrc, ALUOp);
    //
    //      Selector5(Select, A, B, Out) => Out = Select ? B : A;
    //
    //      RegisterFile(CLK, WE, Reset, ReadReg1, ReadReg2, WriteReg, WriteData, ReadData1, ReadData2);
    //
    //      Selector32(Select, A, B, Out) => Out = Select ? B : A;
    //
    //      SignZeroExtend(ExtSel, Sign, Immediate, Extend);
    //
    //      ALU(A, B, ALUop, Zero, Sign, Y);
    //
    //      JPC(PC, IAddress, JPC);
    //
    //      NextPC(Reset, PCSrc, PC, Immediate, JPC, NextPC);
    //
    //      DataMemory(CLK, mRD, mWR, DAddr, DataIn, DataOut);
    
    PC pc(.CLK(CLK), .Reset(Reset), .PCWre(PCWre), .NextPC(NextPC), .IAddress(IAddress));
    
    InstructionMemory insmem(.InsMemRW(InsMemRW), .IAddress(IAddress), .IDataIn(IDataIn), .IDataOut(IDataOut));
    
    ControlUnit cu(.OpCode(IDataOut[31:26]), .Zero(Zero), .Sign(Sign), .PCWre(PCWre), .ALUSrcA(ALUSrcA), .ALUSrcB(ALUSrcB), 
        .DBDataSrc(DBDataSrc), .RegWre(RegWre), .InsMemRW(InsMemRW), .mRD(mRD), .mWR(mWR), .RegDst(RegDst), .ExtSel(ExtSel),
        .PCSrc(PCSrc), .ALUOp(ALUOp));
    
    Selector5 selreg(.Select(RegDst), .A(IDataOut[20:16]), .B(IDataOut[15:11]), .Out(WriteReg));
    RegisterFile regfile(.CLK(CLK), .WE(RegWre), .Reset(Reset), .ReadReg1(IDataOut[25:21]), .ReadReg2(IDataOut[20:16]),
        .WriteReg(WriteReg), .WriteData(WriteData), .ReadData1(readdata1), .ReadData2(readdata2));
    
    assign ExtSa = {{17{0}}, IDataOut[10:6]};
    Selector32 selA(.Select(ALUSrcA), .A(readdata1), .B(ExtSa), .Out(A));
    SignZeroExtend extend(.ExtSel(ExtSel), .Sign(Sign), .Immediate(IDataOut[15:0]), .Extend(Extend));
    Selector32 selB(.Select(ALUSrcB), .A(readdata2), .B(Extend), .Out(B));
    ALU alu(.A(A), .B(B), .ALUop(ALUOp), .Zero(Zero), .Sign(Sign), .Y(y));

    JPC jump(.PC(IAddress), .IAddress(IDataOut[25:0]), .JPC(JPC));
    NextPC next(.Reset(Reset), .PCSrc(PCSrc), .PC(IAddress), .Immediate(Extend), .JPC(JPC), .NextPC(PC));

    DataMemory datamem(.CLK(CLK), .mRD(mRD), .mWR(mWR), .DAddr(y), .DataIn(readdata2), .DataOut(dataout));
    Selector32 seldata(.Select(DBDataSrc), .A(y), .B(dataout), .Out(WriteData));

    assign CurPC = IAddress;
    assign NextPC = PC;
    assign ReadData1 = readdata1;
    assign ReadData2 = readdata2;
    assign InsOut = IDataOut;
    assign Rs = IDataOut[25:21];
    assign Rt = IDataOut[20:16];
    assign Y = y;
    assign DataOut = dataout;
    assign Immediate = IDataOut[15:0];
    // assign Rd = IDataOut[15:11];
    // assign Sa = IDataOut[10:6];
    // assign A = A;
    // assign B = B;
    // assign PCsrc = PCSrc;
    // assign Zero = Zero;
    // assign Sign = Sign;
endmodule
