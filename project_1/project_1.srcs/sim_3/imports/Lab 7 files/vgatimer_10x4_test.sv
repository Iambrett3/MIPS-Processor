`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 2/17/2015 
//
//////////////////////////////////////////////////////////////////////////////////

module vgatimer_10x4_test();

   // Inputs
   reg clk;
   
   // Outputs
   wire hsync;
   wire vsync;
   wire activevideo;
   wire [3:0] x;
   wire [2:0] y;
 
   // Instantiate the Unit Under Test (UUT)
   vgatimer uut (.*);

   initial begin      // Generate clock
      clk = 1;
      forever
         #5 clk = ~clk;
   end
   
   initial begin
      #4000 $finish;
   end
      
   
   selfcheck c();
   wire ERROR_hsync = (hsync != c.hsync)? 1'bx : 1'b0;
   wire ERROR_vsync = (vsync != c.vsync)? 1'bx : 1'b0;
   wire ERROR_activevideo = (activevideo != c.activevideo)? 1'bx : 1'b0;
 
endmodule


module selfcheck();
   reg hsync, vsync, activevideo;
   initial begin
      fork
      #0000 {hsync, vsync, activevideo} <= 3'b111;
      #0390 {hsync, vsync, activevideo} <= 3'b110;
      #0430 {hsync, vsync, activevideo} <= 3'b010;
      #0510 {hsync, vsync, activevideo} <= 3'b110;
      #0550 {hsync, vsync, activevideo} <= 3'b111;
      #0950 {hsync, vsync, activevideo} <= 3'b110;
      #0990 {hsync, vsync, activevideo} <= 3'b010;
      #1070 {hsync, vsync, activevideo} <= 3'b110;
      #1110 {hsync, vsync, activevideo} <= 3'b111;
      #1510 {hsync, vsync, activevideo} <= 3'b110;
      #1550 {hsync, vsync, activevideo} <= 3'b010;
      #1630 {hsync, vsync, activevideo} <= 3'b110;
      #1670 {hsync, vsync, activevideo} <= 3'b111;
      #2070 {hsync, vsync, activevideo} <= 3'b110;
      #2110 {hsync, vsync, activevideo} <= 3'b010;
      #2190 {hsync, vsync, activevideo} <= 3'b110;
      #2670 {hsync, vsync, activevideo} <= 3'b010;
      #2750 {hsync, vsync, activevideo} <= 3'b110;
      #2790 {hsync, vsync, activevideo} <= 3'b100;
      #3230 {hsync, vsync, activevideo} <= 3'b000;
      #3310 {hsync, vsync, activevideo} <= 3'b100;
      #3350 {hsync, vsync, activevideo} <= 3'b110;
      #3790 {hsync, vsync, activevideo} <= 3'b010;
      #3870 {hsync, vsync, activevideo} <= 3'b110;
      #3910 {hsync, vsync, activevideo} <= 3'b111;
      join
   end
endmodule
