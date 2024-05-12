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

module alu #(parameter n = 16)(
    input wire clk, // Clock input, used for synchronizing if needed
    input wire [3:0] alu_control,
    input wire [n - 1:0] A,
    input wire [n - 1:0] B,
    output reg [n - 1:0] alu_result,
    output reg Zero
);

    always @(*) begin // Using combinational logic block for immediate response
        case (alu_control)
            4'b0000: alu_result = A & B; // AND
            4'b0001: alu_result = A | B; // OR
            4'b0010: alu_result = A + B; // ADD
            4'b0110: alu_result = A - B; // SUB
            4'b0111: alu_result = (A < B) ? 1 : 0; // SLT
            4'b0011: alu_result = ~(A | B); // NOR
            4'b1001: alu_result = A * B; // MUL
            4'b1010: alu_result = A << B[3:0]; // SLL, B[3:0] to ensure we don't shift by too much
            4'b0100: alu_result = A ^ B; // XOR
            4'b1110: alu_result = (A < B) ? 1 : 0; // SLTU
            4'b1011: alu_result = (A > B) ? 1 : 0; // SGT
            4'b0101: begin // Sign Extension
                if (B == 0) begin // Byte
                    alu_result = {{8{A[7]}}, A[7:0]};
                end else if (B == 1) begin // Half-word
                    alu_result = {{8{A[15]}}, A[15:0]};
                end
            end
            4'b1111: alu_result = (A >> B[3:0]) | ({n{A[n - 1]}} << (n - B[3:0])); // SRA
            default: alu_result = 0; // Default case
        endcase

        Zero = (alu_result == 0);
    end
    
    // Optionally, you can still update on the clock if required for your specific CPU design
    // Comment or remove the following block if not needed
    always @(posedge clk) begin
        alu_result <= alu_result;
        Zero <= Zero;
    end

endmodule

`endif // ALU

