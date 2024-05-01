//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Isabel Zulawski & Siann Han
// 
//     Create Date: 2024-05-28
//     Module Name: aludec
//     Description: 16-bit RISC ALU decoder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

`ifndef ALUDEC
`define ALUDEC

module aludec
    //#(parameter n = 32) should this be parameterized?
    (
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
     input [3:0] op, 
    output reg [3:0] alu_control 
);

    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
//based on ALU ordering from design attached to ALU module
    always @(*) begin
        case (op)
            4'b0000: alu_control = 4'b0000; // AND 
            4'b0001: alu_control = 4'b0001; // OR 
            4'b0010: alu_control = 4'b0010; // ADD 
            4'b0110: alu_control = 4'b0110; // SUB 
            4'b0111: alu_control = 4'b0111; // SLT 
            4'b0011: alu_control = 4'b0011; // NOR
          	4'b1000: alu_control = 4'b1000; // none
            4'b1001: alu_control = 4'b1001; // MUL 
            4'b1010: alu_control = 4'b1010; // SLL 
            4'b1011: alu_control = 4'b1011; // SGT 
            4'b1100: alu_control = 4'b1100; // CLO/CLZ 
            4'b1101: alu_control = 4'b1101; // ROTR/SRL 
            4'b0100: alu_control = 4'b0100; // XOR 
            4'b1110: alu_control = 4'b1110; // SLTU 
          	4'b0101: alu_control = 4'b0101; // sign ext
            4'b1111: alu_control = 4'b1111; // SRA 
            default: alu_control = 4'b0010; // Default to ADD operation
        endcase
    end

endmodule

`endif // ALUDEC
