module regfile (input  logic        clk,
					 input  logic        we3,
					 input  logic [4:0]  ra1,
					 input  logic [4:0]  ra2,
					 input  logic [4:0]  wa3,
					 input  logic [63:0] wd3,
					 output logic [63:0] rd1,
					 output logic [63:0] rd2);
					 
	logic [63:0] registers [0:31] = '{default:0};
	
	initial 
		begin
			for(int i=0; i<31; i=i+1)
					registers[i] = i;
		end
	
	always @(posedge clk)
		begin
			if ((wa3 != 31) & we3)
				registers[wa3] = wd3;
		end
	
	assign rd1 = registers[ra1];
	assign rd2 = registers[ra2];
	
endmodule