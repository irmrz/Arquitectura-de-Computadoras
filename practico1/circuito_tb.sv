module circuito_tb();
	logic clk, reset, enable, s;
	logic [3:0] L;
	logic [7:0] a, b, q;
	circuito dut (clk, reset, enable,s,a,b,q,L);
	always
		begin
			clk = 0; #100; clk = 1; #100;
		end
	initial
		begin
			reset = 0; enable = 0; s = 1; #250 ;
			reset = 1;
			a = 8'b01010101;
			b = '1 ; #250 ;
			enable = 1; #50 ;
			s = 0; #200 ;
			$stop;
		end
endmodule