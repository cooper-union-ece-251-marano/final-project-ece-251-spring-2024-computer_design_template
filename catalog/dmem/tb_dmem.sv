////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
// Create Date: 2023-02-07
// Module Name: tb_dmem
// Description: Test bench for data memory
//
// Revision: 1.0
//
///////////////////////////////////////////////////////////////////////////////
//
//
`ifndef TB_DMEM
`define TB_DMEM

`timescale 1ns/100ps
`include "dmem.sv"
`include "../clock/clock.sv"

module tb_dmem;
    parameter n = 16; // bit length of data (16 bits)
    parameter r = 16; // bit length of address bus (16 bits for 64KB memory)
    logic [(n-1):0] readdata, writedata;
    logic [(r-1):0] dmem_addr; // Corrected to 16-bit address
    logic write_enable;
    logic clk, clock_enable;

    initial begin
        $dumpfile("dmem.vcd");
        $dumpvars(0, tb_dmem);
        $monitor("time=%0t write_enable=%b dmem_addr=%h readdata=%h writedata=%h",
            $realtime, write_enable, dmem_addr, readdata, writedata);
    end

    initial begin
        clock_enable <= 0;
        clk <= 0;
        #5 clock_enable <= 1; // Start the clock after a delay
        #10; // Wait for the clock to stabilize

        // Write and read sequences
        writedata = 16'hFFFF;
        dmem_addr = 16'h0000; // Word-aligned address
        write_enable = 1;
        #20; // Write first value
        write_enable = 0;
        
        #10; // Change data and address
        writedata = 16'hA5A5;
        dmem_addr = 16'h0002; // Next word-aligned address
        write_enable = 1;
        #20; // Write second value
        write_enable = 0;
        
        #10; // Prepare to end simulation
        $finish;
    end

        // Clock signal generation
    initial clk = 0;
    always #10 clk = ~clk; // Toggle clock every 10ns

    initial begin
        // ... [your existing initial block]
    end

    // Instantiate the DUT (Device Under Test)
    dmem uut(
        .clk(clk),
        .write_enable(write_enable),
        .addr(dmem_addr),
        .writedata(writedata),
        .readdata(readdata)
    );

    // Remove clock instance if not required
    // clock uut1(
    //     .ENABLE(clock_enable),
    //     .CLOCK(clk)
    // );
endmodule

`endif // TB_DMEM
