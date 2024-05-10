module reg_file (rs1, rs2, rd, wda, reg_wrt, rda, rdb, CLK);
    input CLK;
    input reg_wrt;
    input[4:0] rs1, rs2, rd;
    input[31:0] wda;
    integer i;

    output[31:0] rda, rdb;

    reg [31:0] files [0:31];

    
    initial begin
        for(i = 0; i < 32; i = i + 1)
        begin
            files[i] = 32'b00000000000000000000000000000000;
        end
    end

    assign rda = files[rs1];
    assign rdb = files[rs2];

    always@(posedge CLK)
    begin
        if(reg_wrt == 1)
        begin
            files[rd] = wda;
        end
    end

endmodule

