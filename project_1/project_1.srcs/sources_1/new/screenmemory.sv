`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2015 02:17:49 PM
// Design Name: 
// Module Name: screenmemory
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


module screenmemory #(
    parameter Abits = 11,
    parameter Dbits = 2,
    parameter Nloc = 1200
    )(
    input clock,
    input wr,
    input [Dbits-1 : 0] writedata,
    input [Abits-1 : 0] memmapaddr,
    input [Abits-1 : 0] vgaaddr,
    output [Dbits-1 : 0] vga_readdata,
    output [Dbits-1 : 0] memmap_readdata
    );
    
    reg [Dbits-1:0] rf[Nloc-1:0];
    
    always_ff @(posedge clock)                               // Memory write: only when wr==1, and only at posedge clock
          if(wr)
             rf[memmapaddr] <= writedata;
    
    initial $readmemb("screen_data.txt", rf, 0, Nloc-1);
    
    assign vga_readdata = rf[vgaaddr];
    assign memmap_readdata = rf[memmapaddr];
endmodule
