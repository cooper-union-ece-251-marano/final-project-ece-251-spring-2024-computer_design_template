//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: tb_mux2
//     Description: Test bench for 2 to 1 multiplexer
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_MUX2
`define TB_MUX2

`timescale 1ns/100ps
`include "mux2.sv"
`include "../clock/clock.sv"

module tb_mux_2to1;

    parameter WIDTH = 16;  // 8 bit 2-1 mux
    reg [WIDTH-1:0] a, b;  // inputs a and b
    reg sel;               // 1 bit select 
    wire [WIDTH-1:0] y;    // output Y 

   // UTT
    mux2 #(.WIDTH(WIDTH)) uut(
        .A(a), 
        .B(b), 
        .sel(sel), 
        .Y(y)
    );

    // Start test
    initial begin
        $dumpfile("tb_mux_2to1.vcd"); 
        $dumpvars(0, tb_mux_2to1);    

        for (int i = 0; i < 2**WIDTH; i++) begin
            // set select low, input a should be passed to output y
            sel = 0;
            a = i; b = ~i; #10;

            // set select high, input b should be passed to output y
            sel = 1;
            #10; 
        end

        $finish;
    end

    initial begin
        $monitor("Time = %t | a = %b | b = %b | sel = %b | y = %b", $time, a, b, sel, y);
    end

endmodule
`endif // TB_MUX2