`timescale 1ns / 1ps

module test_alu;
    reg [31:0] a, b;
    reg [3:0] alu_control;
    wire [31:0] result;
    wire zero;

    alu dut(.a(a), .b(b), .alu_control(alu_control), .result(result), .zero(zero));

    initial begin
        $display("=== ALU Unit Test ===");

        // Test ADD
        a = 32'd5; b = 32'd3; alu_control = 4'b0000;
        #10;
        $display("ADD: %d + %d = %d", a, b, result);

        // Test AND
        a = 32'hF0F0; b = 32'hFF00; alu_control = 4'b0010;
        #10;
        $display("AND: 0x%h & 0x%h = 0x%h", a, b, result);

        $display("=== ALU Test Complete ===");
        $finish;
    end
endmodule
