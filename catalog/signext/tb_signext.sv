//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: tb_signext
//     Description: Test bench for sign extender
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_SIGNEXT
`define TB_SIGNEXT

`timescale 1ns/100ps
`include "signext.sv"

module tb_signext;

    // Testbench signals
    reg [7:0] a;                 // 8-bit input to the sign extender
    wire [15:0] y;               // 16-bit output from the sign extender

    // Instantiate the sign extender
    signext uut (
        .a(a),
        .y(y)
    );

    // Initial block for simulation
    initial begin
        // Initialize the input
        a = 0;
        #10;     // Wait for 10 ns

        // Apply test vectors
        // Test a positive value
        a = 8'd127;  // Maximum positive value for 8-bit
        #10;
        $display("Input: %b, Output: %b", a, y);

        // Test a negative value
        a = 8'b10000001;  // -127 in two's complement
        #10;
        $display("Input: %b, Output: %b", a, y);

        // Test zero
        a = 8'd0;  // Zero
        #10;
        $display("Input: %b, Output: %b", a, y);

        // Test most negative value
        a = 8'b10000000;  // -128 in two's complement
        #10;
        $display("Input: %b, Output: %b", a, y);

        // Finish the simulation
        $finish;
    end

endmodule
/*

module tb_signext;

    parameter IN_WIDTH = 1;  // Input width of number
    parameter OUT_WIDTH = 16; // Output width desired
    reg [IN_WIDTH-1:0] in;    // input in
    wire [OUT_WIDTH-1:0] out; // output out

    // UTT
    signext #(.IN_WIDTH(IN_WIDTH), .OUT_WIDTH(OUT_WIDTH)) uut(
        .in(in),
        .out(out)
    );

   // Start test
    initial begin
        $dumpfile("tb_signext.vcd"); 
        $dumpvars(0, tb_signext);    

        
        // Test some cases to enure it works for a range of values 
        in = 0;
        #10; // Let the output settle
        for (int i = -2; i <= 2; i++) begin
            in = i; // Apply input vector
            #10;    // Wait for 10 time units
        end

        // Test the boundary case where the sign bit flips just to make sure
        in = {1'b1, {(IN_WIDTH-1){1'b0}}}; // Smallest negative number
        #10;
        in = {1'b0, {(IN_WIDTH-1){1'b1}}}; // Largest positive number
        #10;

        // Finish simulation
        $finish;
    end

    // Monitor signals and display changes
    initial begin
        $monitor("Time = %0t | in = %b | out = %b", $time, in, out);
    end

endmodule*/
`endif // TB_SIGNEXT
