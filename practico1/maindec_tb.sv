module maindec_tb ();

	logic [10:0] Op;
	logic Reg2Loc;
	logic ALUSrc;
	logic MemtoReg;
	logic RegWrite;
	logic MemRead;
	logic MemWrite;
	logic Branch;
	logic [1:0] ALUOp;
	
	maindec dut (Op, Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp);
	
	logic [10:0] testvectors [0:4] = '{11'b111_1100_0010,
												 11'b111_1100_0000,
												 11'b101_1010_0???,
												 11'b110_0101_1000,
												 11'b111_1111_1111};
												 
	string string_vectors [0:4] = '{"LDUR", "STUR", "CBZ", "R_format", "default"};
	
	initial
		begin
			for (int i = 0; i < 5; i=i+1)
				begin
					Op = testvectors[i];
					#2ns;
					$display("%s = %b", string_vectors[i], testvectors[i]);
					$display("result = %b.%b.%b.%b.%b.%b.%b.%b\n", Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp);
				end
				$stop;
		end

endmodule