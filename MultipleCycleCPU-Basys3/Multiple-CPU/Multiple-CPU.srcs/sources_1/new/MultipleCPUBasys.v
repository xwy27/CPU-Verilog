`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/22 21:30:31
// Design Name: 
// Module Name: MultipleCPUBasys
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


module MultipleCPUBasys(
    input CLK,Reset,Key,
    input [2:0] Selector,
    output [6:0] a_to_g,
    output [3:0] an
    );

    wire CLK190,CLK3,Led;
    wire [31:0] ReadData1, ReadData2, curPC, Result,InsOut,nextPC;
    wire [4:0] Rs,Rt,Rd;
    wire [31:0] DataOut;
    wire [2:0] State;
    wire [15:0] Out;

    CLOCK myclock(.CLK(CLK),.Reset(Reset),.CLK190(CLK190));
    PressKey mykey(.CLK(CLK190),.Key(Key),.Led(Led));
    MultipleCycleCPU myCPU(.clk(Led),.rst(Reset),.state(State),.curpc(curPC),.nextpc(nextPC),.idataout(InsOut),.readdata1(ReadData1),.readdata2(ReadData2),.rs(Rs),.rt(Rt),.rd(Rd),.aluout(Result),.dataout(DataOut));
    DispData myshift(.Selector(Selector),.State(State),.PC(curPC[7:0]),.NextPC(nextPC[7:0]),.Rs(Rs),.Rt(Rt),.ReadData1(ReadData1[7:0]),.ReadData2(ReadData2[7:0]),.Y(Result[7:0]),.DataOut(DataOut[7:0]),.Out(Out));
    display mymux(.CLK190(CLK190),.Reset(Reset),.Out(Out),.AN(an),.DispCode(a_to_g));

endmodule