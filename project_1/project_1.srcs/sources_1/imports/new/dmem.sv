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


module dmem #(
   parameter Abits = 32,          // Number of bits in address
   parameter Dbits = 32,         // Number of bits in data
   parameter Nloc = 8,           // Number of memory locations
   parameter InitFile
)(
   input clock,
   input wr,                                                // WriteEnable:  if wr==1, data is written into mem
   input [Abits-1 : 0] mem_addr,     // 3 addresses
   input [Dbits-1 : 0] mem_writedata,                           // Data for writing into register file (if wr==1)
   output [Dbits-1 : 0] mem_readdata                // 2 output ports
   );
   
   
   reg [Dbits-1:0] rf[Nloc-1:0];                                      // The actual registers where data is stored
   initial $readmemh(InitFile, rf, 0, Nloc-1);        // Data to initialize registers

   always_ff @(posedge clock)                               // Memory write: only when wr==1, and only at posedge clock
      if(wr)
         rf[mem_addr[Abits-1:2]] <= mem_writedata;

   // MODIFY the two lines below so if register 0 is being read, then the output
   // is 0 regardless of the actual value stored in register 0
   
   assign mem_readdata = (mem_addr == 0) ? 0 : rf[mem_addr[Abits-1:2]];   
   
endmodule