module alu_ctrl(instr, alu_op, alu_decode);

input[31:0] instr;
input[3:0] alu_op;
output reg[3:0] alu_decode;

always @(*)
begin
        if (alu_op == 4'b0010) 
        begin
            if ((instr[31:25] == 7'b0000000))
            begin
                if ((instr[14:12] == 3'b000)) begin //ADD
                    alu_decode <= 4'b0010; //2
                end
                else if ((instr[14:12] == 3'b111)) begin //AND
                    alu_decode <= 4'b0000; //0
                end
                else if ((instr[14:12] == 3'b110)) begin //OR
                    alu_decode <= 4'b0001; //1
                end
                else if ((instr[14:12] == 3'b100)) begin //XOR
                    alu_decode <= 4'b0111; //7ye
                end
                else if ((instr[14:12] == 3'b001)) begin //SLL
                    alu_decode <= 4'b0011; //3
                end
                else if ((instr[14:12] == 3'b101)) begin //SRL
                    alu_decode <= 4'b1000; //8
                end
            end
            else if ((instr[31:25] == 7'b0100000)) begin
                if ((instr[14:12] == 3'b000)) begin //SUB
                    alu_decode <= 4'b0110; //6
                end
            end
        end
        if (alu_op == 4'b0000)
        begin
            alu_decode <= 4'b0010; //2
        end
        if (alu_op == 4'b0111)
        begin
            if ((instr[14:12] == 3'b000)) begin
                alu_decode <= 4'b0111; //7
            end
            if ((instr[14:12] == 3'b101)) begin
                alu_decode <= 4'b0110;
            end
        end
end



endmodule