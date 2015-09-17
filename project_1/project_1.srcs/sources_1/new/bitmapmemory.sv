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


module bitmapmemory #(
    parameter Abits = 10,
    parameter Dbits = 16,
    parameter Nloc = (256 * 4)
    )(
    input [Abits-1 : 0] bitmapaddr,
    output [Dbits-1 : 0] colorvalue
    );
    
    reg [Dbits-1:0] rf[Nloc-1:0];
    
    initial $readmemh("bitmap_data.txt", rf, 0, Nloc-1);
    
    assign colorvalue = rf[bitmapaddr];
endmodule
