`timescale 1ns / 1ps
//control unit: generates signals from instruction opcode
module controlUnit(
    input [6:0] opcode, //inst opcode field
    input [2:0] funct3, //function3 field
    input [6:0] funct7, //function7 field
    output reg reg_write, //register write enable
    output reg alu_src, //ALU dource 0= register, 1 = immediate
    output reg mem_write, //memory write enable
    output reg mem_read, //mem read enable
    output reg mem_to_reg, //memory to register
    output reg branch, //branch inst
    output reg [1:0] alu_op, //ALU operation type
    output reg [1:0] imm_sel, //jump inst.
    output reg jump
);
//RISC-V RC32I opcodes

    localparam OP_RTYPE = 7'b0110011; // reg-reg operation
    localparam OP_ITYPE = 7'b0010011; //immediate operations
    localparam OP_LOAD  = 7'b0000011; //load instructions
    localparam OP_STORE = 7'b0100011; //store instructions
    localparam OP_BRANCH = 7'b1100011; //branchinstructions
    localparam OP_JAL   = 7'b1101111; //jump and link
    localparam OP_JALR  = 7'b1100111; //load upper immediate
    localparam OP_LUI   = 7'b0110111; //add upper imm.
    localparam OP_AUIPC = 7'b0010111;

//ALU operation types!
    localparam ALU_OP_RTYPE = 2'b10; //R-type instructions
    localparam ALU_OP_ITYPE = 2'b11; //I-type instructions
    localparam ALU_OP_BRANCH = 2'b01; //branch comparisons
    localparam ALU_OP_OTHER = 2'b00; //other op.

//imm format types
    localparam IMM_I = 2'b00; //i-type loads
    localparam IMM_S = 2'b01; //s-type stores
    localparam IMM_B = 2'b10; //b-type :branches
    localparam IMM_U = 2'b11; //U-type:LUI, AUIPC


//control signal generation based on opcode
    always @(*) begin
      //default control vals
        reg_write = 1'b0;
        alu_src = 1'b0;
        mem_write = 1'b0;
        mem_read = 1'b0;
        mem_to_reg = 1'b0;
        branch = 1'b0;
        alu_op = ALU_OP_OTHER;
        imm_sel = IMM_I;
        jump = 1'b0;

        case (opcode)
            OP_RTYPE: begin //add, sub, and, or ,axor,slt, sll,...
                reg_write = 1'b1; //write to register
                alu_src = 1'b0; //use register as ALU source
                alu_op = ALU_OP_RTYPE; //r-type ALU operation
            end
            OP_ITYPE: begin //addi, andi, ori, xori,slti,slli,srli,...
                reg_write = 1'b1;
                alu_src = 1'b1; //use imm. as ALU source
                alu_op = ALU_OP_ITYPE; //I-type ALU operation
                imm_sel = IMM_I; //I-type imm. format
            end

            OP_LOAD: begin //lw
                reg_write = 1'b1;
                alu_src = 1'b1; //use imm for address offset
                mem_read = 1'b1; //read from memory
                mem_to_reg = 1'b1; //write memory data to register
                imm_sel = IMM_I; //I-type imm format
            end

            OP_STORE: begin //sw
                alu_src = 1'b1; //for imm address offset
                mem_write = 1'b1; //write to memory
                imm_sel = IMM_S; //s-type imm format
            end

            OP_BRANCH: begin //beq, bne, blt, bge
                branch = 1'b1; //branch instruc.
                alu_op = ALU_OP_BRANCH; //branch comparison
                imm_sel = IMM_B; //b-type immed. format
            end

            OP_JAL: begin
                reg_write = 1'b1;  // Write return address to register
                jump = 1'b1;  // Jump instruction
                imm_sel = IMM_U;  // U-type immediate format
            end

             OP_JALR: begin   // jalr
                reg_write = 1'b1;
                jump = 1'b1;
                alu_src = 1'b1;      // Use immediate for offset
                imm_sel = IMM_I;     // I-type immediate format
            end

            OP_LUI: begin    // lui
                reg_write = 1'b1;
                alu_src = 1'b1;      // Use immediate value
                imm_sel = IMM_U;     // U-type immediate format
            end

              OP_AUIPC: begin  // auipc
                reg_write = 1'b1;
                alu_src = 1'b1;      // Use immediate value
                imm_sel = IMM_U;     // U-type immediate format
            end



        endcase
    end

endmodule
