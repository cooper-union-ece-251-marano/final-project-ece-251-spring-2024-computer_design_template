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

`timescale 1ns / 100ps

module tb_datapath;
    parameter n = 16;  // Assuming the datapath is configured for 16-bit operations

    // Inputs to the datapath
    reg clk, reset;
    reg memtoreg, pcsrc, alusrc, regdst, regwrite, jump;
    reg [3:0] alucontrol;
    reg [(n-1):0] instr, readdata;

    // Outputs from the datapath
    wire zero;
    wire [(n-1):0] pc, aluout, writedata;

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
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Clock with a period of 10 ns
    end

    // Test sequences
    initial begin
        // Initialize all inputs
        reset = 1; memtoreg = 0; pcsrc = 0; alusrc = 0;
        regdst = 0; regwrite = 0; jump = 0; alucontrol = 4'b000;
        instr = 0; readdata = 0;
        $monitor("Time=%t, clk=%b, reset=%b, aluout=%d, zero=%b, pc=%h, instr=%h, alucontrol=%b", 
             $time, clk, reset, aluout, zero, pc, instr, alucontrol);

        // Apply reset
        #10 reset = 0;

        // Define a test scenario
        // Example: Test simple addition
        instr = 16'h2801;  // Assuming an ADD instruction format
        alusrc = 1; regwrite = 1; regdst = 1; alucontrol = 4'b000;  // ALU should add
        readdata = 16'd5;
        
        // Enable register write for an R-type instruction
        #20;
        regwrite = 1;
        #10;
        regwrite = 0;  // Disable write to observe result stability

        // Check results and more tests can be added
        #100;
        if (aluout !== 16'd5) begin
            $display("Test failed: ALU output expected to be 5, got %d", aluout);
        end else begin
            $display("Test passed: ALU addition verified.");
        end

        $finish;  // Terminate simulation
    end

endmodule
`endif // TB_DATAPATH
