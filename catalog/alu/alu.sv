//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Isabel Zulawski & Siann Han
// 
//     Create Date: 2024-05-28
//     Module Name: alu
//     Description: 16-bit RISC-based CPU alu (MIPS)
//
// Revision: 1.0
// Based on https://github.com/Caskman/MIPS-Processor-in-Verilog/blob/master/ALU32Bit.v
//////////////////////////////////////////////////////////////////////////////////
`ifndef ALU
`define ALU

`timescale 1ns/100ps

module ALU16Bit #(parameter n = 16) (
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input [3:0] alu_control, 
    input [n-1:0] A, B, 
    output reg [n-1:0] alu_result, 
    output reg Zero // Zero=1 if alu_result == 0
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //

    integer i;
    reg [n-1:0] y; // temp reg

    always @(alu_control, A, B) begin
        case (alu_control)
            0: alu_result <= A & B; // AND
            1: alu_result <= A | B; // OR
            2: alu_result <= A + B; // ADD
            6: alu_result <= A + (~B + 1); // SUB 
            7: alu_result <= (A < B) ? 1 : 0; // SLT 
            3: alu_result <= ~(A | B); // NOR
            8: begin //none
                end
            9: alu_result <= A * B; // MUL
            10: alu_result <= A << B; // SLL 
            11: alu_result <= (A > B) ? 1 : 0; // SGT 
            12: begin // CLO (Count Leading Ones) / CLZ (Count Leading Zeroes)
                integer count;
                alu_result = 0;
                if (B == 0) begin // CLO
                    count = 0;
                    for (i = n - 1; i >= 0; i = i - 1) begin
                        if (A[i] == 1) begin
                            count = n - 1 - i;
                            alu_result = count;
                            i = -1; // terminate loop
                        end
                    end
                end else begin // CLZ
                    count = 0;
                    for (i = n - 1; i >= 0; i = i - 1) begin
                        if (A[i] == 0) begin
                            count = n - 1 - i;
                            alu_result = count;
                            i = -1; // terminate 
                        end
                    end
                end
            end
            13: begin // ROTR & SRL (rotate right / logical right shift)
                y = A;
                for (i = 0; i < B; i = i + 1) begin
                    if (B[n-1]) begin
                        // ROTR
                        y = {y[0], y[n-1:1]};
                    end else begin
                        // SRL
                        y = {1'b0, y[n-1:1]};
                    end
                end
                alu_result = y;
            end
            4: alu_result <= A ^ B; // XOR
            14: alu_result <= A < B; // SLTU 
            5: begin // Sign Extension
                if (B == 0) begin // Byte (8-bit sign extension)
                    alu_result <= {{8{A[7]}}, A[7:0]};
                end else if (B == 1) begin // Half-word (16-bit sign extension)
                    alu_result <= {{8{A[15]}}, A[15:0]};
                end
            end
            15: alu_result <= (A >> B) | ({n{A[n-1]}} << (n - B)); // SRA (Arithmetic right shift)
        endcase
    end

    // Check if alu_result is zero 
    always @(alu_result) begin
        Zero <= (alu_result == 0) ? 1 : 0;
    end

endmodule

`endif // ALU
