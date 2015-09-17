`timescale 1ns / 1ps

module xycounter #(parameter width = 2, height = 2) (
    input clock,
    input enable,
    output reg [$clog2(width)-1:0] x=0,
    output reg [$clog2(height)-1:0] y=0
    );
    
    always_ff @(posedge clock) begin
        if (enable)
        begin
            y <= (x != (width-1)) ? y : (y == (height-1)) ? 0 : (y+1);
            x <= (x != (width-1)) ? (x+1) : 0;
        end
    end
        
endmodule
