`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/22 21:27:49
// Design Name: 
// Module Name: CLOCK
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


module CLOCK(
    input CLK,          // 时钟输入
    input Reset,        // 重置信号
    output CLK190      // 16 进制计数器
    );

    reg [25:0] temp;
    always @(posedge CLK or negedge Reset) begin
        if (!Reset) begin
            temp <= 0;
        end
        else begin
            temp <= temp + 1;
        end
    end

    assign CLK190 = temp[17];
endmodule
