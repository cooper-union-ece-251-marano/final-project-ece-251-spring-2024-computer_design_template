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
`timescale 1ns/100ps

module tb_maindec;
    // Inputs to the maindec module
    reg [3:0] op;
    
    // Outputs from the maindec module
    wire memtoreg, memwrite;
    wire branch, alusrc;
    wire regdst, regwrite;
    wire jump;
    wire aluop;

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

    // Test procedure
    initial begin
        // Initialize Inputs
        op = 0;
        
        // Wait for global reset
        #100;

        // Monitor changes on control signals
        $monitor("At time %t, opcode: %b | memtoreg: %b, memwrite: %b, branch: %b, alusrc: %b, regdst: %b, regwrite: %b, jump: %b, aluop: %b",
                  $time, op, memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, aluop);

        // Test each opcode
        #10 op = 4'b0000; // RTYPE
        #10 op = 4'b0001; // LW
        #10 op = 4'b0010; // SW
        #10 op = 4'b0011; // BEQ
        #10 op = 4'b0100; // ADDI
        #10 op = 4'b0101; // J
        // ... Add more tests for other instructions

        // End the testbench
        #10 $finish;
    end

endmodule

