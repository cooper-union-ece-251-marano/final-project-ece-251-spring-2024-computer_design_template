//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: YOUR NAMES
// 
//     Create Date: 2023-02-07
//     Module Name: tb_aludec
//     Description: Test bench for simple behavorial ALU decoder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_ALUDEC
`define TB_ALUDEC

`timescale 1ns/100ps
`include "aludec.sv"

module tb_aludec;
    // Parameters
    parameter n = 32;  // Width for decoder output for future flexibility

    // Inputs
    reg [5:0] funct;
    reg [1:0] aluop;

    // Outputs
    wire [3:0] alucontrol;

    // Instantiate the ALUDecoder
    ALUDecoder uut (
        .funct(funct),
        .aluop(aluop),
        .alucontrol(alucontrol)
    );

    // Test stimulus
    initial begin
        // Initialize inputs
        funct = 0;
        aluop = 0;

        // Test each case
        // Testing ADD operation (R-type)
        #10 funct = 6'b100000; aluop = 2'b10;  // `funct` for ADD
        #10 if (alucontrol !== 4'b0000) $display("Test failed: ADD operation error. Expected 0000, got %b", alucontrol);

        // Testing SUB operation (R-type)
        #10 funct = 6'b100010; aluop = 2'b10;  // `funct` for SUB
        #10 if (alucontrol !== 4'b0001) $display("Test failed: SUB operation error. Expected 0001, got %b", alucontrol);

        // Testing ADDI operation (I-type)
        #10 funct = 6'bxxxxxx; aluop = 2'b00;  // ADDI uses aluop specific to immediate operations
        #10 if (alucontrol !== 4'b0010) $display("Test failed: ADDI operation error. Expected 0010, got %b", alucontrol);

        // Add tests for other operations like AND, OR, XOR, SLT, etc.
        #10 funct = 6'b100100; aluop = 2'b10;  // `funct` for AND
        #10 if (alucontrol !== 4'b0010) $display("Test failed: AND operation error. Expected 0010, got %b", alucontrol);

        #10 funct = 6'b100101; aluop = 2'b10;  // `funct` for OR
        #10 if (alucontrol !== 4'b0011) $display("Test failed: OR operation error. Expected 0011, got %b", alucontrol);

        #10 $display("All tests completed successfully.");
        $finish;
    end

endmodule

`endif // TB_ALUDEC