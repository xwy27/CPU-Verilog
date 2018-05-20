`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Sun Yat-Sen University
// Engineer: XWY
// 
// Create Date: 2018/05/17 16:20:29
// Module Name: testCPU
// Project Name: SingleCPU
// Target Devices: Basys3
// Tool Versions: Vivado 2015.3
// Description: CPU 测试模块
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module testCPU();
    reg CLK;
    reg Reset;
    wire [4:0] Rs;
    wire [4:0] Rt;
    wire [31:0] CurPC;
    wire [31:0] NextPC;
    wire [31:0] InsOut;
    wire [31:0] ReadData1;
    wire [31:0] ReadData2;
    wire [4:0] WriteReg;
    wire [31:0] WriteData;
    wire [31:0] Immediate;
    // wire Zero;
    // wire Sign;
    // wire [1:0] PCsrc;
    // wire [31:0] A;
    // wire [31:0] B;
    // wire [31:0] Y;

    SingleCPU cpu(
        .CLK(CLK),
        .Reset(Reset),
        .Rs(Rs),
        .Rt(Rt),
        .CurPC(CurPC),
        .NextPC(NextPC),
        .InsOut(InsOut),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .WriteReg(WriteReg),
        .WriteData(WriteData),
        .Immediate(Immediate)
        // .Zero(Zero),
        // .Sign(Sign),
        // .PCsrc(PCsrc),
        // .Y(Y),
        // .A(A),
        // .B(B)
    );

    initial begin
        CLK = 0;
        Reset = 0;
        #50;
            CLK=1;
        #50;
            Reset=1;
        forever #50 begin
            CLK=~CLK;
        end
    end
endmodule