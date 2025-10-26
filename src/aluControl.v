`timescale 1ns / 1ps

module aluControl(
    input [1:0] alu_op,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [3:0] aluControl
);

    localparam ALU_ADD  = 4'b0000;
    localparam ALU_SUB  = 4'b0001;
    localparam ALU_AND  = 4'b0010;
    localparam ALU_OR   = 4'b0011;
    localparam ALU_XOR  = 4'b0100;
    localparam ALU_SLT  = 4'b1000;

    always @(*) begin
        case (alu_op)
            2'b00: aluControl = ALU_ADD;
            2'b01: aluControl = ALU_SUB;
            2'b10: begin
                case (funct3)
                    3'b000: aluControl = (funct7[5]) ? ALU_SUB : ALU_ADD;
                    3'b111: aluControl = ALU_AND;
                    3'b110: aluControl = ALU_OR;
                    3'b100: aluControl = ALU_XOR;
                    3'b010: aluControl = ALU_SLT;
                    default: aluControl = ALU_ADD;
                endcase
            end
            2'b11: begin
                case (funct3)
                    3'b000: aluControl = ALU_ADD;
                    3'b111: aluControl = ALU_AND;
                    3'b110: aluControl = ALU_OR;
                    default: aluControl = ALU_ADD;
                endcase
            end
            default: aluControl = ALU_ADD;
        endcase
    end

endmodule
