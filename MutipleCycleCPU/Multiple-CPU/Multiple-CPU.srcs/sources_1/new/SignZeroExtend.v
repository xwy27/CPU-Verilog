`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/21 16:07:07
// Design Name: 
// Module Name: SignZeroExtend
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
