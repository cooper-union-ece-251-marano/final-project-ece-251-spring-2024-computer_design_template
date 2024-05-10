module wda_mux(mem_to_reg, read_mem, result, wda);
    input mem_to_reg;
    input[31:0] read_mem;
    input[31:0] result;
    output reg[31:0] wda;

    always@(*)
    begin
        if(mem_to_reg == 1)
        begin
            wda = read_mem;
        end
        else
        begin
            wda = result;
        end
    end
endmodule