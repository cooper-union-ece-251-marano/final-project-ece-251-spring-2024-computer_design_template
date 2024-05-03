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
    input logic [3:0] alu_control, // ALU control signals
    output logic [WIDTH-1:0] result, // Result of the computation
    output logic zero,              // Flag for zero result
    output logic [WIDTH-1:0] remainder // Remainder for division operation
);

    // Temporary registers for multiplication and division
    logic [2*WIDTH-1:0] mult_result;
    logic [WIDTH-1:0] div_result;

    // Perform operations based on the ALU control signal
    always @* begin
        case (alu_control)
            4'b0000: result = a + b;                      // Addition
            4'b0001: result = a - b;                      // Subtraction
            4'b0010: result = a & b;                      // AND
            4'b0011: result = a | b;                      // OR
            4'b0100: result = a ^ b;                      // XOR
            4'b0101: result = ~a;                         // NOT (dont use b if want to use this field)
            4'b0110: result = (a < b) ? 16'b1 : 16'b0;    // Set on less than (SLT)
            4'b0111: result = a << b[3:0];                // Logical shift left
            4'b1000: result = a >> b[3:0];                // Logical shift right
            4'b1001: begin                                // Multiply
                        mult_result = a * b;
                        result = mult_result[WIDTH-1:0];  // Lower half of result
                    end
            4'b1010: if (b != 0) begin                    // Divide
                        result = a / b;                   // Quotient
                        remainder = a % b;                // Remainder
                    end else begin
                        result = 16'b0;                   // Division by zero, undefined
                        remainder = 16'b0;
                    end
            4'b1111: result = a + b;       // where b is a constant
            default: result = 16'bx;       // Default case
        endcase
        zero = (result == 0);  // Set the zero flag if the result is 0
    end

endmodule

`endif // ALU
