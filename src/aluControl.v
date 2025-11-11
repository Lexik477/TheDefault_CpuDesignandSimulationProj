`timescale 1ns / 1ps

module aluControl(
    input [1:0] alu_op, //ALu operation types
    input [2:0] funct3, //function3 field
    input [6:0] funct7, //fucntion7 field
    output reg [3:0] aluControl //ALU operation code
);
//ALU operatoin codes
    localparam ALU_ADD  = 4'b0000;
    localparam ALU_SUB  = 4'b0001;
    localparam ALU_AND  = 4'b0010;
    localparam ALU_OR   = 4'b0011;
    localparam ALU_XOR  = 4'b0100;
    localparam ALU_SLT  = 4'b1000;
    localparam ALU_SLL  = 4'b0101;
    localparam ALU_SRL  = 4'b0110;
    localparam ALU_SRA  = 4'b0111;
    localparam ALU_SLTU = 4'b1001;  // ADD THIS


//ALu control decoding
    always @(*) begin
        case (alu_op)
            2'b00: aluControl = ALU_ADD; //load/store : add for address calc
            2'b01: aluControl = ALU_SUB; //branch: substract for comparison
            2'b10: begin //r-type inst.
                case (funct3)
                    3'b000: aluControl = (funct7[5]) ? ALU_SUB : ALU_ADD;
                     3'b001: aluControl = ALU_SLL;   // Shift left logical
                     3'b010: aluControl = ALU_SLT;   // Set less than (signed)
                       3'b011: aluControl = ALU_SLTU;  // Set less than
                    3'b100: aluControl = ALU_XOR;

                     3'b101: aluControl = (funct7[5]) ? ALU_SRA : ALU_SRL;

                    3'b110: aluControl = ALU_OR;
                    3'b111: aluControl = ALU_AND;
                    default: aluControl = ALU_ADD;
                endcase
            end
            2'b11: begin //I-type inst.
                case (funct3)
                    3'b000: aluControl = ALU_ADD;
                    3'b001: aluControl = ALU_SLL;   // SLLI
                    3'b010: aluControl = ALU_SLT;   // SLTI
                    3'b011: aluControl = ALU_SLTU;  // SLTIU
                    3'b100: aluControl = ALU_XOR;   // XORI
                    3'b101: aluControl = (funct7[5]) ? ALU_SRA : ALU_SRL;

                    3'b111: aluControl = ALU_AND;
                    3'b110: aluControl = ALU_OR;
                    default: aluControl = ALU_ADD;
                endcase
            end
            default: aluControl = ALU_ADD;
        endcase
    end

endmodule
