//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: YOUR NAMES
// 
//     Create Date: 2023-02-07
//     Module Name: alu
//     Description: 32-bit RISC-based CPU alu (MIPS)
//
// Revision: 1.0
// see https://github.com/Caskman/MIPS-Processor-in-Verilog/blob/master/ALU32Bit.v
//////////////////////////////////////////////////////////////////////////////////
`ifndef ALU
`define ALU

`timescale 1ns/100ps

module alu #(
    parameter WIDTH = 16  // Parameter for the bit width of the ALU
)(
    input logic [WIDTH-1:0] a,     // First operand
    input logic [WIDTH-1:0] b,     // Second operand
    input logic [2:0] alu_control, // ALU control signals
    output logic [WIDTH-1:0] result, // Result of the computation
    output logic zero              // Flag for zero result
);

    // Perform operations based on the ALU control signal
    always @* begin
        case (alu_control)
            3'b000: result = a + b;                      // Addition
            3'b001: result = a - b;                      // Subtraction
            3'b010: result = a & b;                      // AND
            3'b011: result = a | b;                      // OR
            3'b100: result = (a < b) ? 16'b1 : 16'b0;    // Set on less than (SLT)
            3'b101: result = ~(a | b);                   // NOR
            default: result = 16'bx;       // Default case
        endcase
    end

    assign zero = (result == 0);  // Set the zero flag if the result is 0
endmodule

`endif // ALU
