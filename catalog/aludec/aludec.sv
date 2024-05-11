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

    /*always @(*) begin
        $display("At time %t, aluop: %b, funct: %b, alucontrol: %b", $time, aluop, funct, alucontrol);
    end*/

    // Define the ALU control logic
    always @(*) begin
        case (aluop)

            2'b00: begin
                case (funct)
                    4'b0000: alucontrol = 3'b000;  // add
                    4'b0001: alucontrol = 3'b001; // sub
                    4'b0010: alucontrol = 3'b010; // and
                    4'b0011: alucontrol = 3'b011; // ir
                    4'b0100: alucontrol = 3'b100; // slt
                    4'b0101: alucontrol = 3'b101; // nor
                    default:   alucontrol = 3'bxxx; // Undefined operation
                endcase
            end
            2'b01: begin //slti
                alucontrol = 3'b100; 
            end
            2'b10: begin //beq
                alucontrol = 3'b001; 
            end
            2'b11: begin //addi, lw, sw
                alucontrol = 3'b000; // Specific immediate operations (e.g., addi special case)
            end
            default: begin
                alucontrol = 3'bxxx;
            end
        endcase
    end
endmodule

`endif // ALUDEC
