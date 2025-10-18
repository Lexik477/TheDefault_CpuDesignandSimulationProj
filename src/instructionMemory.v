`timescale 1ns / 1ps

module instructionMemory(
    input [31:0] addr,
    output reg [31:0] data,
    output reg imem_error
);

    reg [31:0] memory [0:1023];
    integer i; //for loop var

    initial begin
        // Initialize all memory to zero first
        for (i = 0; i < 1024; i = i + 1) begin
            memory[i] = 32'd0;
        end

        // Load program from hex file
        $readmemh("tests/test_base.hex", memory);
        imem_error = 1'b0;
    end

    always @(*) begin
        if (addr[1:0] != 2'b00) begin
            $display("Unaligned instruction fetch: addr=0x%h", addr);
            data = 32'h00000013; // nop instruction
            imem_error = 1'b1;
        end else if (addr[31:2] >= 1024) begin
            $display("Instruction fetch out of bounds: addr=0x%h", addr);
            data = 32'h00000013;
            imem_error = 1'b1;
        end else begin
            data = memory[addr[31:2]];
            imem_error = 1'b0;
        end
    end

endmodule
