`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Sun Yat-Sen University
// Engineer: XWY
// 
// Create Date: 2018/05/17 16:20:29
// Module Name: Selector5
// Project Name: SingleCPU
// Target Devices: Basys3
// Tool Versions: Vivado 2015.3
// Description: 5线2选一选择器
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Selector5(
    input Select,
    input [4:0] A,
    input [4:0] B,
    output [4:0] Out
    );

    assign Out = Select ? B : A;
endmodule
