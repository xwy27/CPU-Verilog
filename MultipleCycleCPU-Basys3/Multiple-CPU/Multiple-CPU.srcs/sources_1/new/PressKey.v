`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/22 21:27:49
// Design Name: 
// Module Name: PressKey
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


module PressKey(
    input CLK,  //
    input Key,  //
    output Led  //
    );

    reg led = 1;
    always @(posedge CLK) begin
        if (!Key) begin
            led <= 0;
        end
        else begin
            led <= 1;
        end
    end

    assign Led = led;
endmodule
