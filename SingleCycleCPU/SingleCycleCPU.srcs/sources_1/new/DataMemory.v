`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Sun Yat-Sen University
// Engineer: XWY
// 
// Create Date: 2018/05/17 16:20:29
// Module Name: DataMemory
// Project Name: SingleCPU
// Target Devices: Basys3
// Tool Versions: Vivado 2015.3
// Description: (模拟)内存，用于存储数据
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module DataMemory(
    input CLK,              // 时钟输入
    input mRD,              // 读数据使能输入
    input mWR,              // 写数据使能输入
    input [31:0] DAddr,     // 数据内存地址
    input [31:0] DataIn,    // 输入数据
    output [31:0] DataOut          // 输出数据
    );
    
    // 8位一字节，模拟内存
    // 采用大端模式存储数据
    reg [7:0] memory[0:127];
    
    // 初始化内存
    integer i;
    initial begin
        for (i = 0; i < 128; i = i + 1) begin
            memory[i] = 0;
        end
    end
    
    // 读数据
    assign DataOut[7:0] = (mRD) ? memory[DAddr + 3] : 8'bz; 
    assign DataOut[15:8] = (mRD) ? memory[DAddr + 2] : 8'bz;
    assign DataOut[23:16] = (mRD) ? memory[DAddr + 1] : 8'bz;
    assign DataOut[31:24] = (mRD) ? memory[DAddr] : 8'bz;
    
    // 写数据
    always @(negedge CLK) begin
        if (mWR) begin
            memory[DAddr] <= DataIn[31:24];
            memory[DAddr + 1] <= DataIn[23:16];
            memory[DAddr + 2] <= DataIn[15:8];
            memory[DAddr + 3] <= DataIn[7:0];
        end
    end
endmodule
