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

`timescale 1ns/100ps
`include "cpu.sv"


module cpu_tb;

    parameter n = 16;
    logic clk, reset;
    logic [(n-1):0] pc, instr, aluout, writedata, readdata;
    logic memwrite;

    // Instantiate the CPU
    cpu #(.n(n)) uut (
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
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Clock period of 10 ns
    end

    // Test sequence
    initial begin
        // Initialize inputs
        reset = 1;
        readdata = 0;
        instr = 0;  // No operation or specific instruction
        #10;  // Wait for reset to take effect

        reset = 0;  // Release reset

        // Test: 
        readdata = 16'd5;  // Example data from memory or input
        instr = 16'b101_001_011_110_0000;
        
        #50;  // Run simulation for some time

        // End simulation
        $finish;
    end

    /* Optionally, monitor changes to outputs or important signals
    initial begin
        $monitor("Time: %t, PC: %d, Instr: %h, ALUout: %d, WriteData: %d, ReadData: %d, MemWrite: %b",
                 $time, pc, instr, aluout, writedata, readdata, memwrite);
    end*/

endmodule

`endif
