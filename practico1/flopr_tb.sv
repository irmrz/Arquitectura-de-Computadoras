`timescale 1ns / 10ps
module flopr_tb 
	#(parameter N = 64) ();
	
	logic clk, reset;
	logic [N-1:0] d;
	logic [N-1:0] q;
	logic [N-1:0] qexpected;
	logic [31:0] vectornum, errors;
	logic [N-1:0] testvectors [9:0] = '{ 64'd0,
													 64'd1,
													 64'd2,
													 64'd3,
													 64'd4,
													 64'd5,
													 64'd6,
													 64'd7,
													 64'd8,
													 64'd9};
	// dut = device under test
	flopr dut(clk, reset, d, q);
	
	always
		begin
			clk = 1; #10;
			clk = 0; #10;
		end
		
	initial
		begin
			vectornum = 0; errors = 0;
			reset = 1; 
			#50;
			reset = 0;
		end
		
	always @(posedge clk)
		begin 
			#1; 
			{d} = testvectors[vectornum];
			{qexpected} = testvectors[vectornum];
		end
		
	always @(negedge clk)
		if (reset)
			begin
				if (q !== 64'b0)
					begin
						$display("Error: qexpected = ", qexpected);
					end
			vectornum = vectornum + 1;
			if (testvectors[vectornum] === 64'bx) begin 
					$display("%d tests completed with %d errors", 
						 vectornum, errors);
					$stop;
				end
			end
				
endmodule