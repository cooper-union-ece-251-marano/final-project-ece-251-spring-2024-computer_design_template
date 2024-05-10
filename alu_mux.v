module  alu_mux(rdb, imm_ex, rdx, alu_src);
	input alu_src;
	input [31:0] rdb;
	input [31:0] imm_ex;
	output reg [31:0] rdx;

	always@(*)
	begin
		if(alu_src == 1'b0) begin
			rdx = rdb;
		end			
        else begin
			rdx = imm_ex;
		end
	end
endmodule