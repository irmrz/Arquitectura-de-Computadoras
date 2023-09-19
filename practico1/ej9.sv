module ej9 (input logic A, B, C, clk,
				output logic Z,Y);
	logic P;
	always_ff @ (posedge clk)
		begin
			P <= A & B;
			Z <= P | C;
			Y <= P | Z;
		end
endmodule