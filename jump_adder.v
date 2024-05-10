module jump_adder(imm_ex, pc, jump_addr);
    input[31:0] imm_ex;
    input[31:0] pc;
    input rst;
    output reg[31:0] jump_addr;

    always@(imm_ex)
        begin
            jump_addr = pc + imm_ex;
        end
endmodule

