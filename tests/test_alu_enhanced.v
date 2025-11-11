`timescale 1ns / 1ps

module test_alu_enhanced;
    reg [31:0] a, b;
    reg [3:0] alu_control;
    wire [31:0] result;
    wire zero;

    alu dut(.a(a), .b(b), .alu_control(alu_control), .result(result), .zero(zero));

    initial begin
        $display("   Enhanced ALU Test    ");

        // Test SLL
        a = 32'h00000001; b = 32'd4; alu_control = 4'b0101;
        #10;
        $display("SLL: 0x%h << %d = 0x%h", a, b, result);

        // Test SRA (arithmetic shift with sign extension)
        a = 32'h80000000; b = 32'd4; alu_control = 4'b0111;
        #10;
        $display("SRA: 0x%h >>> %d = 0x%h", a, b, result);

        // Test SLT (set less than)
        a = 32'd5; b = 32'd10; alu_control = 4'b1000;
        #10;
        $display("SLT: %d < %d = %d", a, b, result);

        $finish;
    end
endmodule
