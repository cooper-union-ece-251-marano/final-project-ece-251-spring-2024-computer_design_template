//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Isabel Zulawski and Siann Han
// 
//     Create Date: 2024-05-28
//     Module Name: tb_alu
//     Description: Test bench for simple behavioral ALU
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_ALU
`define TB_ALU

`include "alu.sv"

module ALU16Bit_tb;

    parameter n = 16; 
    reg [3:0] alu_control;
    reg [n-1:0] A, B;
    wire [n-1:0] alu_result;
    wire Zero;

    // Instantiate
    ALU16Bit #(n) uut (
        .alu_control(alu_control),
        .A(A),
        .B(B),
        .alu_result(alu_result),
        .Zero(Zero)
    );

    // Display results
    task display_result;
        input [3:0] alu_control;
        input [n-1:0] A, B, alu_result;
        input Zero;
        begin
            $display("alu_control: %b, A: %h, B: %h, alu_result: %h, Zero: %b", alu_control, A, B, alu_result, Zero);
        end
    endtask

    // Test bench
    initial begin
        // Test case: AND operation
        alu_control = 4'd0; // alu_control = 0 for AND
        A = 16'hAAAA; // Example input A
        B = 16'h5555; // Example input B
        #10; // Wait for 10 ns for the operation to take effect
        display_result(alu_control, A, B, alu_result, Zero);

        // Test case: OR operation
        alu_control = 4'd1; // alu_control = 1 for OR
        A = 16'h1234;
        B = 16'h5678;
        #10;
        display_result(alu_control, A, B, alu_result, Zero);

        // Test case: ADD operation
        alu_control = 4'd2; // alu_control = 2 for ADD
        A = 16'h1000;
        B = 16'h2000;
        #10;
        display_result(alu_control, A, B, alu_result, Zero);

        // Test case: SUB operation
        alu_control = 4'd6; // alu_control = 6 for SUB
        A = 16'h2000;
        B = 16'h1000;
        #10;
        display_result(alu_control, A, B, alu_result, Zero);

        // Test case: SLT operation
        alu_control = 4'd7; // alu_control = 7 for SLT
        A = 16'h1234;
        B = 16'h5678;
        #10;
        display_result(alu_control, A, B, alu_result, Zero);

        // Test case: NOR operation
        alu_control = 4'd3; // alu_control = 3 for NOR
        A = 16'hFFFF; // All bits set
        B = 16'h0000; // All bits cleared
        #10;
        display_result(alu_control, A, B, alu_result, Zero);

        // Test case: MUL operation
        alu_control = 4'd9; // alu_control = 9 for MUL
        A = 16'h000F; // Example input A
        B = 16'h000A; // Example input B
        #10;
        display_result(alu_control, A, B, alu_result, Zero);

        // Test case: SLL operation
        alu_control = 4'd10; // alu_control = 10 for SLL
        A = 16'h0001; // Shift A left by B
        B = 16'h0004; // Shift amount
        #10;
        display_result(alu_control, A, B, alu_result, Zero);

        // Test case: SGT operation
        alu_control = 4'd11; // alu_control = 11 for SGT
        A = 16'h4321;
        B = 16'h1234;
        #10;
        display_result(alu_control, A, B, alu_result, Zero);

        // Test case: CLO/CLZ operation
        alu_control = 4'd12; // alu_control = 12 for CLO/CLZ
        A = 16'h00FF; // Example input A
        B = 16'h0; // CLO
        #10;
        display_result(alu_control, A, B, alu_result, Zero);
        // Test for CLZ
        B = 16'h1; // CLZ
        #10;
        display_result(alu_control, A, B, alu_result, Zero);

        // Test case: ROTR & SRL operation
        alu_control = 4'd13; // alu_control = 13 for ROTR & SRL
        A = 16'h1234;
        B = 16'h0003; // Rotate or shift by 3
        #10;
        display_result(alu_control, A, B, alu_result, Zero);

        // Test case: XOR operation
        alu_control = 4'd4; // alu_control = 4 for XOR
        A = 16'hF0F0;
        B = 16'h0F0F;
        #10;
        display_result(alu_control, A, B, alu_result, Zero);

        // Test case: SLTU operation
        alu_control = 4'd14; // alu_control = 14 for SLTU
        A = 16'hFFFF;
        B = 16'h0000;
        #10;
        display_result(alu_control, A, B, alu_result, Zero);

        // Test case: Sign Extension operation
        alu_control = 4'd5; // alu_control = 5 for Sign Extension
        A = 16'h00FF; // Example input A (byte to extend)
        B = 16'h0; // Extend byte
        #10;
        display_result(alu_control, A, B, alu_result, Zero);
        // Test for half-word
        B = 16'h1; // Extend half-word
        #10;
        display_result(alu_control, A, B, alu_result, Zero);

        // Test case: SRA operation
        alu_control = 4'd15; // alu_control = 15 for SRA
        A = 16'hF234; // Example input A
        B = 16'h0003; // Shift amount
        #10;
        display_result(alu_control, A, B, alu_result, Zero);

        $finish;
    end

endmodule

`endif // TB_ALU
