//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: maindec
//     Description: 32-bit RISC-based CPU main decoder (MIPS)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef MAINDEC
`define MAINDEC

`timescale 1ns/100ps

module maindec
    #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic [5:0] op, funct,
    output logic       memtoreg, memwrite,
    output logic       branch, alusrc,
    output logic       regdst, regwrite,
    output logic       jump, jr, jal,
    output logic [1:0] aluop
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [10:0] controls; // 10-bit control vector

    // controls has 10 logical signals
    assign {regwrite, regdst, alusrc, branch, memwrite,
            memtoreg, jump, jr, jal, aluop} = controls;

    always @* begin
        case(op)
            6'b000000:
                case(funct)
                    6'b001000: controls <= 11'b00000001000; // JR
                    default: controls <= 11'b11000000010; // RTYPE
                endcase
            6'b100011: controls <= 11'b10100100000; // LW
            6'b101011: controls <= 11'b00101000000; // SW
            6'b000100: controls <= 11'b00010000001; // BEQ
            6'b001000: controls <= 11'b10100000000; // ADDI
            6'b000010: controls <= 11'b00000010000; // J
            6'b000011: controls <= 11'b00000010100; // JAL
            default:   controls <= 11'bxxxxxxxxxxx; // illegal operation
        endcase
    end

endmodule

`endif // MAINDEC