module regfile(input logic clk, we3,
					input logic [4:0] ra1, ra2, wa3,
					input logic [63:0] wd3,
					output logic [63:0] rd1,rd2);
		
		logic [63:0] Registers [0:31];
		logic initialized = 0;
		
		always_ff @(posedge clk)
		begin
			if(!initialized)
			begin
				Registers[31] = 0;
				for(int i=0; i<31; i=i+1)
					Registers[i] = i;
				initialized = 1;
			end
			else if(we3 && wa3!= 5'd31)
				Registers[wa3] <= wd3;
		end
		
		always_comb 
		begin
			if (wa3 == ra1 && we3 && wa3!= 5'd31)
				rd1 = wd3;
			else 
				rd1 = Registers[ra1];
				
			if(wa3 == ra2 && we3 && wa3!= 5'd31)
				rd2 = wd3;
			else 
				rd2 = Registers[ra2];
		end
endmodule
