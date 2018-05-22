`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/20 12:26:50
// Design Name: 
// Module Name: BasysSingleCycleCPU
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


module BasysSingleCycleCPU(
    input CLK,
    input Reset,
    input Key,
    input [1:0] Selector,
    output [3:0] an,
    output [6:0] DispCode
    );

    wire CLK190, Led;
    wire [4:0] Rs;
    wire [4:0] Rt;
    wire [4:0] WriteReg;
    wire [31:0] CurPC, NextPC, InsOut;
    wire [31:0] ReadData1, ReadData2;
    wire [31:0] WriteData, Immediate, Y, DataOut;
    wire [15:0] Out;

    CLOCK clk(.CLK(CLK), .Reset(Reset), .CLK190(CLK190));
    PressKey presskey(.CLK(CLK190), .Key(Key), .Led(Led));
    SingleCycleCPU cpu(.CLK(Led), .Reset(Reset), .Rs(Rs), .Rt(Rt), .CurPC(CurPC), .NextPC(NextPC),
        .InsOut(InsOut), .ReadData1(ReadData1), .ReadData2(ReadData2), .WriteReg(WriteReg),
        .WriteData(WriteData), .Y(Y), .DataOut(DataOut), .Immediate(Immediate));
    DispData data(.Selector(Selector), .PC(CurPC[7:0]), .NextPC(NextPC[7:0]), .Rs(Rs), .Rt(Rt),
        .ReadData1(ReadData1[7:0]), .ReadData2(ReadData2[7:0]), .Y(Y[7:0]), .DataOut(DataOut[7:0]), .Out(Out));
    display dis(.CLK190(CLK190), .Reset(Reset), .Out(Out), .AN(an), .DispCode(DispCode));
endmodule
