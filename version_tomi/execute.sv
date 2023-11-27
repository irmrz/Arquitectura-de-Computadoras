module execute #(parameter N = 64)
				(input logic AluSrc,
					input logic [3:0] AluControl,
					input logic [N-1:0] PC_E,signImm_E,readData1_E,readData2_E,
					output logic [N-1:0] PCBranch_E,aluResult_E,writeData_E,
					output logic zero_E);

	logic [N-1:0] shifted, selected;
					
	sl2 #(N) shift (signImm_E,shifted);
					
	adder #(N) add (PC_E,shifted,PCBranch_E);
	
	mux2 #(N) muxes(readData2_E,signImm_E,AluSrc,selected); 
					
	alu ALU(readData1_E,selected,AluControl,aluResult_E,zero_E);
	
	assign writeData_E =readData2_E;

					
endmodule
