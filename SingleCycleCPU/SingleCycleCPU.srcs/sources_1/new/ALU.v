`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Sun Yat-Sen University
// Engineer: XWY
// 
// Create Date: 2018/05/17 16:20:29
// Module Name: ALU
// Project Name: SingleCPU
// Target Devices: Basys3
// Tool Versions: Vivado 2015.3
// Description: 算罗运算单元
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ALU(
    input [31:0] A,     // 左操作数
    input [31:0] B,     // 右操作数
    input [2:0] ALUop,  // ALU 控制选择
    output Zero,        // 运算结果标志，结果为0输出1，否则为0
    output Sign,        // 符号位
    output reg [31:0] Y     // 计算结果
    );
    
    always @(ALUop or A or B) begin
        case (ALUop)
            3'b000 : Y = (A + B);
            3'b001 : Y = (A - B);
            3'b010 : Y = (B << A);
            3'b011 : Y = (A | B);
            3'b100 : Y = (A & B);
            3'b101 : Y = (A < B) ? 1 : 0;
            3'b110 : Y = (((A < B) && (A[31] == B[31])) || ((A[31] && !B[31]))) ? 1 : 0;
            3'b111 : Y = (A ^ B);
            default : Y = 0;
        endcase
    end
    
    assign Zero = (Y == 0) ? 1 : 0;
    assign Sign = Y[31];
endmodule
