`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/09/2015 08:14:14 PM
// Design Name: 
// Module Name: memIO
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


module memIO#(
   parameter Abits = 32,          // Number of bits in address
   parameter Dbits = 32,         // Number of bits in data
   parameter Nloc = 8,           // Number of memory locations
   parameter dmem_init = "sqr_dmem.txt",
   parameter scrmem_init = "screen_data.txt"
)(
    input clk,
    input mem_wr,
    input [31:0] data_addr,
    input [31:0] writedata,
    input [10:0] vga_addr,
    output [1:0] vga_readdata,
    output [31:0] readdata 
    );
    
    wire [31:0] dmem_readdata;
    wire [1:0] memmap_readdata;
    wire [31:0] chosen_addr;
    wire screenmem_enable, dmem_enable;
    
    mem_mapper memmap(mem_wr, data_addr, dmem_readdata, memmap_readdata, readdata, chosen_addr, screenmem_enable, dmem_enable);
    
    screenmemory screenmem(clk, screenmem_enable, writedata, chosen_addr, vga_addr, vga_readdata, memmap_readdata);
    
    dmem #(32, 32, 32, dmem_init) dmem(clk, dmem_enable, chosen_addr, writedata, dmem_readdata);
    
endmodule
