`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/27/2015 03:40:02 PM
// Design Name: 
// Module Name: ALU
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


module ALU #(parameter N=32) (
    input [N-1:0] A, B,
    input [4:0] ALUfn,
    output [N-1:0] R,
    output FlagZ
    );
    
    wire subtract, bool1, bool0, shft, math, compareResult;
    assign {subtract, bool1, bool0, shft, math} = ALUfn[4:0]; //seaparate ALUfn into named bits
    
    wire [N-1:0] addsubResult, shiftResult, logicalResult; //results from the three ALU components
    
    addsub #(N) AS(A, B, subtract, addsubResult, FlagN, FlagC, FlagV);
    shifter #(N) S(B, A[4:0], ~bool1, ~bool0, shiftResult);
    logical #(N) L(A, B, {bool1, bool0}, logicalResult);
    comparator C(FlagN, FlagV, FlagC, bool0, compareResult); 
    
    assign R =  (~shft & math) ? addsubResult :
                (shft & ~math) ? shiftResult : 
                (~shft & ~math) ? logicalResult : 
                {{(N-1){1'b0}}, compareResult};
                
    assign FlagZ = ~|R;
    
endmodule
