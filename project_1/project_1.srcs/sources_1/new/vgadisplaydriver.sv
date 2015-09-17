`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2015 02:13:17 PM
// Design Name: 
// Module Name: vgadisplaydriver
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
`include "display640x480.sv"

module vgadisplaydriver #(
  parameter bitmap_init = "bitmap_data.txt"
)(
    input clk,
    input [1:0] charactercode,
    output [11:0] RGB,
    output hsync,
    output vsync,
    output [10:0] screenaddr
    );
    
    wire [`xbits-1:0] x;
    wire [`ybits-1:0] y;
    wire activevideo;
    wire [9:0] bitmapaddr;
    wire [15:0] colorvalue;
    
    assign screenaddr = (x < 16 & y < 16) ? 11'b00000000001 
                      : (x < 32 & y < 16) ? 11'b00000000010
                      : (x < 48 & y < 16) ? 11'b00000000011
                      : 11'b00000000000;
                      
    assign bitmapaddr = (charactercode << 8) + (y[3:0] << 4) + (x[3:0]);
    
    assign RGB = (activevideo) ? colorvalue[11:0] : 12'b0;
    
    vgatimer myvgatimer(clk, hsync, vsync, activevideo, x, y);
    
   // screenmemory screen_mem(screenaddr, charactercode);
    bitmapmemory bitmap_mem(bitmapaddr, colorvalue);
    
endmodule
