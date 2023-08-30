module signext_tb();
	
	int errors;
	
	logic [31:0] a;
	logic [63:0] y;
	
	logic [31:0] instructions [5:0] = '{32'b_11111000010_010101010_00_00001_00010, // LDUR pos
													32'b_11111000010_101010100_00_00001_00010, // LDUR neg
													32'b_11111000000_010101010_00_00001_00010, // STUR pos
													32'b_11111000000_101010100_00_00001_00010, // STUR neg
													32'b_10110100000_000000000000001111_00001, // CBZ pos
													32'b_10110100000_100000000000001111_00001  // CBZ neg
													};
													
	logic [63:0] yexpected [5:0] = '{64'h0000_0000_0000_0055,
											   64'hffff_ffff_ffff_ffAA,
												64'h0000_0000_0000_0055,
											   64'hffff_ffff_ffff_ffAA,
												64'h0000_0000_0000_00ff,
											   64'hffff_ffff_ffff_ffff
												};
	
	signext dut(a, y);
	
	initial
		begin 
			errors = 0;
		
		for (int i=0; i < 7; i=i+1) 
			begin
				a = instructions[i];
				$display("a = %b", a);
				#10ns
				if (y != yexpected[i])
					errors = errors + 1;
					$display("Error: y = %b (expected = %b)", y, yexpected[i]);
			end
		$stop;
	end
endmodule