//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: YOUR NAMES
// 
//     Create Date: 2023-02-07
//     Module Name: tb_alu
//     Description: Test bench for simple behavorial ALU
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_ALU
`define TB_ALU

`timescale 1ns/100ps
`include "alu.sv"

module tb_alu;
    parameter n = 16;  // Data width of the ALU inputs/outputs
    reg [n-1:0] a, b;
    reg [3:0] alu_control;
    wire [n-1:0] result, remainder;
    wire zero;

    // Instantiate the ALU
    ALU #(.WIDTH(n)) uut (
        .a(a),
        .b(b),
        .alu_control(alu_control),
        .result(result),
        .zero(zero),
        .remainder(remainder)
    );

    // Test stimulus
    initial begin
        // Initialize inputs
        a = 0; b = 0; alu_control = 0;

        // Simple test for addition
        #10 a = 15; b = 10; alu_control = 4'b0000;  // ALU should add a and b
        #10 if (result != 25) $display("Test failed: Addition error. Expected 25, got %d", result);

        // Test for subtraction
        #10 a = 20; b = 10; alu_control = 4'b0001;  // ALU should subtract b from a
        #10 if (result != 10) $display("Test failed: Subtraction error. Expected 10, got %d", result);

        // Test for AND
        #10 a = 12; b = 10; alu_control = 4'b0010;  // ALU should AND a and b
        #10 if (result != (12 & 10)) $display("Test failed: AND error. Expected %d, got %d", (12 & 10), result);

        // Test for OR
        #10 a = 12; b = 10; alu_control = 4'b0011;  // ALU should OR a and b
        #10 if (result != (12 | 10)) $display("Test failed: OR error. Expected %d, got %d", (12 | 10), result);

        // Additional tests can be added here for XOR, NOR, shifts, etc.

        // Check zero flag
        #10 a = 0; b = 0; alu_control = 4'b0000;  // Check zero flag for addition of zero
        #10 if (!zero) $display("Test failed: Zero flag error. Expected true, got false");

        // Completion message
        #10 $display("All tests completed.");
        $finish;
    end

endmodule

`endif // TB_ALU