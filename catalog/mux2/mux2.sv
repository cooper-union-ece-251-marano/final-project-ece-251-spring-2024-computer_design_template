//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: mux2
//     Description: 2 to 1 multiplexer
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef MUX2
`define MUX2

`timescale 1ns/100ps

module mux2 #(
    parameter WIDTH = 16  // Set to 16 bits
)(
    input wire [WIDTH-1:0] A,  // input A
    input wire [WIDTH-1:0] B,  // input B
    input wire sel,            // 1 bit select 
    output wire [WIDTH-1:0] Y  // output Y 
);

    // MODULE DESIGN IMPLEMENTATION
    assign Y = sel ? B : A;  // Y is B when select is 1, A when select is 0

endmodule

`endif // MUX2