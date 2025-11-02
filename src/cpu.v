//main cpu module!
//todo: add more comments later!
`timescale 1ns / 1ps

module cpu(
    input clk, //clock input
    input rst //reset input
);

    // Instruction Fetch
    wire [31:0] pc; //program counter
    wire [31:0] instruction; //current instruction

    // Instruction Decode
    wire [6:0] opcode;
    wire [4:0] rs1, rs2, rd; //register addresses
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [31:0] imm; //immediate value

    // Control Signals
    wire reg_write, alu_src, mem_write, mem_read, mem_to_reg, branch;
    wire [1:0] alu_op, imm_sel;
    wire jump;
    wire [3:0] alu_control_sig;

    // Datapath
    wire [31:0] rdata1, rdata2, wdata;
    wire [31:0] alu_result, alu_b, mem_rdata;
    wire alu_zero;

    // Program Counter Control
    wire pc_src;
    wire [31:0] pc_plus_4;
    wire [31:0] branch_target;
    wire [31:0] next_pc;

    // Module Instantiations
    pcRegister pc_reg_inst(.clk(clk), .rst(rst), .next_pc(next_pc), .pc(pc));

    instructionMemory imem(.addr(pc), .data(instruction));

//instruction field opcode
    assign opcode = instruction[6:0];
    assign rd = instruction[11:7];
    assign funct3 = instruction[14:12];
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign funct7 = instruction[31:25];

//main control unit
    controlUnit control(
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
        .branch(branch),
        .alu_op(alu_op),
        .imm_sel(imm_sel),
        .jump(jump)
    );
//ALU control
    aluControl alu_ctrl(
        .alu_op(alu_op),
        .funct3(funct3),
        .funct7(funct7),
        .aluControl(alu_control_sig)
    );
//immediate generator
    immediateGen imm_gen(
        .instruction(instruction),
        .imm_sel(imm_sel),
        .imm(imm)
    );

    regfile regfile_inst(
        .clk(clk),
        .rst(rst),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .wdata(wdata),
        .we(reg_write),
        .rdata1(rdata1),
        .rdata2(rdata2)
    );
//ALU input B multiplexer
    assign alu_b = alu_src ? imm : rdata2;
//arithmetic logic unit
    alu alu_inst(
        .a(rdata1),
        .b(alu_b),
        .alu_control(alu_control_sig),
        .result(alu_result),
        .zero(alu_zero)
    );
//data memory
    dataMemory dmem(
        .clk(clk),
        .addr(alu_result),
        .wdata(rdata2),
        .we(mem_write),
        .re(mem_read),
        .rdata(mem_rdata)
    );

    assign wdata = mem_to_reg ? mem_rdata : alu_result;

    // Next PC Calculation
    assign pc_src = branch & alu_zero;
    assign pc_plus_4 = pc + 4;
    assign branch_target = pc + imm;
    assign next_pc = jump ? branch_target : (pc_src ? branch_target : pc_plus_4);

endmodule
