`timescale 1ns / 1ps
//immediate generator: extracts and sign exttends immediate val.

module immediateGen(
    input [31:0] instruction,
    input [1:0] imm_sel, //imm. format selector
    output reg [31:0] imm
);
//immediate value generation based on inst. format
    always @(*) begin
        case (imm_sel)
            2'b00: begin // I-type
                imm = {{20{instruction[31]}}, instruction[31:20]};
            end
            2'b01: begin // S-type
                imm = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            end
            2'b10: begin // B-type : [31], [30:25], [11:8]-shifted left by 1
                imm = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
            end
            2'b11: begin // U-type : shifted left by 12
                imm = {instruction[31:12], 12'b0};
            end
            default: imm = 32'd0;
        endcase
    end

endmodule
