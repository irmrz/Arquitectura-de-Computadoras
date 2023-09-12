module execute #(parameter N = 64)
					(input logic 			 AluSrc,
					 input logic [3:0]    AluControl,
					 input logic [N-1:0]	 PC_E,
												 signImm_E,
												 readData1_E,
												 readData2_E,
					 output logic [N-1:0]  PCBranch_E,
												 aluResult_E,
												 writeData_E,
					 output logic 			 zero_E);
	
	logic [N-1:0] salida_mux, salida_shift_left;
	
	mux2 	#(N) mux_exec(readData2_E, signImm_E, AluSrc, salida_mux);
	sl2 	#(N) shift_left(signImm_E, salida_shift_left);
	adder #(N) adder_exec(PC_E, salida_shift_left, PCBranch_E);
	alu   #(N) alu_exec(readData1_E, salida_mux, AluControl, aluResult_E, zero_E);
	assign writeData_E = readData2_E;
endmodule