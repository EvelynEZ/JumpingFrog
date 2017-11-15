module victory (clk, reset, L, R, LM, RM, winner);
	input logic clk, reset, L, R, LM, RM;
	output logic [1:0] winner;
	logic [1:0] ns, ps;
	
	parameter [1:0] Rwin =  2'b01,
						 Lwin =  2'b10, other =  2'b00;
	
	always_comb
	case(ps)
		Rwin: ns = Rwin;
		Lwin: ns = Lwin;
		other: if (L & LM & (~R))
					ns = Lwin;
				 else if (R & RM & (~L))
					ns = Rwin;
				 else 
					ns = other;
	   default: ns = other;
	endcase
	
	assign winner = ps;
	
	 // DFFs
	always_ff @(posedge clk)
		if (reset)
			ps <= other;
		else 
			ps <= ns;
		
endmodule
				
module victory_testbench();
logic clk, reset, L, R, LM, RM;
logic [1:0] winner;
victory dut (clk, reset, L, R, LM, RM, winner);

// Set up the clock.
 parameter CLOCK_PERIOD=100;
 initial begin
 clk <= 0;
 forever #(CLOCK_PERIOD/2) clk <= ~clk;
 end

 // Set up the inputs to the design. Each line is a clock cycle.
 initial begin
														@(posedge clk);
 reset <= 1; 										@(posedge clk);
														@(posedge clk);
 reset <= 0;										@(posedge clk);
														@(posedge clk);
				L <= 0; R<=0; LM <=0; RM <=0; @(posedge clk);
														@(posedge clk);
				L <= 1; 		  LM <=1;			@(posedge clk);
														@(posedge clk);
				L <= 0; 								@(posedge clk);
														@(posedge clk);
						  R<=1; LM<=0;				@(posedge clk);
														@(posedge clk);
								          RM <=1; @(posedge clk);
														@(posedge clk);
						  R<=0;						@(posedge clk);
														@(posedge clk);
			
$stop; // End the simulation.
 end
endmodule 