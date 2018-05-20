`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Sun Yat-Sen University
// Engineer: XWY
// 
// Create Date: 2018/05/17 16:20:29
// Module Name: InstructionMemory
// Project Name: SingleCPU
// Target Devices: Basys3
// Tool Versions: Vivado 2015.3
// Description: 指令存储器
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module InstructionMemory(
    input InsMemRW,                 // 指令读写选择信号，1 为读，0 为写
    input [31:0] IAddress,          // 指令地址输入
    input [31:0] IDataIn,           // 指令寄存器输入数据
    output reg [31:0] IDataOut      // 指令存储器输出数据
    );

    // 8 位长的指令存储单元，共 128 个
    reg [7:0] Memory[0:127];

    initial begin
        $readmemb("C:/Users/43787/Desktop/Vivado/SingleCycleCPU/data/instructmemory.txt", Memory);
    end
    
    // 从地址取值后输出指令
    always @(IAddress or InsMemRW) begin
        if (InsMemRW) begin
            IDataOut[31:24] = Memory[IAddress];
            IDataOut[23:16] = Memory[IAddress + 1];
            IDataOut[15:8] = Memory[IAddress + 2];
            IDataOut[7:0] = Memory[IAddress + 3];
        end
    end
endmodule
