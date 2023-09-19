module maindec (input logic [10:0] Op,
					 input logic reset,
					 output logic Reg2Loc,
					 output logic [1:0] ALUSrc, // Modificada
					 output logic MemtoReg,
					 output logic RegWrite,
					 output logic MemRead,
					 output logic MemWrite,
					 output logic Branch,
					 output logic [1:0] ALUOp,
					 // Nuevas salidas
					 output logic ERet, 
					 output logic NotAnInstr);
	
	logic [10:0] R_format, LDUR, STUR, CBZ, ERET, MRS, InvalidOpCode, extIRQ_case;
	
	assign R_format = 	11'b000010001000000;
	assign LDUR = 			11'b?01111000000000;
	assign STUR =			11'b101?00100000000;
	assign CBZ = 			11'b100?00010100000;
	assign ERET = 			11'b000?00010110000;
	assign MRS = 			11'b11?010000100000; // Tipo S
	assign InvalidOp =   11'b???00000??00010;
	assign UnConBranch = 11'b?
	 	
	always_comb
		begin
			NotAnInstr = 0;
			casez (Op)
				11'b111_1100_0010 : 
						{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp, ERet} = LDUR;
					
				11'b111_1100_0000 : 
						{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp, ERet} = STUR;

				11'b101_1010_0??? :
						{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp, ERet} = CBZ;

				11'b100_0101_1000, 11'b110_0101_1000, 11'b100_0101_0000, 11'b101_0101_0000 : 
						{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp, ERet} = R_format;
						
				11'b1101011_0100	:
					{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp, ERet} = ERET;
					
				11'b11010101001	:
					{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp, ERet} = MRS;

				default : 
					begin
						{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp, ERet} = InvalidOpCode;
						NotAnInstr = 1;
					end
			endcase
		end					 
endmodule					 