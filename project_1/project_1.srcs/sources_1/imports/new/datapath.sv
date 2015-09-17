`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2015 11:03:18 AM
// Design Name: 
// Module Name: datapath
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


module datapath #(
   parameter Nloc = 32,
   parameter Abits = 32,          // Number of bits in address
   parameter Dbits = 32         // Number of bits in data
)(
    input clk, reset,
    input [Dbits-1 : 0] instr,
    input [1:0] pcsel, wasel, wdsel, asel,
    input sext, bsel, werf,
    input [4:0] alufn,
    input [Dbits-1 : 0] mem_readdata,
    output [Abits-1 : 0] mem_addr,
    output [Abits-1 : 0] pc,
    output [Dbits-1 : 0] mem_writedata,
    output Z
    );
    
    wire [Dbits-1:0] BT, JT, ReadData1, ReadData2, reg_writedata, SextOut, signImm,
                     aluA, aluB, alu_result;
    wire [4 : 0] reg_writeaddr;
    
    reg [Abits-1 : 0] pcreg = 32'b00000000000000000000000000000000;
    
    assign mem_writedata = ReadData2;
    assign signImm = SextOut;
    assign JT = ReadData1;
    assign mem_addr = alu_result;
    assign pc = pcreg;
    
    always_ff @(posedge clk) begin    
        pcreg <= reset ? 0 :
              (pcsel == 2'b00) ? (pcreg + 3'b100) :
              (pcsel == 2'b01) ? BT :
              (pcsel == 2'b10) ? {pcreg[31:28], instr[25:0], 2'b00} : JT;
    end
    
    assign reg_writeaddr = (wasel == 2'b00) ? instr[15:11] :
                           (wasel == 2'b01) ? instr[20:16] :
                           5'b11111;
    
    assign SextOut = sext ? (instr[15] ? {16'b1111111111111111, instr[15:0]} : {16'b0000000000000000, instr[15:0]}) :
                     {16'b0000000000000000, instr[15:0]};
                     
    assign aluA = (asel == 2'b00) ? ReadData1 :
                  (asel == 2'b01) ? {27'b000000000000000000000000000, instr[10:6]} :
                  32'b00000000000000000000000000010000;
                  
    assign aluB = bsel ? SextOut : ReadData2;
    
    assign BT = (signImm<<2) + (pc+3'b100);
    
    assign reg_writedata = (wdsel == 2'b00) ? (pc+3'b100) :
                           (wdsel == 2'b01) ? alu_result :
                           mem_readdata;
    
    register_file regFile(clk, werf, instr[25:21], instr[20:16], reg_writeaddr, reg_writedata, ReadData1, ReadData2);
    
    ALU #(Dbits) myALU (aluA, aluB, alufn, alu_result, Z); 
endmodule
