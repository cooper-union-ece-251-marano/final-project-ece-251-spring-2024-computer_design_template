//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: signext
//     Description: 16 to 32 bit sign extender
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef SIGNEXT
`define SIGNEXT

`timescale 1ns/100ps
module signext(
    input logic [7:0] a,    // 8-bit input
    output logic [15:0] y   // 16-bit sign-extended output
    );

    // Sign-extension operation
    // The 8 most significant bits (MSBs) of 'y' are filled with the sign bit of 'a'
    // The 8 least significant bits (LSBs) of 'y' are the original input bits
    assign y = {{8{a[7]}}, a};

endmodule
/*
module signext #(
    parameter IN_WIDTH = 1,  // Input can be just 1 bit
    parameter OUT_WIDTH = 16  // Output can be up to 32 bits
)(
    input wire [IN_WIDTH-1:0] in,    // input in
    output wire [OUT_WIDTH-1:0] out  // output out
);

    // Make sure that output width > input width or we have a problem
    initial begin
        if (OUT_WIDTH <= IN_WIDTH) begin
            $error("OUT_WIDTH must be greater than IN_WIDTH.");
            $finish;
        end
    end

    assign out = {{(OUT_WIDTH-IN_WIDTH){in[IN_WIDTH-1]}}, in};

endmodule
*/
`endif // SIGNEXT
