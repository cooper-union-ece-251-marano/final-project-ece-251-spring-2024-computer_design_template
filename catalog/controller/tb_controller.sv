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


module test_controller;

    // Inputs
    reg [2:0] op;
    reg [3:0] funct;
    reg zero;

    // Outputs
    wire memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump;
    wire [2:0] alucontrol;

    // Instantiate the Unit Under Test (UUT)
    controller #(16) uut (
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

    // Testbench logic
    initial begin
        // Initialize Inputs
        op = 0; funct = 0; zero = 0;

        // Wait for global reset
        #100;

        // Test each opcode and funct combination with varying zero input
        {op, funct, zero} = 9'b000_0001_0; #100;
        {op, funct, zero} = 9'b000_0011_0; #100;
        {op, funct, zero} = 9'b100_0000_0; #100;
        {op, funct, zero} = 9'b101_0000_0; #100;
        {op, funct, zero} = 9'b111_0000_0; #100;
        {op, funct, zero} = 9'b110_0000_0; #100;
        {op, funct, zero} = 9'b000_0101_0; #100;

        //{op, funct, zero} = 9'b000_0000_0; #100;
        //{op, funct, zero} = 9'b000_0000_0; #100;
        //{op, funct, zero} = 9'b000_0000_0; #100;
        //{op, funct, zero} = 9'b000_0000_0; #100;
        //{op, funct, zero} = 9'b000_0000_0; #100;
        //{op, funct, zero} = 9'b000_0000_0; #100;
        //{op, funct, zero} = 9'b000_0000_0; #100;
        //{op, funct, zero} = 9'b000_0000_0; #100;

        // Test undefined or edge cases
        //{op, funct, zero} = 9'bxxx_xxxx_0; #100;
        //{op, funct, zero} = 9'bxxx_xxxx_1; #100;

        // Finish simulation
        $finish;
    end

    // Monitor changes and print them
    initial begin
        $monitor("At time %t, op = %b, funct = %b, zero = %b, memtoreg = %b, memwrite = %b, pcsrc = %b, alusrc = %b, regdst = %b, regwrite = %b, jump = %b, alucontrol = %b",
                 $time, op, funct, zero, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);
    end

endmodule
`endif
