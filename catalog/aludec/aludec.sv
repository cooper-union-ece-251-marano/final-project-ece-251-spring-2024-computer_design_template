//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: YOUR NAMES
// 
//     Create Date: 2023-02-07
//     Module Name: aludec
//     Description: 32-bit RISC ALU decoder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef ALUDEC
`define ALUDEC

`timescale 1ns/100ps

module aludec(
    input logic [3:0] funct,      // Function code part of the instruction (used mainly for R-type)
    input logic [1:0] aluop,      // ALU operation type from the control unit
    output logic [3:0] alucontrol // Control signals for the ALU
);

    // Define the ALU control logic
    always_comb begin
        case (aluop)
            2'b00: begin
                // ALU operations for load/store and add immediate
                alucontrol = 4'b1111; // add (for lw, sw, addi)
            end

            2'b01: begin
                // Subtraction related operations for branching
                alucontrol = 4'b0001; // sub (for beq)
            end

            2'b10: begin
                // R-type and complex immediate operations (including `addi` if extended functionality is needed)
                case (funct)
                    4'b0000: alucontrol = 4'b0000; // add
                    4'b0001: alucontrol = 4'b0001; // sub
                    4'b0010: alucontrol = 4'b0010; // and
                    4'b0011: alucontrol = 4'b0011; // or
                    4'b0100: alucontrol = 4'b0100; // xor
                    4'b0101: alucontrol = 4'b0101; // not
                    4'b0110: alucontrol = 4'b0110; // set less than
                    4'b0111: alucontrol = 4'b0111; // shift left logical
                    4'b1000: alucontrol = 4'b1000; // shift right logical
                    4'b1001: alucontrol = 4'b1001; // multipy
                    4'b1010: alucontrol = 4'b1010; // divide
                    default:   alucontrol = 4'bxxxx; // Undefined operation
                endcase
            end

            2'b11: begin
                // Dedicated `aluop` for immediate operations that aren't simple addition
                alucontrol = 4'b1100; // Specific immediate operations (e.g., addi special case)
            end

            default: begin
                // Default or safety case
                alucontrol = 4'bxxxx;
            end
        endcase
    end
endmodule

`endif // ALUDEC
