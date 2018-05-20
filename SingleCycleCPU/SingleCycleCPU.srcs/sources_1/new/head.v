`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Sun Yat-Sen University
// Engineer: XWY
// 
// Create Date: 2018/05/17 21:30:12
// Module Name: head
// Project Name: SingleCPU
// Target Devices: basys3
// Tool Versions: Vivado 2015.3
// Description: 常量头文件
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// 操作指令二进制码
`define opAdd 6'b000000
`define opAddi 6'b000001
`define opSub 6'b000010
`define opOri 6'b010000
`define opAnd 6'b010001
`define opOr 6'b010010
`define opSll 6'b011000
`define opSlti 6'b011011
`define opSw 6'b100110
`define opLw 6'b100111
`define opBeq 6'b110000
`define opBne 6'b110001
`define opJ 6'b111000
`define opHalt 6'b111111
