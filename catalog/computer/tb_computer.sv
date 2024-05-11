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

/*
    parameter n = 16; // # bits to represent the instruction / ALU operand / general purpose register (GPR)
    parameter m = 3;  // # bits to represent the address of the 2**m=32 GPRs in the CPU
    logic clk;
    logic clk_enable;
    logic reset;
    logic memwrite;
    logic [15:0] writedata;
    logic [15:0] dataadr;

    logic firstTest, secondTest;

    // instantiate the CPU as the device to be tested
    computer dut(clk, reset, writedata, dataadr, memwrite);
    // generate clock to sequence tests
    // always
    //   begin
    //     clk <= 1; # 5; clk <= 0; # 5;
    //   end

    // instantiate the clock
    clock dut1(.ENABLE(clk_enable), .CLOCK(clk));

    initial begin
        // firstTest = 1'b0;
        // secondTest = 1'b0;
        $readmemb("exe/our_test_exe", dut.imem.RAM);
        $dumpfile("tb_computer.vcd");
        $dumpvars(0, dut, clk, reset, writedata, dataadr, memwrite);
        //$monitor("t=%t writedata=0x%4h dataadr=%4d memwrite%1d", $realtime, writedata, dataadr, memwrite);
        $monitor("t=%t PC=0x%h  INSTR=0x%h (%b) OP=%b ra1=0x%h ra2=0x%h wa3=0x%h wd3=0x%h rd1=0x%h rd2=0x%h srca=0x%h srcb=0x%h aluout=0x%h zero=%b, pcsrc=%b, pcnextbr=%b, signimmsh=%b, pcbr=%b",
            $time, dut.mips.pc, dut.mips.instr, dut.mips.instr, dut.mips.c.md.op,
            dut.mips.dp.rf.ra1, dut.mips.dp.rf.ra2, dut.mips.dp.rf.wa3, dut.mips.dp.rf.wd3,
            dut.mips.dp.rf.rd1, dut.mips.dp.rf.rd2,
            dut.mips.dp.srca, dut.mips.dp.srcb, dut.mips.dp.aluout, dut.mips.dp.zero, dut.mips.dp.pcsrc, dut.mips.dp.pcnextbr, dut.mips.dp.signimmsh, dut.mips.dp.pcbranch);
            //dut.mips.dp.alu.a, dut.mips.dp.alu.b, dut.mips.dp.alu.alu_control, dut.mips.dp.alu.result, dut.mips.dp.alu.zero);
    end

    // initialize test
*/
    
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
        //$readmemb("exe/progs", dut.imem.RAM);
        $readmemb("exe/fib1_exe", dut.imem.RAM);
        $dumpfile("tb_computer.vcd");
        $dumpvars(0, dut, clk, reset, writedata, dataadr, memwrite);
        $monitor("t=%t PC=0x%h  INSTR=0x%h (%b) OP=%b ra1=0x%h ra2=0x%h wa3=0x%h wd3=0x%h rd1=0x%h rd2=0x%h srca=0x%h srcb=0x%h alucontrol=0x%h aluout=0x%h zero=%b",
            $time, dut.mips.pc, dut.mips.instr, dut.mips.instr, dut.mips.c.md.op,
            dut.mips.dp.rf.ra1, dut.mips.dp.rf.ra2, dut.mips.dp.rf.wa3, dut.mips.dp.rf.wd3,
            dut.mips.dp.rf.rd1, dut.mips.dp.rf.rd2,
            dut.mips.dp.srca, dut.mips.dp.srcb, dut.mips.dp.alucontrol, dut.mips.dp.aluout, dut.mips.dp.zero);

        // Initialize simulation
        reset <= 1'b1; // Reset the system
        #10 reset <= 1'b0;
    end

    /*always begin
        clk <= 1'b0; #5;
        clk <= 1'b1; #5;
    end*/

    initial begin
        #0 clk_enable <= 0;
        #0 reset <= 1;
        
        #10 clk_enable <= 1;
        #10 reset <= 0;

        //#150

        //$display("Address: %h", dut.mips.dp.wa3);
        //$display("Output (hex): %h", writedata);

        //$finish;
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
    

    // monitor what happens at posedge of clock transition
    // always @(posedge clk) begin
    //     $display("+");
        // Display relevant debug information (update as necessary)
       // $display("\t+$t0 = 0x%4h", dut.mips.dp.rf.rf[7]); // Example of accessing a register
        // $display("writedata\tdataadr\tmemwrite");
    // end

    // run program
    // monitor what happens at negedge of clock transition
    // always @(negedge clk) begin
    //     $display("-");
        // Display relevant debug information (update as necessary)
        // $display("\t-$t0 = 0x%4h", dut.mips.dp.rf.rf[7]); // Example of accessing a register
        // $display("writedata\tdataadr\tmemwrite");
    // end

