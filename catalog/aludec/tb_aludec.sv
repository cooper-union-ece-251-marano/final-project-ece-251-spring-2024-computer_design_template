//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Isabel Zulawski & Siann Han
// 
//     Create Date: 2024-05-28
//     Module Name: tb_aludec
//     Description: Test bench for simple behavorial ALU decoder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

`ifndef TB_ALUDEC
`define TB_ALUDEC

`include "aludec.sv"

module tb_aludec;
   // parameter n = 32;

    // DUT port definitions
    reg [3:0] op; 
    wire [3:0] alu_control;
   	reg [3:0] expected_controls [15:0];
    reg [3:0] expected_alu_control;
    // Instantiate
    aludec dut (
        .op(op),
        .alu_control(alu_control)
    );

    //display
    task display_results;
        input [3:0] test_op;
        input [3:0] expected_control;
        input [3:0] actual_control;
        begin
          $display("Opcode: %b, Expected ALU Control: %b, Actual ALU Control: %b", test_op, expected_control, actual_control);
        end
    endtask
    
    initial begin
      
        expected_controls[0] = 4'b0000; // AND
        expected_controls[1] = 4'b0001; // OR
        expected_controls[2] = 4'b0010; // ADD
        expected_controls[3] = 4'b0011; // NOR
        expected_controls[4] = 4'b0100; // XOR
        expected_controls[5] = 4'b0101; // Sign extension
        expected_controls[6] = 4'b0110; // SUB
        expected_controls[7] = 4'b0111; // SLT
        expected_controls[8] = 4'b1000; // none
        expected_controls[9] = 4'b1001; // MUL
        expected_controls[10] = 4'b1010; // SLL
        expected_controls[11] = 4'b1011; // SGT
        expected_controls[12] = 4'b1100; // CLO/CLZ
        expected_controls[13] = 4'b1101; // ROTR/SRL
        expected_controls[14] = 4'b1110; // SLTU
        expected_controls[15] = 4'b1111; // SRA

        for (int i = 0; i <= 15; i = i + 1) begin
          
          op = i;
          expected_alu_control = expected_controls[i];
          #10;
            display_results(op, expected_alu_control, alu_control);
        end

        $finish;
    end

endmodule

`endif // TB_ALUDEC