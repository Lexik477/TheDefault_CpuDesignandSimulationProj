`timescale 1ns / 1ps

module regfile(
     input clk,              // Clock signal
    input rst,              // Reset signal
    input [4:0] rs1,        // Read address 1
    input [4:0] rs2,        // Read address 2
    input [4:0] rd,         // Write address
    input [31:0] wdata,     // Write data
    input we,               // Write enable
    output [31:0] rdata1,   // Read data 1
    output [31:0] rdata2    // Read data 2
);

    reg [31:0] registers [0:31]; //32 reg
    integer i;

    // Initialize all registers to zero

    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 32'd0;
        end
    end

    // Read ports :combinational
    assign rdata1 = (rs1 != 0) ? registers[rs1] : 32'd0;
    assign rdata2 = (rs2 != 0) ? registers[rs2] : 32'd0;

    // Write port : synchronous
    always @(posedge clk or posedge rst) begin
        if (rst) begin
          //reset all reg to zero
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'd0;
            end
        end else if (we && (rd != 0)) begin
          //write to register if not x0
            registers[rd] <= wdata;
        end
    end

endmodule
