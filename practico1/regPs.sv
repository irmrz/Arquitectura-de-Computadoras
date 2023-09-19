module regPs (input logic clk, ShiftIn, load, ShiftEn,
					input logic [3:0] ParallelIn,
					output logic ShiftOut,
					output logic [3:0] RegContent);
	
	logic [3:0] shift_reg;
	always_ff @(posedge clk)
		if (load)
			shift_reg <= ParallelIn;
		else if (ShiftEn)
			shift_reg <= {shift_reg[2:0], ShiftIn};
		else
			begin
				ShiftOut <= shift_reg[3];
				RegContent <= shift_reg;
			end
endmodule