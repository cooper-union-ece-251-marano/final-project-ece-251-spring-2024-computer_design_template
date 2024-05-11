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

module aludec(
    input wire [6:0] opcode,      
    input wire [2:0] funct3,     
    input wire [6:0] funct7,     
    output reg [3:0] alu_control  
);

    always @(*) begin
        case (opcode)
            7'b0110011: begin  // R-type instructions
                case (funct3)
                    3'b000: alu_control <= (funct7 == 7'b0000000) ? 4'b0010 :  // ADD
                                            (funct7 == 7'b0100000) ? 4'b0110 : // SUB
                                            4'b0000;  // Default
                    3'b111: alu_control <= 4'b0000; // AND
                    3'b110: alu_control <= 4'b0001; // OR
                    3'b100: alu_control <= 4'b0100; // XOR
                    3'b001: alu_control <= 4'b1010; // SLL
                    3'b101: alu_control <= (funct7 == 7'b0000000) ? 4'b1111 : // SRL
                                            (funct7 == 7'b0100000) ? 4'b1111 : // SRA
                                            4'b1111;  // Default to shifts
                    default: alu_control <= 4'b0000; // Default
                endcase
            end
            7'b0010011: begin  // I-type instructions
                case (funct3)
                    3'b000: alu_control <= 4'b0010; // ADDI
                    3'b010: alu_control <= 4'b0111; // SLTI
                    3'b011: alu_control <= 4'b1110; // SLTIU
                    3'b100: alu_control <= 4'b0100; // XORI
                    3'b110: alu_control <= 4'b0001; // ORI
                    3'b111: alu_control <= 4'b0000; // ANDI
                    3'b001: alu_control <= 4'b1010; // SLLI
                    3'b101: alu_control <= (funct7 == 7'b0000000) ? 4'b1111 : // SRLI
                                            (funct7 == 7'b0100000) ? 4'b1111 : // SRAI
                                            4'b1111; // Default to shifts
                    default: alu_control <= 4'b0000; // Default
                endcase
            end
            7'b1101111: begin  // J-type instructions (JAL)
                alu_control <= 4'b0010; // Use ADD for PC update, you might handle it differently
            end
            default: alu_control <= 4'b0000; // Default to a safe operation, typically AND
        endcase
    end

endmodule

`endif // ALUDEC