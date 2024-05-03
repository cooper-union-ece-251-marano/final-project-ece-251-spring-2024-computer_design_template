//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: tb_sl2
//     Description: Test bench for shift left by 2 (multiply by 4)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_SL2
`define TB_SL2

`timescale 1ns/100ps
`include "sl2.sv"

module tb_sll;

    parameter WIDTH = 16;   // Width of the input and output for test
    parameter SHIFT = 1;   // shift one position
    reg [WIDTH-1:0] in;    // input in
    wire [WIDTH-1:0] out;  // output out

    // UTT
    sl2 #(.WIDTH(WIDTH), .SHIFT(SHIFT)) uut(
        .in(in),
        .out(out)
    );

    // Start test
    initial begin
        $dumpfile("tb_sll.vcd"); 
        $dumpvars(0, tb_sll);    

        // Loop through all possible combinations
        for (int i = 0; i < (1 << WIDTH); i++) begin
            in = i;
            #10;  // Wait 
        end

        
        $finish;
    end

    // Monitor output
    initial begin
        $monitor("Time = %0t | in = %b | out = %b", $time, in, out);
    end

endmodule
`endif // TB_SL2
