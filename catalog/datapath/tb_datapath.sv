//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: YOUR NAMES
// 
//     Create Date: 2023-02-07
//     Module Name: tb_datapath
//     Description: Test bench for datapath
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

`include "datapath.sv"

module datapath_tb;

    // Parameters
    parameter WIDTH = 16;
    parameter CLK_PERIOD = 10;

    // Inputs
    logic clk, reset;
    logic memtoreg, pcsrc, alusrc, regdst, regwrite, jump;
    logic [2:0] alucontrol;
    logic [WIDTH-1:0] instr, readdata;

    // Outputs
    logic zero;
    logic [WIDTH-1:0] pc, aluout, writedata;

    // Instantiate the datapath module
    datapath #(WIDTH) dut (
        .clk(clk),
        .reset(reset),
        .memtoreg(memtoreg),
        .pcsrc(pcsrc),
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .alucontrol(alucontrol),
        .zero(zero),
        .pc(pc),
        .instr(instr),
        .aluout(aluout),
        .writedata(writedata),
        .readdata(readdata)
    );

    // Clock generation
    always begin
        # (CLK_PERIOD / 2) clk = ~clk;
    end

    // Test procedure
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        memtoreg = 0;
        pcsrc = 0;
        alusrc = 0;
        regdst = 0;
        regwrite = 0;
        jump = 0;
        alucontrol = 3'b000;
        instr = 16'd0;
        readdata = 16'd0;

        // Reset the DUT
        # CLK_PERIOD;
        reset = 0;

        // Add your test cases here
        // Example: Perform a test with a specific instruction
        // Update inputs as needed, and observe outputs
        // Test Case 1: Simple addition operation
        instr = 16'b0000000000000001; // Sample instruction (change as needed)
        alusrc = 1;
        alucontrol = 3'b000; // ALU control for addition
        regwrite = 1;
        regdst = 1;

        // Apply test inputs and wait for some time
        # (CLK_PERIOD * 2);

        // Check results
        $display("Test Case 1: Addition Operation");
        $display("PC: %h, ALU Output: %h, Write Data: %h", pc, aluout, writedata);

        // Add more test cases here

        // End simulation
        $finish;
    end

    // Additional functions for testing can be defined here

endmodule
