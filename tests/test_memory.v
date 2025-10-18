`timescale 1ns / 1ps

module test_memory;
    reg [31:0] addr;
    wire [31:0] data;
    wire error;

    instructionMemory imem(.addr(addr), .data(data), .imem_error(error));

    initial begin
        $display(" Instruction Memory Test ");

        // Test valid access
        addr = 32'd0;
        #10;
        $display("Addr 0x%h: Data=0x%h, Error=%b", addr, data, error);

        // Test unaligned access
        addr = 32'd1;
        #10;
        $display("Addr 0x%h: Data=0x%h, Error=%b", addr, data, error);

        $display("=== Memory Test Complete ===");
        $finish;
    end
endmodule
