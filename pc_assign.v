module pc_assign(pc, true_pc, CLK, rst);
    input CLK, rst;
    input[31:0] true_pc;
    output reg[31:0] pc;

    always@(posedge CLK)
    begin
        if(rst == 1'b1)
        begin
            pc = 32'b00000000000000000000000000000000;
        end
        else
        begin
            pc = true_pc;
        end
    end
endmodule