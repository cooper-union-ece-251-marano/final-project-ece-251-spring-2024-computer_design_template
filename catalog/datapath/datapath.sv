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
    input  logic            clk, reset,
    input  logic            memtoreg, pcsrc,
    input  logic            alusrc, regdst,
    input  logic            regwrite, jump,
    input  logic [2:0]      alucontrol,
    input  logic [(15):0]   readdata,
    input  logic [(15):0]   instr,
    output logic            zero,
    output logic [(15):0]   pc,
    output logic [(15):0]   aluout, writedata
);
    logic [2:0]  writereg;
    logic [(15):0] pcnext, pcnextbr, pcplus2, pcbranch;
    logic [(15):0] signimm, signimmsh;
    logic [(15):0] srca, srcb;
    logic [(15):0] result;

    // always @(posedge clk) begin
    //     $display("Time: %t, Instruction: %b, srca: %d, srcb: %d, alucontrol: %b, aluout: %d, zero: %b, signimm: %d, readdata: %d, reg1: %b, reg2: %b",
    //         $time, instr, srca, srcb, alucontrol, aluout, zero, signimm, readdata,  instr[11:9], instr[7:5],);
    // end

    // Adjusted logic for 16 bit
    dff #(16)       pcreg(clk, reset, pcnext, pc);

    regfile         rf(clk, regwrite, instr[12:10], instr[9:7], writereg, result, srca, writedata);
    
    // pc + 2
    adder           pcadd1(pc, 16'b10, pcplus2); // Increment PC by 2 for 16-bit instructions
    
    
    // it shift lefts one *actually*
    signext         se({1'b0, instr[6:0]}, signimm);
    //sl2             immsh(signimm, signimmsh);
    adder           pcadd2(signimm, 16'b0, pcbranch);

    // branch mux
    mux2 #(16)      mux_branch(pcplus2, pcbranch, pcsrc, pcnextbr);
    
    // jump mux
    
    mux2 #(16)      mux_pc(pcnextbr, {pcplus2[15:13], instr[12:0]}, jump, pcnext);
    
    // reg write mux
    mux2 #(3)       mux_writereg(instr[9:7], instr[6:4], regdst, writereg);

    // mem to reg mux
    mux2 #(16)      mux_memreg(aluout, readdata, memtoreg, result);
    
    // alu mux
    mux2 #(16)      srcbmux(writedata, signimm, alusrc, srcb);

    // Simplified ALU logic
    alu             alu(srca, srcb, alucontrol, aluout, zero);

endmodule

`endif // DATAPATH
