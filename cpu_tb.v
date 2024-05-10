`timescale 1 ns / 1 ns
`include "instr_mem.v"
`include "instr_decoder.v"
`include "pc_assign.v"
`include "pc_adder.v"
`include "jump_adder.v"
`include "br_and_confirm.v"
`include "pc_mux.v"
`include "immediate.v"
`include "control.v"
`include "alu_ctrl.v"
`include "alu.v"
`include "alu_mux.v"
`include "data_mem.v"
`include "reg_file.v"
`include "wda_mux.v"

module pc_instr_tb();
    reg CLK;
    reg rst;
    wire[31:0] rda;
    wire[31:0] rdb;
    wire[31:0] rdx;
    wire[31:0] wda;
    wire[31:0] read_mem;
    wire confirm;
    wire pc_sel;
    wire alu_src;
    wire mem_to_reg;
    wire reg_wrt;
    wire mem_rd;
    wire mem_wrt;
    wire br;
    wire[3:0] alu_decode;
    wire[3:0] alu_op;
    wire[31:0] pc_addr;
    wire[31:0] jump_addr;
    wire[31:0] true_pc;
    wire[31:0] pc;
    wire[31:0] instr;
    wire[6:0] opcode;
    wire[4:0] rs1;
    wire[4:0] rs2;
    wire[4:0] rd;
    wire[31:0] imm_ex;
    wire[31:0] result;


    pc_adder U1(pc, pc_addr);
    jump_adder U2(imm_ex, pc, jump_addr);
    br_and_confirm U3(br, confirm, pc_sel);
    pc_mux U4(pc_addr, jump_addr, pc_sel, true_pc);
    pc_assign U5(pc, true_pc, CLK, rst);
    instr_mem U6(pc, instr);
    instr_decoder U7(instr, opcode, rs1, rs2, rd);
    immediate U8(instr, imm_ex);
    control U9(opcode, alu_src, mem_to_reg, reg_wrt, mem_rd, mem_wrt, br, alu_op);
    alu_ctrl U10(instr, alu_op, alu_decode);
    alu U11(alu_decode, rda, rdx, confirm, result);
    alu_mux U12(rdb, imm_ex, rdx, alu_src);
    reg_file U13(rs1, rs2, rd, wda, reg_wrt, rda, rdb, CLK);
    data_mem U14(result, mem_rd, mem_wrt, CLK, read_mem, rdb);
    wda_mux U15(mem_to_reg, read_mem, result, wda);

    initial begin
        CLK <= 0;
        forever
            begin
                #40;
                CLK = ~CLK;
            end
    end

    initial begin
        $dumpfile("cpu_tb.vcd");
        $dumpvars(0, pc_instr_tb);
        #10;
        #20;
        rst = 1'b1;
        #20;
        #80;
        rst = 1'b0;
        $display("Instruction 1");
        $display("pc: ", pc);
        $display("rs1: ", rs1);
        $display("rd: ", rd);
        $display("imm_ex: ", imm_ex);
        $display("result: ", result);
        $display("wda: ", wda);
        $display("reg_wrt: ", reg_wrt);
        $display("al_src: ", alu_src);
        $display(" ");
        #80;
        $display("Instruction 2");
        $display("pc: ", pc);
        $display("rs1: ", rs1);
        $display("rd: ", rd);
        $display("imm_ex: ", imm_ex);
        $display("result: ", result);
        $display("wda: ", wda);
        $display("reg_wrt: ", reg_wrt);
        $display("alu_src: ", alu_src);
        $display(" ");
        #80;
        $display("Instruction 3");
        $display("pc: ", pc);
        $display("rs1: ", rs1);
        $display("rs2: ", rs2);
        $display("rd: ", rd);
        $display("result: ", result);
        $display("wda: ", wda);
        $display("reg_wrt: ", reg_wrt);
        $display("alu_src: ", alu_src);
        $display(" ");
        #80;
        $display("Instruction 4");
        $display("pc: ", pc);
        $display("rs1: ", rs1);
        $display("rs2: ", rs2);
        $display("rd: ", rd);
        $display("imm_ex: ", imm_ex);
        $display("result: ", result);
        $display("wda: ", wda);
        $display("mem_wrt: ", mem_wrt);
        $display("alu_src: ", alu_src);
        $display(" ");
        #80;
        $display("Instruction 5");
        $display("pc: ", pc);
        $display("rs1: ", rs1);
        $display("rs2: ", rs2);
        $display("rd: ", rd);
        $display("imm_ex: ", imm_ex);
        $display("result: ", result);
        $display("read mem: ", read_mem);
        $display("mem_rd: ", mem_rd);
        $display("wda: ", wda);
        $display("alu_src: ", alu_src);
        $display(" ");
        #20
        #1000000;
        $display("Instruction 6");
        $display("pc: ", pc);
        $display("rs1: ", rs1);
        $display("rs2: ", rs2);
        $display("rd: ", rd);
        $display("imm_ex: ", imm_ex);
        $display("result: ", result);
        $display("br control: ", br);
        $display("alu flag: ", confirm);
        $display("wda: ", wda);
        $display("pc_sel: ", pc_sel);
        $display(" ");
        #40;
        $display("Final pc: ", pc);
        $finish;
    end
endmodule