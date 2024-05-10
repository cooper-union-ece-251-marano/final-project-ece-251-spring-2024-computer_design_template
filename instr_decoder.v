module instr_decoder(instr, opcode, rs1, rs2, rd);
    input[31:0] instr;
    output reg[6:0] opcode;
    output reg[4:0] rs1, rs2, rd;

    always@(instr)
    begin
        opcode = instr[6:0];
        rs1 = instr[19:15];
        rs2 = instr[24:20];
        rd = instr[11:7];
    end
endmodule