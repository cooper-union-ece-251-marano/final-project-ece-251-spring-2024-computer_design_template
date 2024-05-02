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
    input  logic [3:0] op,  // Assuming 4-bit opcode
    output logic       memtoreg, memwrite,
    output logic       branch, alusrc,
    output logic       regwrite, jump,
    output logic [1:0] aluop  
);
    logic [5:0] controls; // 6-bit control

    // Assigning each bit of controls to an output
    assign {regwrite, alusrc, branch, memwrite, memtoreg, jump} = controls;

    // Define the behavior based on the opcode
    always @* begin
        case (op)
            4'b0000: controls <= 6'b100010; // Example: R-type operation
            4'b0001: controls <= 6'b100100; // LW: Load word
            4'b0010: controls <= 6'b010100; // SW: Store word
            4'b0011: controls <= 6'b101000; // Branch if equal (example)
            4'b0100: controls <= 6'b100001; // ADDI: Add immediate
            4'b0101: controls <= 6'b000001; // J: Jump
            default: controls <= 6'b000000; // Undefined or illegal operation
        endcase
    end

endmodule

`endif // MAINDEC
