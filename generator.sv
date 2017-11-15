module generator (clk, reset, res, out);
	input logic clk, reset, res;
	output logic [9:0] out;

	
	always_ff @(posedge clk) begin
		//XNOR the 7th and 10th bits.
		if(reset | res) 
			out <= 10'b0000000000;
		else 
			out[9:0] = {out[8:0],~(out[9] ^ out[6])};
	end
endmodule


module generator_testbench();
 logic clk, reset, res;
 logic [9:0] out;


		generator dut (clk, reset, res, out);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
																	   @(posedge clk);
	reset <= 1; 												   @(posedge clk);
	reset <= 0; 													@(posedge clk);																	
																		@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
																											
	$stop; // End the simulation.
	end
endmodule