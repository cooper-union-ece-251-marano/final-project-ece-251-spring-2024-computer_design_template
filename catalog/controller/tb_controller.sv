//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: YOUR NAMES
// 
//     Create Date: 2023-02-07
//     Module Name: tb_controller
//     Description: Test bench for controller
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_CONTROLLER
`define TB_CONTROLLER

`timescale 1ns/100ps
`include "controller.sv"

module tb_controller;
    // Inputs
    reg [3:0] op;
    reg [3:0] funct;
    reg       zero;

    // Outputs
    wire      memtoreg, memwrite;
    wire      pcsrc, alusrc;
    wire      regdst, regwrite;
    wire      jump;
    wire [3:0] alucontrol;

    // Instantiate the controller module
    controller uut (
        .op(op),
        .funct(funct),
        .zero(zero),
        .memtoreg(memtoreg),
        .memwrite(memwrite),
        .pcsrc(pcsrc),
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .alucontrol(alucontrol)
    );

    // Initial block for running tests
    initial begin
        // Initialize inputs
        op = 0; funct = 0; zero = 0;

        // Monitor changes
        $monitor("At time %t, op=%b, funct=%b, zero=%b -> memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b",
                 $time, op, funct, zero, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

        // Test Sequence
        // Test each opcode and function with zero flag variations
        #10 op = 4'b0001; funct = 4'b0010; zero = 1'b0;
        #10 op = 4'b0001; funct = 4'b0010; zero = 1'b1;  // Toggle zero to test branching logic
        #10 op = 4'b0010; funct = 4'b0100; zero = 1'b0;
        #10 op = 4'b0010; funct = 4'b0100; zero = 1'b1;
        #10 op = 4'b0100; funct = 4'b1000; zero = 1'b0;

        // Additional tests can be added here for further coverage

        #10 $finish;  // End of simulation
    end
endmodule

`endif //TB_CONTROLLER
