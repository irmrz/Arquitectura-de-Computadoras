module fetch (input  logic 		  PCSrc_F,
				  input  logic 		  clk,
				  input  logic 		  reset,
				  input  logic  [63:0] PCBranch_F,
				  output logic  [63:0] imem_addr_F);
	
	logic [63:0] salida_mux, salida_adder;
	initial
		salida_adder = 0;
	mux2 mux2_1 (salida_adder, PCBranch_F, PCSrc_F, salida_mux);
	flopr flipflop (clk, reset, salida_mux, imem_addr_F);
	adder fetch_adder (imem_addr_F, 64'd4, salida_adder);
		
endmodule