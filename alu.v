module alu (alu_decode, rda, rdx, confirm, result);
	input[31:0]rda, rdx;
	input[31:0] imm_ex;
	input[3:0]alu_decode;
	output reg confirm;
	output reg[31:0] result;

	always@(*)
	begin
			if (alu_decode == 4'b0010) begin //2
				result = rda + rdx;
				confirm = 1'b0;
			end
			else if (alu_decode == 4'b0000) begin //0
				result = rda & rdx;
				confirm = 1'b0;
			end
			else if (alu_decode == 4'b0001) begin //1
				result = rda | rdx;
				confirm = 1'b0;
			end
			else if (alu_decode == 4'b0111) begin //7
				result = rda ^ rdx;
				if (result == 32'b00000000000000000000000000000000)
				begin
					confirm = 1'b1;
				end
				else
				begin
					confirm = 1'b0;
				end
			end
			else if (alu_decode == 4'b0011) begin //3
				result = rda << rdx[4:0];
				confirm = 1'b0;
			end
			else if (alu_decode == 4'b1000) begin //8
				result = rda >> rdx[4:0];
				confirm = 1'b0;
			end
			else if (alu_decode == 4'b0110) begin //6
				result = rda - rdx;
			end
	end
endmodule

