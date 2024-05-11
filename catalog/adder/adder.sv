//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Youngmin Kwon
// 
//     Create Date: 2023-02-07
//     Module Name: adder
//     Description: simple behavorial adder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef ADDER
`define ADDER

`timescale 1ns/100ps

module adder
    #(parameter n = 16)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  wire [n-1:0] a,
    input  wire [n-1:0] b,
    output wire [n-1:0] sum
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    assign sum = a + b;
endmodule

`endif // ADDER