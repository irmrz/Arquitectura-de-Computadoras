module regfile_tb();

	logic        clk;
	logic        we3;
	logic [4:0]  ra1;
	logic [4:0]  ra2;
	logic [4:0]  wa3;
	logic [63:0] wd3;
	logic [63:0] rd1;
	logic [63:0] rd2;

	always
		begin
			clk = 1;
			#5ns;
			clk = ~clk;
			#5ns;
		end
	initial 
		begin
			
		end

endmodule