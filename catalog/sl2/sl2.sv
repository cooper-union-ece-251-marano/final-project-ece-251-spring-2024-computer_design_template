//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: sl2
//     Description: shift left by 2 (multiply by 4)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef SL2
`define SL2

`timescale 1ns/100ps

module sl2 #(
    parameter WIDTH = 16,  // input and output widths
    parameter SHIFT = 1    // Desired shift amount
)(
    input wire [WIDTH-1:0] in,  // input in
    output wire [WIDTH-1:0] out // output out
);

    
    // Shift the input left by desired amount positions
    assign out = in << SHIFT;

endmodule

`endif // SL2
