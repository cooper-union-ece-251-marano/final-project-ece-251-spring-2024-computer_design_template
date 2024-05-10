//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: controller
//     Description: 32-bit RISC-based CPU controller (MIPS)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef CONTROLLER
`define CONTROLLER

`timescale 1ns/100ps

`include "../maindec/maindec.sv"
`include "../aludec/aludec.sv"
module controller
    #(parameter n = 16)(  // Adjusted for 16-bit width
    input  logic [2:0] op,  // Example: reduced size if fewer opcodes
    input  logic [3:0] funct,  // Adjust funct size based on the new instruction set
    input  logic       zero,
    output logic       memtoreg, memwrite,
    output logic       pcsrc, alusrc,
    output logic       regdst, regwrite,
    output logic       jump,
    output logic [2:0] alucontrol  // Adjust control signals based on required ALU operations
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [1:0] aluop;
    logic       branch;

    /*always @(*) begin
        $display("Time: %t, op: %b, funct: %b, zero: %b, memtoreg: %b, memwrite: %b, pcsrc: %b, alusrc: %b, regdst: %b, regwrite: %b, jump: %b, alucontrol: %b, aluop: %b",
                 $time, op, funct, zero, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol, aluop);
    end*/
    
    // CPU main decoder
    maindec md(op, memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, aluop);

    // CPU's ALU decoder
    aludec  ad(funct, aluop, alucontrol);

  assign pcsrc = branch & zero;

endmodule

`endif // CONTROLLER
