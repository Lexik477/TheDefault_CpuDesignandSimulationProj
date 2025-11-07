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
    localparam ALU_ADD  = 4'b0000;  // addition
    localparam ALU_SUB  = 4'b0001;  // subtraction
    localparam ALU_AND  = 4'b0010;  // bitwise AND
    localparam ALU_OR   = 4'b0011;  // bitwise OR
    localparam ALU_XOR  = 4'b0100; // bitwise XOR
    localparam ALU_SLL  = 4'b0101; // shift Left Logical
    localparam ALU_SRL  = 4'b0110; // shift Right Logical
    localparam ALU_SRA  = 4'b0111; // shift Right Arithmetic
    localparam ALU_SLT  = 4'b1000;  // set Less Than (signed)
    localparam ALU_SLTU = 4'b1001; // set Less Than (unsigned)

    //  --> finished implementing alu op.
    always @(*) begin
        case (alu_control)
            ALU_ADD:  result = a + b;
            ALU_SUB:  result = a - b;
            ALU_AND:  result = a & b;
            ALU_OR:   result = a | b;
            ALU_XOR:  result = a ^ b;
            ALU_SLL:  result = a << b[4:0]; //shift in lower 5 bits
            ALU_SRL:  result = a >> b[4:0];
            ALU_SRA:  result = $signed(a) >>> b[4:0]; //arithmetic shift preserves sign
            ALU_SLT:  result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
            ALU_SLTU: result = (a < b) ? 32'd1 : 32'd0; //default to zero

            default:  result = 32'd0; //defaultS
        endcase
    end
    // zero flag: high when result is zero
    assign zero = (result == 32'd0);

endmodule
