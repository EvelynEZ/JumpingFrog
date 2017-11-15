module roll (clock, reset, line);
	input logic clock, reset;
	output logic [7:0] line;
	
	logic [2:0] ps, ns;
	
	always_ff @(posedge clock) begin
		ns[0] <= ~(ps[2] ^ ps[1]);
		ns[1] <= ps[0];
		ns[2] <= ps[1];	
	end
	
	always_comb begin
		case(ps)
			3'b000: line = 8'b11001111; 
			3'b001: line = 8'b10011111;
			3'b010: line = 8'b11001111; 
			3'b011: line = 8'b11001111; 
			3'b100: line = 8'b11110011;
			3'b101: line = 8'b11100111; 
			3'b110: line = 8'b10011111; 
			default: line = 8'bx;
		endcase
	end
	
	always_ff @(posedge clock)
		ps <= ns;
 endmodule 
 
 module roll_testbench();
	logic clock, reset;
	logic [7:0] line;
	
	roll dut (clock, reset, line);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clock <= 0;
	forever #(CLOCK_PERIOD/2) clock <= ~clock;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
		reset <= 1; 												   @(posedge clock);
		reset <= 0; 													@(posedge clock);																	
																			@(posedge clock);
																			@(posedge clock);
																			@(posedge clock);
																			@(posedge clock);
																			@(posedge clock);
																			@(posedge clock);
																			@(posedge clock);
																			@(posedge clock);
																			@(posedge clock);
																			@(posedge clock);
												
		$stop; // End the simulation.
	end
endmodule 