module regfile_tb();

	logic        clk;
	logic        we3;
	logic [4:0]  ra1;
	logic [4:0]  ra2;
	logic [4:0]  wa3;
	logic [63:0] wd3;
	logic [63:0] rd1;
	logic [63:0] rd2;
	
	regfile dut(clk, we3, ra1, ra2, wa3, wd3, rd1, rd2);
	
	logic [4:0] counter = 0;
	
	always
		begin
			clk = 1;
			#5ns;
			clk = ~clk;
			#5ns;
		end
		
	always @(posedge clk)
		begin
		/*
		El error estaba en que no le dejaba tiempo a la simulacion a que lea we3 y wa3
		*/
				we3 = 1; #1ns;
				wa3 = 10; #1ns;
				wd3 = 64'hffff_ffff_ffff_ffff; #1ns;
				ra1 = wa3;
				ra2 = wa3+1;
		end
	
	always @(negedge clk)
		begin
			#2ns;
			$display("Registro[ra1=%d] = %d - Registro[ra2=%d] = %d", ra1, rd1, ra2, rd2);
			counter = counter + 1;
			if (counter == 5'b11111)
				$stop;
		end

endmodule