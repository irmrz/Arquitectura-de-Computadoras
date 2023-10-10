// CONTROLLER

module controller(input logic [10:0] instr,
						input logic ExtIRQ, reset,			 // Nueva Entrada
						output logic [1:0] AluSrc,
						output logic [3:0] AluControl, 
												 EStatus, // Nueva salida 
						output logic reg2loc, regWrite, Branch,
											memtoReg, memRead, memWrite,
											// Nuevas salidas
											Exc, ERet, ExcAck, ExtIAck);
											
	logic [1:0] AluOp_s;
	logic notAnInstr;
											
	maindec 	decPpal 	(.Op(instr), 
							.reset(reset),
							.Reg2Loc(reg2loc), 
							.ALUSrc(AluSrc), 
							.MemtoReg(memtoReg), 
							.RegWrite(regWrite), 
							.MemRead(memRead), 
							.MemWrite(memWrite), 
							.Branch(Branch), 
							.ALUOp(AluOp_s),
							.ERet(eret),
							.NotAnInstr(notAnInstr));	
					
								
	aludec 	decAlu 	(.funct(instr), 
							.aluop(AluOp_s), 
							.alucontrol(AluControl));
								
	always_comb
	begin
			if (ExtIRQ)
				EStatus = 4'b0001;
			else if (notAnInstr)
				EStatus = 4'b0010;
			else 
				EStatus = 4'b0000;
	end
		
	assign Exc = ExtIRQ | notAnInstr;
	assign ExtIAck = ExcAck == 1 && ExtIRQ == 1 ? 1 : 0;
endmodule
