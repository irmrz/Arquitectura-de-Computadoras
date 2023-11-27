module fetch #(parameter N = 64)
				(input logic PCSrc_F, clk, reset,
					input logic [N-1:0] PCBranch_F,
					output logic [N-1:0] imem_addr_F);
	
	logic [N-1:0] constant,result,outmux;
	assign constant = 64'd4; 
	
	adder #(N) add(imem_addr_F,constant,result);
	mux2 #(N) mux_(result,PCBranch_F,PCSrc_F, outmux);
	flopr #(N) ff(clk,reset,outmux,imem_addr_F);
					
endmodule
