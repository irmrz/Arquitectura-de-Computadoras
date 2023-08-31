module signext_tb();
	
	int errors;
	
	logic [31:0] a;
	logic [63:0] y;
	
	logic [31:0] instructions [0:5] = '{32'hf8408041, // LDUR pos
													32'hf85f8041, // LDUR neg
													32'hf8008041, // STUR pos
													32'hf81f8042, // STUR neg
													32'hb4000021, // CBZ pos
													32'hb4fff801  // CBZ neg
													};
													
	logic [63:0] yexpected [0:5] = '{64'h0000_0000_0000_0008,
											   64'hffff_ffff_ffff_fff8,
												64'h0000_0000_0000_0008,
											   64'hffff_ffff_ffff_fff8,
												64'h0000_0000_0000_0001,
											   64'hffff_ffff_ffff_ffc0
												};
	
	signext dut(a, y);
	
	initial
		begin 
			errors = 0;
		
		for (int i=0; i < 6; i=i+1) 
			begin
				a = instructions[i];
				#10ns
				if (y != yexpected[i])
					begin
						$display("a = %b", a);
						errors = errors + 1;
						$display("Error: y = %b (expected = %b)", y, yexpected[i]);
					end
			end
			$display("Errors= %d", errors);
		$stop;
	end
endmodule