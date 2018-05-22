`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/20 12:12:28
// Design Name: 
// Module Name: DispData
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


module DispData(
    input [1:0] Selector,
    input [7:0] PC,
    input [7:0] NextPC,
    input [4:0] Rs,
    input [4:0] Rt,
    input [7:0] ReadData1,
    input [7:0] ReadData2,
    input [7:0] Y,
    input [7:0] DataOut,
    output [15:0] Out
    );

    reg [15:0] out;
    initial begin
        out <= 0;
    end

    always @(*) begin
        case (Selector)
            2'b00: begin
                out[15:8] = PC;
                out[7:0] = NextPC;
            end
            2'b01: begin
                out[15:12] = 0;
                out[12:8] = Rs;
                out[7:0] = ReadData1;
            end
            2'b10: begin
                out[15:12] = 0;
                out[12:8] = Rt;
                out[7:0] = ReadData2;
            end
            2'b11: begin
                out[15:8] = Y;
                out[7:0] = DataOut;
            end
        endcase
    end
    assign Out = out;
endmodule
