//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: YOUR NAMES
// 
//     Create Date: 2023-02-07
//     Module Name: aludec
//     Description: 32-bit RISC ALU decoder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef ALUDEC
`define ALUDEC

`timescale 1ns/100ps

module aludec(
    input logic [3:0] funct,      // Function code part of the instruction (used mainly for R-type)
    input logic [1:0] aluop,      // ALU operation type from the control unit
    output logic [2:0] alucontrol // Control signals for the ALU
);

    wire [5:0] alucontrol_input = {aluop, funct};

    /*always @(*) begin
        $display("At time %t, aluop: %b, funct: %b, alucontrol_input: %b, alucontrol: %b", $time, aluop, funct, alucontrol_input, alucontrol);
    end*/

    // Define the ALU control logic
    always @(alucontrol_input) begin
        case (alucontrol_input)

            6'b110000: alucontrol = 3'b000; //addi, lw, sw
            6'b100000: alucontrol = 3'b001; //beq
            6'b010000: alucontrol = 3'b010; //slti
            6'b000000: alucontrol = 3'b000; //add
            6'b000001: alucontrol = 3'b001; //sub
            6'b000010: alucontrol = 3'b010; //and
            6'b000011: alucontrol = 3'b011; //or
            6'b000100: alucontrol = 3'b100; //slt

            default:   alucontrol = 3'bxxx; // Undefined operation
        endcase
    end
endmodule

`endif // ALUDEC
