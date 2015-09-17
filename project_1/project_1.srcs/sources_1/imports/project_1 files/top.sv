`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 4/6/2015 
//
//////////////////////////////////////////////////////////////////////////////////

module top #(
    parameter imem_init="sqr_imem.txt",
    parameter dmem_init="sqr_dmem.txt",
    parameter scrmem_init="screen_data.txt",		// text file to initialize screen memory
    parameter bitmap_init="bitmap_data.txt"			// text file to initialize bitmap memory
)(
    input clk, reset,
    output [11:0] RGB,
    output hsync, vsync
);
   
   wire [31:0] pc, instr, mem_readdata, mem_writedata, mem_addr;
   wire [10:0] screenaddr;
   wire [1:0] charactercode;
   wire mem_wr;

   // Uncomment *only* one of the following two lines:
   //    when synthesizing, use the first line
   //    when simulating, get rid of the clock divider, and use the second line
   //
   clockdivider_Nexys4 clkdv(clk, clk100, clk50, clk25, clk12);
   //assign clk100=clk; assign clk50=clk; assign clk25=clk; assign clk12=clk;

   // For synthesis:  use an appropriate clock frequency(ies) below
   //   clk100 will work for only the most efficient designs (hardly anyone)
   //   clk50 or clk 25 should work for the vast majority
   //   clk12 should work for everyone!
   //
   // Use the same clock frequency for the MIPS and data memory/memIO modules
   // The vgadisplaydriver should keep the 100 MHz clock.
   // For example:

   mips mips(clk12, reset, instr, mem_readdata, pc, mem_wr, mem_addr, mem_writedata);
   imem #(32, 32, 32, imem_init) imem(pc[31:0], instr);
   memIO #(32, 32, 32, dmem_init, scrmem_init) memIO(clk12, mem_wr, mem_addr, mem_writedata, screenaddr, charactercode, mem_readdata);
   vgadisplaydriver #(bitmap_init) display(clk100, charactercode, RGB, hsync, vsync, screenaddr);

endmodule
