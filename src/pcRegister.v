`timescale 1ns / 1ps

//Program Counter Register: holds current instruction address

module pcRegister(
    input clk,
    input rst,
    input [31:0] next_pc,
    output reg [31:0] pc
);

//Prog counter update

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc <= 32'd0; //reset to start at address 0
        end else begin
            pc <= next_pc; //update to next inst. address
        end
    end

endmodule
