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
    //basic ALU operations fo rinital testing
    localparam ALU_ADD  = 4'b0000;  // Addition
    localparam ALU_SUB  = 4'b0001;  // Subtraction
    localparam ALU_AND  = 4'b0010;  // Bitwise AND
    localparam ALU_OR   = 4'b0011;  // Bitwise OR

    // need to: Implement ALU operations
    always @(*) begin
        case (alu_control)
            ALU_ADD:  result = a + b;
            ALU_SUB:  result = a - b;
            ALU_AND:  result = a & b;
            ALU_OR:   result = a | b;
            default:  result = 32'd0;
        endcase
    end
    // need to: Implement zero flag
    assign zero = (result == 32'd0);

endmodule
