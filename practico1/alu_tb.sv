module alu_tb ();
	logic [63:0] a;
	logic [63:0] b;
	logic [63:0] result;
	logic [3:0]  ALUControl;
	logic        zero;
	
	logic [3:0] errors;
	logic [3:0] ALUValues [0:4]   = '{ 4'b0000, // AND
												  4'b0001, // OR
												  4'b0010, // ADD
												  4'b0110, // SUB
												  4'b0111  // pass b
											 };
	
	logic [63:0] testvectors [0:1] = '{64'd2, //a
												  64'd1};//b
	
	logic [63:0] expected [0:4]    = '{64'd0,
												  64'd3,
												  64'd3,
												  64'd1,
												  64'd1};
	
	alu dut(a, b, ALUControl, result, zero);
	
	initial
		begin
			errors = 0;
			a = testvectors[0];
			b = testvectors[1];
			$display("a = %b - b = %b",a,b);
			for (int i = 0; i < 6; i = i + 1)
				begin
					ALUControl = ALUValues[i];
					#10ns;
					$display("result = %d (zero = %d) - ALU = %b", result, zero, ALUControl);
					if (result != expected[i])
						begin
							errors = errors + 1;
							$display("Error: result = %b (expected = %b) - ALU = %b", result, expected[i], ALUControl);
						end
				end
				$display("Errors= %d", errors);
				
			// Caso overflow
			a = 64'hffff_ffff_ffff_ffff;
			for (int i = 0; i < 6; i = i + 1)
				begin
					ALUControl = ALUValues[i];
					#10ns;
					$display("result = %d (zero = %d) - ALU = %b", result, zero, ALUControl);
				end
			$stop;
		end
			/*
			En el caso del add se cuando se le sumo 1 al valor mas grande que se
			puede almacenar en 64b se volvio a 0. Entonces  podemos decir que 
			funciona en modulo 64.
			*/
endmodule