///////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
// Create Date: 2023-02-07
// Module Name: maindec
// Description: 16-bit RISC-based CPU main decoder
//
// Revision: 1.0
//
////////////////////////////////////////////////////////////////////////////////
`ifndef MAINDEC
`define MAINDEC

`timescale 1ns/100ps

module maindec
    #(parameter n = 16)(
    input  logic [3:0] op, // 4-bit opcode
    output logic       memtoreg, memwrite,
    output logic       branch, alusrc,
    output logic       regdst, regwrite,
    output logic       jump,
    output logic       aluop // Assuming 1-bit ALU op for simplicity
);

    // Use blocking assignments for combinational logic
    always_comb begin
        case(op)
            4'b0000: {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop} = 8'b11000010; // RTYPE
            4'b0001: {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop} = 8'b10101000; // LW
            4'b0010: {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop} = 8'b00100100; // SW
            4'b0011: {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop} = 8'b00010001; // BEQ
            4'b0100: {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop} = 8'b10100000; // ADDI
            4'b0101: {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop} = 8'b00000100; // J
            // ... other cases ...
            default: {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop} = 8'bxxxxxxx1; // Illegal operation (defined)
        endcase
    end

endmodule

`endif // MAINDEC

