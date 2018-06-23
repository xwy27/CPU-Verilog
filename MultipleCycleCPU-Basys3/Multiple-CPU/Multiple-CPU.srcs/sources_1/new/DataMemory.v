`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/21 16:13:38
// Design Name: 
// Module Name: DataMemory
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