//    always @(negedge clk, posedge clk) begin
//      $display("R0=0x%h  R1=0x%h R2=0x%h", dut.mips.datapath.rf, dut.mips.datapath.rf, dut.mips.datapath.rf);

        // check results
        // if (dut.dmem.RAM[84] === 16'h0096) begin
        //     $display("Successfully wrote 0x%4h at RAM[%3d]", writedata, dataadr);
        //     firstTest = 1'b1;
        // end
        // if (firstTest === 1'b1) begin
        //     $display("Program successfully completed");
        //     $finish;
        // end
//    end

endmodule

`endif
    /*
  initial begin
    firstTest = 1'b0;
    secondTest = 1'b0;
    $dumpfile("tb_computer.vcd");
    $dumpvars(0,dut1,clk,reset,writedata,dataadr,memwrite);
    $monitor("t=%t\t0x%7h\t%7d\t%8d",$realtime,writedata,dataadr,memwrite);
    // $dumpvars(0,clk,a,b,ctrl,result,zero,negative,carryOut,overflow);
    // $display("Ctl Z  N  O  C  A                    B                    ALUresult");
    // $monitor("%3b %b  %b  %b  %b  %8b (0x%2h;%3d)  %8b (0x%2h;%3d)  %8b (0x%2h;%3d)",ctrl,zero,negative,overflow,carryOut,a,a,a,b,b,b,result,result,result);
  end

  // initialize test
  initial begin
    #0 clk_enable <= 0; #50 reset <= 1; # 50; reset <= 0; #50 clk_enable <= 1;
    #100 $finish;
  end

  // monitor what happens at posedge of clock transition
  always @(posedge clk)
  begin
      $display("+");
      $display("\t+instr = 0x%8h",dut.instr);
      $display("\t+op = 0b%6b",dut.mips.c.op);
      $display("\t+controls = 0b%9b",dut.mips.c.md.controls);
      $display("\t+funct = 0b%6b",dut.mips.c.ad.funct);
      $display("\t+aluop = 0b%2b",dut.mips.c.ad.aluop);
      $display("\t+alucontrol = 0b%3b",dut.mips.c.ad.alucontrol);
      $display("\t+alu result = 0x%8h",dut.mips.dp.alu.result);
      $display("\t+HiLo = 0x%8h",dut.mips.dp.alu.HiLo);
      $display("\t+$v0 = 0x%4h",dut.mips.dp.rf.rf[2]);
      $display("\t+$v1 = 0x%4h",dut.mips.dp.rf.rf[3]);
      $display("\t+$a0 = 0x%4h",dut.mips.dp.rf.rf[4]);
      $display("\t+$a1 = 0x%4h",dut.mips.dp.rf.rf[5]);
      $display("\t+$t0 = 0x%4h",dut.mips.dp.rf.rf[8]);
      $display("\t+$t1 = 0x%4h",dut.mips.dp.rf.rf[9]);
      $display("\t+regfile -- ra1 = %d",dut.mips.dp.rf.ra1);
      $display("\t+regfile -- ra2 = %d",dut.mips.dp.rf.ra2);
      $display("\t+regfile -- we3 = %d",dut.mips.dp.rf.we3);
      $display("\t+regfile -- wa3 = %d",dut.mips.dp.rf.wa3);
      $display("\t+regfile -- wd3 = %d",dut.mips.dp.rf.wd3);
      $display("\t+regfile -- rd1 = %d",dut.mips.dp.rf.rd1);
      $display("\t+regfile -- rd2 = %d",dut.mips.dp.rf.rd2);
      $display("\t+RAM[%4d] = %4d",dut.dmem.addr,dut.dmem.readdata);
      $display("writedata\tdataadr\tmemwrite");
  end

  // run parogram
  // monitor what happens at negedge of clock transition
  always @(negedge clk) begin
    $display("-");
    $display("\t-instr = 0x%8h",dut.instr);
    $display("\t-op = 0b%6b",dut.mips.c.op);
    $display("\t-controls = 0b%9b",dut.mips.c.md.controls);
    $display("\t-funct = 0b%6b",dut.mips.c.ad.funct);
    $display("\t-aluop = 0b%2b",dut.mips.c.ad.aluop);
    $display("\t-alucontrol = 0b%3b",dut.mips.c.ad.alucontrol);
    $display("\t-alu result = 0x%8h",dut.mips.dp.alu.result);
    $display("\t-HiLo = 0x%8h",dut.mips.dp.alu.HiLo);
    $display("\t-$v0 = 0x%4h",dut.mips.dp.rf.rf[2]);
    $display("\t-$v1 = 0x%4h",dut.mips.dp.rf.rf[3]);
    $display("\t-$a0 = 0x%4h",dut.mips.dp.rf.rf[4]);
    $display("\t-$a1 = 0x%4h",dut.mips.dp.rf.rf[5]);
    $display("\t-$t0 = 0x%4h",dut.mips.dp.rf.rf[8]);
    $display("\t-$t1 = 0x%4h",dut.mips.dp.rf.rf[9]);
    $display("\t-regfile -- ra1 = %d",dut.mips.dp.rf.ra1);
    $display("\t-regfile -- ra2 = %d",dut.mips.dp.rf.ra2);
    $display("\t-regfile -- we3 = %d",dut.mips.dp.rf.we3);
    $display("\t-regfile -- wa3 = %d",dut.mips.dp.rf.wa3);
    $display("\t-regfile -- wd3 = %d",dut.mips.dp.rf.wd3);
    $display("\t-regfile -- rd1 = %d",dut.mips.dp.rf.rd1);
    $display("\t-regfile -- rd2 = %d",dut.mips.dp.rf.rd2);
    $display("\t+RAM[%4d] = %4d",dut.dmem.addr,dut.dmem.readdata);
    $display("writedata\tdataadr\tmemwrite");
  end

  always @(negedge clk, posedge clk) begin
    // check results
    // TODO: You need to update the checks below
    // if (dut.dmem.RAM[84] === 32'h9504)
    //   begin
    //     $display("Successfully wrote 0x%4h at RAM[%3d]",84,32'h9504);
    //     firstTest = 1'b1;
    //   end

    if (dut.dmem.RAM[84] === 32'h96)
      begin
        $display("Successfully wrote 0x%4h at RAM[%3d]",84,32'h0096);
        firstTest = 1'b1;
      end
    if(memwrite) begin
      if(dataadr === 84 & writedata === 32'h96)
      begin
        $display("Successfully wrote 0x%4h at RAM[%3d]",writedata,dataadr);
        firstTest = 1'b1;
      end
    end
    if (firstTest === 1'b1)
    begin
        $display("Program successfully completed");
        $finish;
    end
  end

endmodule

`endif // TB_COMPUTER
*/
