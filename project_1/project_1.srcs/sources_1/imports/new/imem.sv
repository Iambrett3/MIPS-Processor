`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2015 02:06:31 PM
// Design Name: 
// Module Name: imem
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


module imem #(
   parameter Abits = 32,          // Number of bits in address
   parameter Dbits = 32,         // Number of bits in data
   parameter Nloc = 8,           // Number of memory locations
   parameter InitFile = "sqr_imem.txt"
)(
   input [Abits-1:0] pc,
   output [Dbits-1:0] instr
   );
   
   
   reg [Dbits-1:0] rf[Nloc-1:0];                       // The actual registers where data is stored
   initial $readmemh(InitFile, rf, 0, Nloc-1);        // Data to initialize registers

   assign instr = rf[pc[Abits-1 : 2]];
   
endmodule

