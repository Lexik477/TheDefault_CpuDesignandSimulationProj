`timescale 1ns / 1ps

// Data Memory : Stores data for load/store operations
//implements 4KB data emem for loading/storing operations in processor
//word-lined addressing
module dataMemory(
    input clk,           // Clock signal :synchronizes write op.
    input [31:0] addr,   // Byte address input
    input [31:0] wdata,  // Write data input
    input we,            // Write enable signal
    input re,            // Read enable
    output reg [31:0] rdata // Read data
);

//Memory declaration:
  //each memory location stores one 32 bit word.

    reg [31:0] memory [0:1023]; // 4KB data memory (1024 words) of 32 bits each

    // Initialize all memory locations to zero t startup for pred. behavior
    integer i;
    initial begin
        for (i = 0; i < 1024; i = i + 1) begin
            memory[i] = 32'd0; //set each memory to 32-bit zero
        end
    end

    // Read operation
    always @(*) begin
        if (re && addr[31:2] < 1024) begin
            rdata = memory[addr[31:2]]; // Word-aligned access
        end else begin
            rdata = 32'd0;
        end
    end

    // Write operation
    always @(posedge clk) begin
        if (we && addr[31:2] < 1024) begin
            memory[addr[31:2]] <= wdata;
        end
    end

endmodule
