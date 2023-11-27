
module signext #(parameter N = 64)
(input logic [31:0] a,
					output logic [63:0] y);
					
		always_comb
			casez(a[31:21])
				11'b111_1100_00?0:y = {{55{a[20]}},a[20:12]}; //LDUR STUR
				11'b101_1010_????: y = { {45{a[23]}},a[23:5]}; //CBZ				
				
				11'b1101_0010_1_00 : y = { {48'b0},a[20:5]};	//MOVZ LSL 0
				11'b1101_0010_1_01 : y = { {32'b0},a[20:5],{16'b0}};	//MOVZ LSL 16
				11'b1101_0010_1_10 : y = { {16'b0},a[20:5],{32'b0}};	//MOVZ LSL 32
				11'b1101_0010_1_11 : y = { a[20:5],{48'b0}};	//MOVZ LSL 48
				
				default: y = 0;
			endcase
endmodule			
