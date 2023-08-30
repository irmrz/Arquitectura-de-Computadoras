module signext
					(input  logic [31:0] a,
					 output logic [63:0] y);
	
	logic [10:0] opcode;
	assign opcode = a[31:21];
	
	always_comb
		casez(opcode)
			// CBZ
			11'b101_1010_0??? : y = {{45{a[23]}}, a[23:5]};
			// LDUR
			11'b111_1100_0010 : y = {{55{a[20]}}, a[20:12]};
			// STUR
			11'b111_1100_0000 : y = {{55{a[20]}}, a[20:12]};
			// Cualquier otro caso
			default : y = 64'b0;
		endcase 
endmodule