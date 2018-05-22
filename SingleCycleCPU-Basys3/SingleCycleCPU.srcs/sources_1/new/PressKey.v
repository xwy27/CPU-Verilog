`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Sun Yat-Sen University
// Engineer: XWY
// 
// Create Date: 2018/05/17 16:20:29
// Module Name: PressKey
// Project Name: SingleCPU
// Target Devices: Basys3
// Tool Versions: Vivado 2015.3
// Description: 按键
//
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module PressKey(
    input CLK,  //
    input Key,  //
    output Led  //
    );

    reg led = 0;
    always @(posedge CLK) begin
        if (!Key) begin
            led <= 1;
        end
        else begin
            led <= 0;
        end
    end

    assign Led = led;
endmodule
