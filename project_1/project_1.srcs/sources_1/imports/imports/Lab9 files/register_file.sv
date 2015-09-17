`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 3/18/2015 
//
//////////////////////////////////////////////////////////////////////////////////

module register_file #(
   parameter Abits = 5,          // Number of bits in address
   parameter Dbits = 32,         // Number of bits in data
   parameter Nloc = 32           // Number of memory locations
)(
   input clock,
   input wr,                                                // WriteEnable:  if wr==1, data is written into mem
   input [Abits-1 : 0] ReadAddr1, ReadAddr2, WriteAddr,     // 3 addresses
   input [Dbits-1 : 0] WriteData,                           // Data for writing into register file (if wr==1)
   output [Dbits-1 : 0] ReadData1, ReadData2                // 2 output ports
   );
   
   
   reg [Dbits-1:0] rf[Nloc-1:0];                                      // The actual registers where data is stored
   initial $readmemh("mem_data.txt", rf, 0, Nloc-1);        // Data to initialize registers

   always_ff @(posedge clock)                               // Memory write: only when wr==1, and only at posedge clock
      if(wr)
         rf[WriteAddr] <= WriteData;

   // MODIFY the two lines below so if register 0 is being read, then the output
   // is 0 regardless of the actual value stored in register 0
   
   assign ReadData1 = (ReadAddr1 == 0) ? 0 : rf[ReadAddr1];                              // First output port
   assign ReadData2 = (ReadAddr2 == 0) ? 0 : rf[ReadAddr2];                             // Second output port
   
endmodule
