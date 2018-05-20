`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Sun Yat-Sen University
// Engineer: XWY
// 
// Create Date: 2018/05/17 16:20:29
// Module Name: SignZeroExtend
// Project Name: SingleCPU
// Target Devices: Basys3
// Tool Versions: Vivado 2015.3
// Description: 拓展器, 对立即数进行符号位拓展或零拓展
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module SignZeroExtend(
    input ExtSel,               // 拓展选择信号，为 0 则全补 0，否则进行符号位拓展
    input Sign,                 // 符号位
    input [15:0] Immediate,     // 16位立即数
    output [31:0] Extend        // 拓展输出
    );
    
    // 拓展立即数
    assign Extend[15:0] = Immediate[15:0];
    assign Extend[31:16] = (ExtSel && Immediate[15]) ? 16'hFFFF : 16'h0000;
endmodule
