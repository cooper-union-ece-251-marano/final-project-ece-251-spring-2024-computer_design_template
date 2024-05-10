module data_mem(result, mem_rd, mem_wrt, CLK, read_mem, rdb);
    input CLK, mem_rd, mem_wrt;
    input[31:0] result, rdb;
    output reg confirm;
    integer i;
    output[31:0] read_mem;
    
    reg [31:0] mem [31:0];

    initial begin
        for(i = 0; i < 32; i = i + 1)
        begin
            mem[i] = 32'b00000000000000000000000000000000;
        end
    end

    assign read_mem = mem[result];
    
    always@(posedge CLK)
    begin
        if(mem_wrt == 1)
        begin
           mem[result] = rdb;
        end
    end

endmodule
