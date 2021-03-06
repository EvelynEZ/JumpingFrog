module centerLight (clk, reset, res, L, R, NL, NR, lightOn); 

	input logic clk, reset, res;
	// L is true when left key is pressed, R is true when the right key 
	// is pressed, NL is true when the light on the left is on, and NR 
	// is true when the light on the right is on.
	input logic L, R, NL, NR;
   // when lightOn is true, the center light should be on.
   output logic lightOn;
   logic ns, ps;
	
	always_comb
	case (ps)
	0 : if((R & NL & ~L) | (L & NR & ~R))
			ns = 1;
		 else 
			ns = 0;
	1 : if (L|R)
			ns = 0;
		 else 
			ns = 1;
	default: ns = 1;
	endcase
	
	assign lightOn = ps;
	
	//DFF
	always_ff @(posedge clk)
	if (reset | res)
		ps <= 1;
	else 
		ps <= ns;
	
endmodule

module centerLight_testbench();
 logic clk, reset, res, L, R, NL, NR, lightOn;

 centerLight dut (clk, reset, res, L, R, NL, NR, lightOn);

 // Set up the clock.
parameter CLOCK_PERIOD=100;
initial begin
clk <= 0;
forever #(CLOCK_PERIOD/2) clk <= ~clk;
end

// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
														   @(posedge clk);
	reset <= 1;						               @(posedge clk);
	reset <= 0;NL <= 0;L <= 0; R <= 0;NR <= 1;@(posedge clk);
										R <= 1;        @(posedge clk);
												 NR <= 0;@(posedge clk);
							 L <= 1; R <= 0;		   @(posedge clk);
					NL <= 1;						      @(posedge clk);
							L <= 0;						@(posedge clk);
					NL <= 0;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
	$stop; // End the simulation.	
	end
endmodule