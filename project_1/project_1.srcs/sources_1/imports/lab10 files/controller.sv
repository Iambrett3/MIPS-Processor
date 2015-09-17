`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 3/26/2015 
//
//////////////////////////////////////////////////////////////////////////////////

// These are non-R-type, so check op code
`define LW     6'b 100011
`define SW     6'b 101011
`define ADDI   6'b 001000
`define SLTI   6'b 001010
`define ORI    6'b 001101
`define BEQ    6'b 000100
`define BNE    6'b 000101
`define J      6'b 000010
`define JAL    6'b 000011
`define LUI    6'b 001111
`define ADDIU  6'b 001001

// These are all R-type, i.e., op=0, so check the func field
`define ADD    6'b 100000
`define SUB    6'b 100010
`define AND    6'b 100100
`define OR     6'b 100101
`define XOR    6'b 100110
`define NOR    6'b 100111
`define SLT    6'b 101010
`define SLTU   6'b 101011
`define SLL    6'b 000000
`define SRL    6'b 000010
`define SRA    6'b 000011
`define JR     6'b 001000  


module controller(
   input  [5:0] op, 
   input  [5:0] func,
   input  Z,
   output [1:0] pcsel,
   output [1:0] wasel, 
   output sext,
   output bsel,
   output [1:0] wdsel, 
   output reg [4:0] alufn,
   output wr,
   output werf, 
   output [1:0] asel
   ); 

  assign pcsel = ((op == 6'b0) & (func == `JR)) ? 2'b11   // controls 4-way multiplexor
               : (((op == `BEQ) & Z) | ((op == `BNE) & ~Z)) ? 2'b01
               : ((op == `J) | (op == `JAL)) ? 2'b10
               : 2'b00;

  reg [9:0] controls;
  assign {werf, wdsel[1:0], wasel[1:0], asel[1:0], bsel, sext, wr} = controls[9:0];

  always_comb
     case(op)                                     // non-R-type instructions
       `LW: controls <= 10'b1_10_01_00_1_1_0;     // LW
       `SW: controls <= 10'b0_00_01_00_1_1_1;     // SW
       `ADDI, `ADDIU,                                // ADDI, ADDIU
       `SLTI: controls <= 10'b1_01_01_00_1_1_0;     // SLTI
       `ORI: controls <= 10'b1_01_01_00_1_0_0;       // ORI
       `LUI: controls <= 10'b1_01_01_10_1_0_0;
       `J: controls   <= 10'b0_00_00_00_0_0_0;
       `JAL: controls <= 10'b1_00_10_00_0_0_0;
       `BEQ,
       `BNE: controls <= 10'b0_00_00_00_0_1_0;
       
      6'b000000:                                    
         case(func)                              // R-type
             `SUB, `AND, `OR, `XOR, `NOR, `SLT, `SLTU,
             `ADD: controls <= 10'b1_01_00_00_0_x_0;
             `SLL, `SRL, `SRA: controls <= 10'b1_01_00_01_0_x_0;
             `JR: controls <= 10'b0_00_00_00_0_x_0;
            default:   controls <=10'b 0_00_00_00_0_0_0;
         endcase
      default: controls <= 10'b0_00_00_00_0_0_0;
    endcase
    

  always_comb
    case(op)                        // non-R-type instructions
      `LW,                          // LW
      `SW,                          // SW
      `ADDIU,
      `ADDI: alufn <= 5'b0xx01;      // ADDI
      `ORI: alufn <= 5'bx0100;
      `SLTI: alufn <= 5'b1x011;      // SLTI
      `BEQ,                          // BEQ
      `BNE: alufn <= 5'b1xx01;       // BNE
      6'b000000:                      
         case(func)                 // R-type
             `ADD: alufn <=  5'b0xx01; // ADD
             `SUB: alufn <=  5'b1xx01; // SUB
             `AND: alufn <=  5'bx0000;
             `OR: alufn <=   5'bx0100;
             `XOR: alufn <=  5'bx1000;
             `NOR: alufn <=  5'bx1100;
             `SLT: alufn <=  5'b1x011;
             `SLTU: alufn <= 5'b1x111;
             `SLL: alufn <=  5'b10010;
             `SRL: alufn <=  5'b11010;
             `SRA: alufn <=  5'b11110;
             `JR: alufn <=   5'bxxxxx;
            default:   alufn <= 5'bxxxxx; // ???
         endcase
      default: alufn <= 5'bxxxxx;          // J, JAL
    endcase
    
endmodule
