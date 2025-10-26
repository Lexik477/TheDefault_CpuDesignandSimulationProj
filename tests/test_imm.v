//  Test immediate generator
`timescale 1ns / 1ps

module test_imm;
    reg [31:0] instruction;
    reg [1:0] imm_sel;
    wire [31:0] imm;

    immediateGen dut(.instruction(instruction), .imm_sel(imm_sel), .imm(imm));

    initial begin
        $display(" Immediate Generator Test! ");

        // Test I-type (addi x1, x0, 4)
        instruction = 32'h00400093; imm_sel = 2'b00;
        #10;
        $display("I-type: 0x%h -> 0x%h", instruction, imm);

        // Test S-type (sw x2, 0(x1))
        instruction = 32'h00208023; imm_sel = 2'b01;
        #10;
        $display("S-type: 0x%h -> 0x%h", instruction, imm);

        $finish;
    end
endmodule
