//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: datapath
//     Description: 32-bit RISC-based CPU datapath (MIPS)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef DATAPATH
`define DATAPATH

`timescale 1ns/100ps

`include "../regfile/regfile.sv"
`include "../alu/alu.sv"
`include "../dff/dff.sv"
`include "../adder/adder.sv"
`include "../sl2/sl2.sv"
`include "../mux2/mux2.sv"
`include "../signext/signext.sv"

module datapath
    #(parameter n = 16)(
    input  logic        clk, reset,
    input  logic        memtoreg, pcsrc,
    input  logic        alusrc, regdst,
    input  logic        regwrite, jump,
    input  logic [2:0]  alucontrol,
    output logic        zero,
    output logic [(n-1):0] pc,
    input  logic [(n-1):0] instr,
    output logic [(n-1):0] aluout, writedata,
    input  logic [(n-1):0] readdata
);
    logic [4:0]  writereg;
    logic [(n-1):0] pcnext, pcnextbr, pcplus2, pcbranch;
    logic [(n-1):0] signimm, signimmsh;
    logic [(n-1):0] srca, srcb;
    logic [(n-1):0] result;

    // Adjusted logic for 16 bit
    dff #(n)    pcreg(clk, reset, pcnext, pc);
    adder       pcadd1(pc, n'b10, pcplus2); // Increment PC by 2 for 16-bit instructions
    sl2         immsh(signimm, signimmsh);
    adder       pcadd2(pcplus2, signimmsh, pcbranch);
    mux2 #(n)   pcbrmux(pcplus2, pcbranch, pcsrc, pcnextbr);
    mux2 #(n)   pcmux(pcnextbr, {pcplus2[(n-1):12], instr[11:0], 2'b00}, jump, pcnext);

    // Simplified register file logic
    regfile     rf(clk, regwrite, instr[(n/2)-1:(n/4)], instr[(n/4)-1:0], writereg, result, srca, writedata);
    mux2 #(5)   wrmux(instr[(n/4)-1:0], instr[(n/2)-1:(n/4)], regdst, writereg);
    mux2 #(n)   resmux(aluout, readdata, memtoreg, result);
    signext     se(instr[(n/2)-1:0], signimm);

    // Simplified ALU logic
    mux2 #(n)   srcbmux(writedata, signimm, alusrc, srcb);
    alu         alu(clk, srca, srcb, alucontrol, aluout, zero);

endmodule

`endif // DATAPATH