`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Sun Yat-Sen University
// Engineer: XWY
// 
// Create Date: 2018/05/17 16:20:29
// Module Name: PC
// Project Name: SingleCPU
// Target Devices: Basys3
// Tool Versions: Vivado 2015.3
// Description: 程序计数器，改变指令地址
//
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module PC(
    input CLK,                  // 时钟输入
    input Reset,                // 重置信号
    input PCWre,                // PC 更改信号，为 0 时不更改
    input [31:0] NextPC,        // 新指令
    output reg [31:0] IAddress      // 输出指令地址
    );
    
    // 初始化
    initial begin
        IAddress = 0;
    end

    // 时钟上升沿或重置下降沿触发
    always @(posedge CLK or negedge Reset) begin
        if (!Reset) begin
            IAddress <= 32'hFFFFFFFC;   // 重置为-4
            //IAddress <= 0;   // 重置为-4
        end
        else if (PCWre || !NextPC) begin
            IAddress <= NextPC;
        end
    end
endmodule   // PC 

module JPC(
    input [31:0] PC,            // PC 地址
    input [25:0] IAddress,      // 跳转地址
    output reg [31:0] JPC       // 跳转 PC
    );

    wire [27:0] temp;
    assign temp = IAddress << 2;
    always @(PC or IAddress) begin
        JPC[31:28] = PC[31:28];
        JPC[27:2] = temp[27:2];
        JPC[1:0] = 0;
    end
endmodule   // Jump PC

module NextPC(
    input Reset,                // 重置信号
    input [1:0] PCSrc,          // 选择信号
    input [31:0] PC,            // PC 地址
    input [31:0] Immediate,     // 立即数
    input [31:0] JPC,           // 跳转 PC
    output reg [31:0] NextPC        // 下一条 PC
    );

    always @(Reset or PCSrc or PC or Immediate or JPC) begin
        if (!Reset) begin
            NextPC = PC + 4;
        end
        else begin
            case (PCSrc)
              2'b00: NextPC = PC + 4;
              2'b01: NextPC = PC + 4 + (Immediate << 2);
              2'b10: NextPC = JPC;
              default: NextPC = PC + 4;
            endcase
        end
    end
endmodule   // Next PC
