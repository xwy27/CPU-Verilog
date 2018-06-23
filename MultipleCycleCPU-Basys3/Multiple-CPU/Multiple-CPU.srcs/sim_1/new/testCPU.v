`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/22 10:41:42
// Design Name: 
// Module Name: testCPU
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


// module testCPU();
//     reg clk, rst;
//     wire [31:0] curpc, nextpc, idataout;
//     wire [31:0] readdata1, readdata2;
//     wire [4:0] rs, rt, rd;
//     wire [31:0] aluout, dataout;
//     wire [2:0] state;

//     MultipleCycleCPU cpu(clk, rst, state, curpc, nextpc, idataout,
//         readdata1, readdata2, rs, rt, rd, aluout, dataout);
    
//     initial begin
//         clk = 1;
//         rst = 0;
//         #25;
//         clk = 0;
//         #25;
//         begin 
//             rst=1;
//             clk=1;
//         end
//         forever #25 clk=~clk;
//     end
// endmodule
