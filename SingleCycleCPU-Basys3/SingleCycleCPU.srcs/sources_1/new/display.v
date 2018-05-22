`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/20 11:06:39
// Design Name: 
// Module Name: display
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


module display(
    input CLK190,                   // 时钟输入
    input Reset,                    // 重置信号
    input [15:0] Out,               // 显示数据
    output reg [3:0] AN,            // 数码管位选择信号
    output reg [6:0] DispCode       // 数码管亮灯选择信号
    );

    // 选位
    reg [1:0] selector;
    always @(posedge CLK190 or negedge Reset) begin
        if (!Reset) begin
            selector <= 0;
        end
        else begin
            selector <= selector + 1;
        end
    end

    // 选数
    reg [3:0] digits;
    always @(*) begin
        case (selector)
          0: digits = Out[3:0];
          1: digits = Out[7:4];
          2: digits = Out[11:8];
          3: digits = Out[15:12];
          default:  digits = Out[3:0];
        endcase
    end

    // 数码管信号
    always @(*) begin
        case (digits)
            // '0'-亮灯，'1'-熄灯
            4'h0: DispCode = 7'b0000001; //0
            4'h1: DispCode = 7'b1001111; //1
            4'h2: DispCode = 7'b0010010; //2
            4'h3: DispCode = 7'b0000110; //3
            4'h4: DispCode = 7'b1001100; //4
            4'h5: DispCode = 7'b0100100; //5
            4'h6: DispCode = 7'b0100000; //6
            4'h7: DispCode = 7'b0001111; //7
            4'h8: DispCode = 7'b0000000; //8
            4'h9: DispCode = 7'b0000100; //9
            4'hA: DispCode = 7'b0001000; //A
            4'hB: DispCode = 7'b1100000; //b
            4'hC: DispCode = 7'b0110001; //C
            4'hD: DispCode = 7'b1000010; //d
            4'hE: DispCode = 7'b0110000; //E
            4'hF: DispCode = 7'b0111000; //F
          default: DispCode = 7'b1111111;
        endcase
    end

    // 选数码管位
    wire [3:0] temp;
    assign temp = 4'b1111;
    always @(*) begin
        AN = 4'b1111;
        if (temp[selector]) begin
            AN[selector] = 0;
        end
    end
endmodule
