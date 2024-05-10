module instr_mem(pc, instr);
    input[31:0] pc;
    output reg[31:0] instr;

    reg [31:0] all_instr [0:31];

    initial begin
        $readmemb("Test_Program.txt", all_instr);
    end
     
     always@(pc)
     begin
        instr = all_instr[pc>>2];
     end
endmodule