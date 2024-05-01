//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Isabel Zulawski & Siann Han
// 
//     Create Date: 2024-05-28
//     Module Name: tb_clock
//     Description: Test bench for clock generator
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ns

module tb_clock;
    //
    // ---------------- DECLARATIONS OF PARAMETERS ----------------
    //
    parameter period = 10;

    //
    // ---------------- DECLARATIONS OF DATA TYPES ----------------
    //

    reg reset;
    reg enable;
    wire clk;


    //
    // ---------------- INITIALIZE TEST BENCH ----------------
    //

 //   initial begin
   //     $dumpfile("tb_clock.vcd"); // for Makefile, make dump file same as module name
     //   $dumpvars(0, dut);
   // end

    //
    // ---------------- APPLY INPUT VECTORS ----------------
    //

    initial begin
        reset = 1'b0;
        enable = 1'b0;

      // Test for 10 cycles when reset is low and enable is high
      $display("Time = %0t, clk = %b, reset = %b, enable = %b", $time, clk, reset, enable);
        reset = 1'b0;
        enable = 1'b1;
        repeat (10) begin
                #5; // half period = 5
       $display("Time = %0t, clk = %b, reset = %b, enable = %b", $time, clk, reset, enable);
        end
    
    // Test for 10 cycles when reset is high and enable is high
        reset = 1'b1;
        enable = 1'b1;
        repeat (10) begin
            #5;
            $display("Time = %0t, clk = %b, reset = %b, enable = %b", $time, clk, reset, enable);
        end

        // Test for 10 cycles when reset is low and enable is low
        reset = 1'b0;
        enable = 1'b0;
        repeat (10) begin
            #5;
            $display("Time = %0t, clk = %b, reset = %b, enable = %b", $time, clk, reset, enable);
        end

        //Test for 10 cycles when reset is high and enable is low
        reset = 1'b1;
        enable = 1'b0;
        repeat (10) begin
            #5;
            $display("Time = %0t, clk = %b, reset = %b, enable = %b", $time, clk, reset, enable);
        end
        // Terminate simulation
        #10 $finish;
    end

    //
    // ---------------- INSTANTIATE UNIT UNDER TEST (UUT) ----------------
    //
  clock #(.period(period)) clock_inst(.clk(clk), .reset(reset), .enable(enable));

endmodule
