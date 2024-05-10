module control(opcode, alu_src, mem_to_reg, reg_wrt, mem_rd, mem_wrt, br, alu_op);

input[6:0] opcode;
output reg alu_src;
output reg mem_to_reg;
output reg reg_wrt;
output reg mem_rd;
output reg mem_wrt;
output reg br;
output reg[3:0] alu_op;

always@(opcode)
begin
        if (opcode == 7'b0110011) begin //R-type
            alu_src = 1'b0;
            mem_to_reg = 1'b0;
            reg_wrt = 1'b1;
            mem_rd = 1'b0;
            mem_wrt = 1'b0;
            br = 1'b0;
            alu_op = 4'b0010; //2
        end
        else if (opcode == 7'b0000011 | opcode == 7'b0010011) begin// I-type - load, ADDI
            if (opcode == 7'b0000011) begin
                alu_src = 1'b1;
                mem_to_reg = 1'b1;
                reg_wrt = 1'b1;
                mem_rd = 1'b1;
                mem_wrt = 1'b0;
                br = 1'b0;
                alu_op = 4'b0000; //0
            end
            else if (opcode == 7'b0010011) begin
                alu_src = 1'b1;
                mem_to_reg = 1'b0; 
                reg_wrt = 1'b1;
                mem_rd = 1'b1;
                mem_wrt = 1'b0;
                br = 1'b0;
                alu_op = 4'b0000; //0
            end
        end
        else if (opcode == 7'b0100011) begin// S-type - store
            alu_src = 1'b1;
            mem_to_reg = 1'b0;
            reg_wrt = 1'b0;
            mem_rd = 1'b0;
            mem_wrt = 1'b1;
            br = 1'b0;
            alu_op = 4'b0000; //0
        end
        else if (opcode == 7'b1100011) begin// B-type/J-type
            alu_src = 1'b0;
            mem_to_reg = 1'b0;
            reg_wrt = 1'b0;
            mem_rd = 1'b0;
            mem_wrt = 1'b0;
            br = 1'b1;
            alu_op = 4'b0111; //7
        end
end
endmodule