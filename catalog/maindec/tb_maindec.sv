//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: YOUR NAMES
// 
//     Create Date: 2023-02-07
//     Module Name: tb_maindec
//     Description: Test bench for simple behavorial main decoder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_MAINDEC
`define TB_MAINDEC

`timescale 1ns/100ps
`include "maindec.sv"

module test_maindec;

    // Inputs
    reg [2:0] op;

    // Outputs
    wire memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump;
    wire [1:0] aluop;

    // Instantiate the Unit Under Test (UUT)
    maindec uut (
        .op(op), 
        .memtoreg(memtoreg), 
        .memwrite(memwrite),
        .branch(branch), 
        .alusrc(alusrc), 
        .regdst(regdst),
        .regwrite(regwrite), 
        .jump(jump),
        .aluop(aluop)
    );

    // Testbench logic
    initial begin
        // Initialize Inputs
        op = 0;

        // Wait for global reset
        #100;

        // Test each opcode in sequence
        op = 3'b000; #100; // R-type operation
        op = 3'b001; #100; // Load word
        op = 3'b010; #100; // Store word
        op = 3'b011; #100; // ADDI
        op = 3'b100; #100; // BEQ
        op = 3'b101; #100; // SLTI
        op = 3'b110; #100; // Jump
        op = 3'b111; #100; // Jump and link
        op = 3'bxxx; #100; // Test undefined opcode

        // Finish simulation
        $finish;
    end

    // Monitor changes and print them
    initial begin
        $monitor("At time %t, op = %b, memtoreg = %b, memwrite = %b, branch = %b, alusrc = %b, regdst = %b, regwrite = %b, jump = %b, aluop = %b", 
            $time, op, memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, aluop);
    end

endmodule
`endif //TB_MAINDEC
