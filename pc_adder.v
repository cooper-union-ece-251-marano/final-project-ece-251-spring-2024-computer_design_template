module pc_adder(pc, pc_addr);
    input[31:0] pc;
    input rst;
    output reg[31:0] pc_addr;

    always @(*)  
        begin
            pc_addr = pc + 4;
        end
endmodule