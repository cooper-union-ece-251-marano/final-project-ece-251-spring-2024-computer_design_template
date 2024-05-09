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
`ifndef TB_DATAPATH
`define TB_DATAPATH

`timescale 1ns/100ps
`include "datapath.sv"

module tb_datapath;

    parameter n = 16;  // Assuming the datapath is configured for 16-bit operations
    reg clk, reset;
    reg memtoreg, pcsrc, alusrc, regdst, regwrite, jump;
    reg [2:0] alucontrol;
    reg [(n-1):0] instr, readdata;
    wire zero;
    wire [(n-1):0] pc, aluout, writedata;
    parameter CLK_PERIOD = 10;

    // Instantiate the datapath
    datapath #(.n(n)) uut (
        .clk(clk),
        .reset(reset),
        .memtoreg(memtoreg),
        .pcsrc(pcsrc),
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .alucontrol(alucontrol),
        .instr(instr),
        .readdata(readdata),
        .zero(zero),
        .pc(pc),
        .aluout(aluout),
        .writedata(writedata)
    );

    // Clock generation
    always begin
        clk = 0;
        forever # (CLK_PERIOD / 2) clk = ~clk;
    end

    // Test procedure
    initial begin
        reset = 1;
        # (CLK_PERIOD * 2);
        reset = 0;

        // Add Test Inputs
        regwrite = 1;
        regdst = 1;
        alusrc = 0;
        memtoreg = 0;
        jump = 0;
        alucontrol = 3'b000;
        instr = 16'b000_001_011_110_0000;  // Check if this matches your instruction format
        readdata = 0;

        // Apply test inputs and wait for some time
        # (CLK_PERIOD * 10);

        // End simulation
        $finish;
    end

endmodule
`endif
/*
module tb_datapath;

// Parameters
    parameter n = 16;  // Assuming the datapath is configured for 16-bit operations

    // Inputs to the datapath
    reg clk, reset;
    reg memtoreg, pcsrc, alusrc, regdst, regwrite, jump;
    reg [2:0] alucontrol;
    reg [(n-1):0] instr, readdata;

    // Outputs from the datapath
    wire zero;
    wire [(n-1):0] pc, aluout, writedata;

    parameter CLK_PERIOD = 10;

    // Instantiate the datapath
    datapath #(.n(n)) uut (
        .clk(clk),
        .reset(reset),
        .memtoreg(memtoreg),
        .pcsrc(pcsrc),
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .alucontrol(alucontrol),
        .instr(instr),
        .readdata(readdata),
        .zero(zero),
        .pc(pc),
        .aluout(aluout),
        .writedata(writedata)
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

        //instr = 16'b0000000000000011; // Sample instruction (change as needed)
        //instr = 16'b0000_011_001_010_000;  // Assuming an ADD instruction format
        //alusrc = 1;
        //alucontrol = 3'b000; // ALU control for addition
        //regwrite = 1;
        //regdst = 1;
        
        regwrite = 1;
        regdst = 1;
        alusrc = 0;
        memtoreg = 0;
        jump = 0;
        reset = 0;
        alucontrol = 3'b000;
        instr = 16'b000_001_011_110_0000;
        readdata = 0;

        // Apply test inputs and wait for some time
        # (CLK_PERIOD * 2);

        // Check results
        $display("Test Case 1: Addition Operation");
        $display("PC: %h, ALU Output: %b, Write Data: %h", pc, aluout, writedata);

        // Add more test cases here

        // End simulation
        $finish;
    end

endmodule
`endif // TB_DATAPATH
*/
