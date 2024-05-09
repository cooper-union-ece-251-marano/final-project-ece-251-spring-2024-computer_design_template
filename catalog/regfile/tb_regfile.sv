//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: YOUR NAMES
// 
//     Create Date: 2023-02-07
//     Module Name: tb_regfile
//     Description: Test bench for simple behavorial register file
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_REGFILE
`define TB_REGFILE

`timescale 1ns/100ps
`include "regfile.sv"

module tb_regfile;
    parameter n = 16;  // Bit width of the registers is now 16 bits
    parameter r = 3;   // Number of address bits, assuming 32 registers (can be adjusted if fewer are needed)
    
    //we = write enable
    //wa = write address
    //ra1 = read address 1
    //ra2 = read address 2
    //wd3 = write data

    // Inputs
    reg clk, we3;
    reg [r-1:0] wa3, ra1, ra2;
    reg [n-1:0] wd3;

    // Outputs
    wire [n-1:0] rd1, rd2;

    // Instantiate the register file
    regfile #(.n(n), .r(r)) uut (
        .clk(clk),
        .we3(we3),
        .wa3(wa3),
        .wd3(wd3),
        .ra1(ra1),
        .ra2(ra2),
        .rd1(rd1),
        .rd2(rd2)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Clock with a period of 10 ns
    end

    // Test sequences
    initial begin
        // Initialize inputs
        we3 = 0;
        wa3 = 0;
        wd3 = 0;
        ra1 = 0;
        ra2 = 0;

        // Wait for a few clock cycles
        #20;

        // Test 1: Write to a register and read back from it
        wa3 = 5;            // Write address
        wd3 = 16'hA5A5;     // Write data is now 16-bit
        we3 = 1;            // Enable writing
        #10;                // Wait for a clock edge

        we3 = 0;            // Disable writing
        ra1 = 5;            // Set read address 1 to the same as write address
        ra2 = 5;            // Set read address 2 to the same as write address
        #10;                // Wait for data to be read back

        // Check the output
        if (rd1 !== 16'hA5A5 || rd2 !== 16'hA5A5) begin
            $display("Test failed: Data mismatch on register readback. Expected %h, got %h and %h", 16'hA5A5, rd1, rd2);
        end else begin
            $display("Test passed: Data correctly written and read back.");
        end

        // Additional tests can be added here

        $finish;  // End the simulation
    end
endmodule
`endif // TB_REGFILE
