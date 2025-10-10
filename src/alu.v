`timescale 1ns / 1ps

// ALU Module  Performs arithmetic and logical operations
module alu(
    input [31:0] a,           // Input operand A
    input [31:0] b,           // Input operand B
    input [3:0] alu_control,  // Operation selector
    output reg [31:0] result, // ALU result
    output zero               // Zero flag
);

    // ALU operation codes : will come back to be implemented
    localparam ALU_ADD  = 4'b0000;
    localparam ALU_SUB  = 4'b0001;

    // need to: Implement ALU operations
    always @(*) begin
        result = 32'd0;  // Default output
    end

    // need to: Implement zero flag
    assign zero = (result == 32'd0);

endmodule
