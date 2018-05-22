`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Sun Yat-Sen University
// Engineer: XWY
// 
// Create Date: 2018/05/17 16:20:29
// Module Name: RegisterFile
// Project Name: SingleCPU
// Target Devices: Basys3
// Tool Versions: Vivado 2015.3
// Description: 寄存器组，控制读写寄存器数据
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module RegisterFile(
    input CLK,                  // 时钟输入
    input WE,                   // 写使能信号
    input Reset,                // 重置信号
    input [4:0] ReadReg1,       // 读寄存器1地址
    input [4:0] ReadReg2,       // 读寄存器2地址
    input [4:0] WriteReg,       // 写寄存器地址
    input [31:0] WriteData,     // 写数据
    output [31:0] ReadData1,    // 读数据1
    output [31:0] ReadData2     // 读数据2
    );

    // 初始化寄存器的值
    // 0 号寄存器值恒为 0
    integer i;
    reg [31:0] Register[0:31];
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            Register[i] = 0;
        end
    end

    // 读寄存器
    assign ReadData1 = Register[ReadReg1];
    assign ReadData2 = Register[ReadReg2];

    // 写寄存器
    // 注意保护 0 号寄存器
    always @(negedge CLK) begin
        if (!Reset) begin
            for (i = 1; i < 32; i = i + 1) begin
                Register[i] = 0;
            end
        end
        else if (WE && WriteReg) begin
            Register[WriteReg] <= WriteData;
        end
    end
endmodule
