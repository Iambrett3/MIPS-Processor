`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/09/2015 08:30:07 PM
// Design Name: 
// Module Name: mem_mapper
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


module mem_mapper(
    input mem_wr,
    input [31:0] in_addr,
    input [31:0] dmem_readdata,
    input [1:0] screenmem_readdata,
    output [31:0] readdata,
    output [12:0] out_addr,
    output screenmem_enable,
    output dmem_enable
    );
    
    
    assign screenmem_enable = (in_addr[14:13] == 2'b01) ? 1'b1 : 1'b0;
    assign dmem_enable = (in_addr[14:13] == 2'b10) ? 1'b1 : 1'b0;
    
    assign readdata = (screenmem_enable) ? screenmem_readdata : dmem_enable;
    
    assign out_addr = in_addr[12:0];
    
endmodule
