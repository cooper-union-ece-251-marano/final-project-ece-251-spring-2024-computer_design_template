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
    parameter WIDTH = 16;  // Match the width of your ALU

    // Testbench signals
    reg [WIDTH-1:0] a, b;
    reg [2:0] alu_control;
    wire [WIDTH-1:0] result;
    wire zero;

    // Instantiate the ALU
    alu #(.WIDTH(WIDTH)) alu_instance (
        .a(a),
        .b(b),
        .alu_control(alu_control),
        .result(result),
        .zero(zero)
    );

    // Test procedure
    initial begin
        // Initialize inputs
        a = 0; b = 0; alu_control = 3'b000;

        // Apply test vectors
        #10 a = 16'h0001; b = 16'h0001; alu_control = 3'b000;  // Addition
        #10 a = 16'h0002; b = 16'h0001; alu_control = 3'b001;  // Subtraction
        #10 a = 16'h0003; b = 16'h0001; alu_control = 3'b010;  // AND
        #10 a = 16'h0001; b = 16'h0002; alu_control = 3'b011;  // OR
        #10 a = 16'h0001; b = 16'h0002; alu_control = 3'b100;  // SLT
        #10 a = 16'h0001; b = 16'h0002; alu_control = 3'b101;  // NOR
        #10 a = 16'h0002; b = 16'h0002; alu_control = 3'b100;  // SLT, equal case

        // Add more tests as needed
        #10 a = 16'hFFFF; b = 16'h0001; alu_control = 3'b000;  // Test overflow for addition

        #10 $finish;  // End simulation
    end

    // Monitor changes
    initial begin
        $monitor("At time %t, a = %h, b = %h, control = %b, result = %h, zero = %b",
                 $time, a, b, alu_control, result, zero);
    end

endmodule
`endif //TB_ALU
