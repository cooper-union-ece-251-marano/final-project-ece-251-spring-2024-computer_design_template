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
    #(parameter n = 16)(
    input  logic [2:0] op,  // Assuming 4-bit opcode
    output logic       memtoreg, memwrite,
    output logic       branch, alusrc,
    output logic       regdst, regwrite, jump,
    output logic [1:0] aluop  
);
    logic [8:0] controls; // 6-bit control

    // Assigning each bit of controls to an output
    assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop} = controls;

    // Define the behavior based on the opcode
    // (check table for control values)
    always @* begin
        case (op)
            3'b000: controls <= 9'b110000000; // R: R-type operation
            3'b001: controls <= 9'b101001011; // I: Load word
            3'b010: controls <= 9'b001010011; // I: Store word
            3'b011: controls <= 9'b101000011; // I: ADDI
            3'b100: controls <= 9'b000100010; // I: BEQ
            3'b101: controls <= 9'b101000001; // I: SLTI
            3'b110: controls <= 9'b000000100; // J: Jump
            3'b111: controls <= 9'b110001100; // J: jump and link
            default: controls <= 9'bxxxxxxxxx; // Undefined or illegal operation
        endcase
    end

endmodule

`endif // MAINDEC
