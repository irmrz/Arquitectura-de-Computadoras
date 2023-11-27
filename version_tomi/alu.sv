	module alu(input logic [63:0] a ,b,
			  input logic [3:0] ALUcontrol,
			  output logic [63:0] result,
			  output logic zero);

		always_comb
		begin
			case(ALUcontrol)
				4'b0000: result = a & b;
				4'b0001: result = a | b;
				4'b0010: result = a + b;
				4'b0110: result = a - b;
				4'b0111: result = b;
				default : result = 64'hFFFF_FFFF_FFFF_FFFF; 
			endcase
			zero = ~(|result);
		
		end
			
endmodule