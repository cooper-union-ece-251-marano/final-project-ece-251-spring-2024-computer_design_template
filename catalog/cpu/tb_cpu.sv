//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: YOUR NAMES
// 
//     Create Date: 2023-02-07
//     Module Name: tb_cpu
//     Description: Test bench for cpu
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_CPU
`define TB_CPU

`timescale 1ns / 100ps
`include "cpu.sv"

module tb_cpu;
    parameter n=16;

    // Clock and reset signals
    logic clk, reset;

    // CPU signals
    logic [n-1:0] pc;
    logic [n-1:0] instr;
    logic memwrite;
    logic [n-1:0] aluout;
    logic [n-1:0] writedata;
    logic [n-1:0] readdata;

    // Instantiate the CPU
    cpu uut (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instr(instr),
        .memwrite(memwrite),
        .aluout(aluout),
        .writedata(writedata),
        .readdata(readdata)
    );

    // Clock generation
    always begin
        #10 clk = ~clk;  // Toggle clock every 5 ns
    end

    // Instruction memory (simple ROM for testing)
    always_comb begin
        case (pc)
            16'h0000: instr = 16'h1234;  // Example instruction
            16'h0002: instr = 16'h5678;  // Example instruction
            16'h0004: instr = 16'h9ABC;  // Example instruction
            16'h0006: instr = 16'hDEF0;  // Example instruction
            default: instr = 16'h0000;   // NOP (No operation)
        endcase
    end

    // Test initialization
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        readdata = 0;  // Assuming no data coming from memory initially

        // Apply reset
        #10 reset = 0;  // Release reset after 10 ns

        // Simulation run time
        #100 $finish;  // Stop simulation after 100 ns
    end

endmodule
`endif
