module immediate(instr, imm_ex);
input [31:0] instr;
output reg [31:0] imm_ex;

always@(*)
begin
        if (instr[6:0] == 7'b0000011) begin// I-type
            imm_ex = {{19{instr[31]}}, instr[31:20]};
        end
        else if (instr[6:0] == 7'b0010011) begin //I-type
            imm_ex = {{19{instr[31]}}, instr[31:20]};
        end
        else if (instr[6:0] == 7'b0100011) begin// S-type
            imm_ex = {{19{instr[31]}}, instr[31:25], instr[11:7]};
        end
        else if (instr[6:0] == 7'b1100011) begin// B-type/J-type
            imm_ex = 2 * ({{20{instr[31]}}, instr[7], instr[30:25], instr[11:8]});
        end
end
endmodule
