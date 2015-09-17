`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/27/2015 04:08:17 PM
// Design Name: 
// Module Name: comparator
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


module comparator(input FlagN, FlagV, FlagC, 
                  bool0, 
                  output comparison);
                  
       assign comparison = ~bool0 ? (FlagN ^ FlagV) : ~FlagC; 
endmodule
