//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: cpu
//     Description: 32-bit RISC-based CPU (MIPS)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef CPU
`define CPU

`timescale 1ns/100ps

`include "../controller/controller.sv"
`include "../datapath/datapath.sv"

module cpu
    #(parameter n = 16)(  // Adjust parameter for 16-bit operations
    input  logic           clk, reset,
    output logic [(n-1):0] pc,
    input  logic [(n-1):0] instr,
    output logic           memwrite,
    output logic [(n-1):0] aluout, writedata,
    input  logic [(n-1):0] readdata
);
    // Internal control signals
    logic       memtoreg, alusrc, regdst, regwrite, jump, pcsrc, zero;
    logic [2:0] alucontrol;  // Assume ALU control logic stays same

    // Adjust bit-widths of opcode and function codes if necessary
    controller c(instr[15:13], instr[3:0], zero,   // Adjust bit ranges
                    memtoreg, memwrite, pcsrc,
                    alusrc, regdst, regwrite, jump,
                    alucontrol);
    /*
    always @(*) begin
         $display("Outputs: memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);
    end*/

    datapath dp(clk, reset, memtoreg, pcsrc,
                    alusrc, regdst, regwrite, jump,
                    alucontrol, readdata, instr,
                    zero, pc,
                    aluout, writedata);

endmodule

`endif
