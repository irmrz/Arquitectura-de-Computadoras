'timescale 1ns / 10ps
module flopr_tb 
	#(parameter N = 64) ();
	
	logic clk, reset;
	logic [N-1:0] d;
	logic [N-1:0] q;
	logic [9:0] testvectors [N-1:0] = '{ 64'd0,
													 64'd1,
													 64'd2,
													 64'd3,
													 64'd4,
													 64'd5,
													 64'd6,
													 64'd7,
													 64'd8,
													 64'd9 };
	// dut = device under test
	flopr dut(clk, reset, d, q);
	
	always
		begin
			clk = 1; #10;
			clk = 0; #10;
		end
	
endmodule