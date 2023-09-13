// CONTROLLER

module controller(input logic [10:0] instr,
						input logic ExtIRQ,			 // Nueva Entrada
						output logic [3:0] AluControl, 
												 EStatus, // Nueva salida 
						output logic reg2loc, regWrite, AluSrc, Branch,
											memtoReg, memRead, memWrite,
											// Nuevas salidas
											Exc, ERet, ExcAck, ExtIAck);
											
	logic [1:0] AluOp_s;
	logic notAnInstr;
											
	maindec 	decPpal 	(.Op(instr), 
							.Reg2Loc(reg2loc), 
							.ALUSrc(AluSrc), 
							.MemtoReg(memtoReg), 
							.RegWrite(regWrite), 
							.MemRead(memRead), 
							.MemWrite(memWrite), 
							.Branch(Branch), 
							.ALUOp(AluOp_s),
							.NotAnInstr(notAnInstr));	
					
								
	aludec 	decAlu 	(.funct(instr), 
							.aluop(AluOp_s), 
							.alucontrol(AluControl));
							
	assign Exc = ExtIRQ | notAnInstr;
	assign ExtIAck = ExcAck == 1 && ExtIRQ == 1 ? 1 : 0;
endmodule
