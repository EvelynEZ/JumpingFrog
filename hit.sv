module hit (clock, reset, red, green, crash);
	input logic clock, reset;
	input logic [7:0][7:0] red, green;
	output logic crash;
	
	integer i;
	always_ff @(posedge clock)
		if (reset) 
			crash <= 0;
		else 
			for (i = 0; i <= 7; i = i + 1) 
				if (red[5][i] == 1 & green[5][i] == 1)
					crash <= 1;
endmodule

