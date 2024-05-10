module pc_mux(pc_addr, jump_addr, pc_sel, true_pc);
    input pc_sel;
    input[31:0] pc_addr, jump_addr;
    output reg[31:0] true_pc;

    always@(*)
    begin
        if(pc_sel == 1'b1)
        begin
            true_pc = jump_addr;
        end
        else
        begin
            true_pc = pc_addr;
        end
    end
endmodule
