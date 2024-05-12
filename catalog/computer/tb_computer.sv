//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: tb_computer
//     Description: Test bench for a single-cycle MIPS computer
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_COMPUTER
`define TB_COMPUTER

`timescale 1ns/100ps

`include "computer.sv"
`include "../clock/clock.sv"

module tb_computer;

    parameter n = 16; // # bits to represent the instruction / ALU operand / general purpose register (GPR)
    parameter m = 3;  // # bits to represent the address of the 2**m=32 GPRs in the CPU
    logic clk;
    logic clk_enable;
    logic reset;
    logic memwrite;
    logic [15:0] writedata;
    logic [15:0] dataadr;


    // Instantiate the CPU as the device to be tested
    computer dut(clk, reset, writedata, dataadr, memwrite);
    clock dut1(.ENABLE(clk_enable), .CLOCK(clk));

    initial begin

        //run fibonacci => currently set to find 9th fibonacci number
        $readmemb("exe/fib_exe", dut.imem.RAM);
        
        //run leaf
        //$readmemb("exe/leaf_exe", dut.imem.RAM);
        
        $dumpfile("tb_computer.vcd");
        $dumpvars(0, dut, clk, reset, writedata, dataadr, memwrite);
        $monitor("t=%t PC=0x%h  INSTR=0x%h (%b) OP=%b ra1=0x%h ra2=0x%h wa3=0x%h wd3=0x%h rd1=0x%h rd2=0x%h srca=0x%h srcb=0x%h alucontrol=0x%h aluout=0x%h zero=%b, write data: %d",
            $time, dut.mips.pc, dut.mips.instr, dut.mips.instr, dut.mips.c.md.op,
            dut.mips.dp.rf.ra1, dut.mips.dp.rf.ra2, dut.mips.dp.rf.wa3, dut.mips.dp.rf.wd3,
            dut.mips.dp.rf.rd1, dut.mips.dp.rf.rd2,
            dut.mips.dp.srca, dut.mips.dp.srcb, dut.mips.dp.alucontrol, dut.mips.dp.aluout, dut.mips.dp.zero, dut.mips.dp.rf.wd3);

        // Initialize simulation
        reset <= 1'b1; // Reset the system
        #10 reset <= 1'b0;
    end

    initial begin
        #0 clk_enable <= 0;
        #0 reset <= 1;
        
        #10 clk_enable <= 1;
        #10 reset <= 0;

        //uncomment this if you're running leaf_exe
        //#250 $finish();

    end
    
    
    always @(negedge clk or posedge clk) begin
        if (memwrite) begin
            if (dataadr === 0) begin
                $display("Address: %h", dataadr);
                $display("Output (hex): %h", writedata);
                $display("Output (dec): %d", writedata);
                $finish();
            end
        end
    end
    
endmodule

`endif
