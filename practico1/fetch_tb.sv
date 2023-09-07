module fetch_tb();

	logic 		  PCSrc_F;
	logic 		  clk;
	logic 		  reset;
	logic  [63:0] PCBranch_F;
	logic  [63:0] imem_addr_F;
	
	fetch dut (PCSrc_F, clk, reset, PCBranch_F, imem_addr_F);
	
	always
		begin
			clk = 1;
			#5ns;
			clk = ~clk;
			#5ns;
		end
	initial
		begin
			PCBranch_F = 5'b11000;
			reset = 1;
			#50ns;
			reset = ~reset;
			PCSrc_F = 1;
			#10ns;
			PCSrc_F = 0;
			#30ns;
			$stop;
		end
	
	always @(posedge clk)
		$display("PC = %d - reset = %b", imem_addr_F, reset);
	
endmodule