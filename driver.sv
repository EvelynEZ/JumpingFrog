module driver (clock, reset, red_array, green_array, red_driver, green_driver, row_sink);
	input logic clock, reset;
	input logic [7:0][7:0] red_array, green_array;
	output logic [7:0] red_driver, green_driver, row_sink;
	logic [2:0] count; 
 
	always_comb begin
		case (count) 
			3'b000: row_sink = 8'b11111110; 
			3'b001: row_sink = 8'b11111101;
			3'b010: row_sink = 8'b11111011;
			3'b011: row_sink = 8'b11110111; 
			3'b100: row_sink = 8'b11101111;
			3'b101: row_sink = 8'b11011111; 
			3'b110: row_sink = 8'b10111111; 
			3'b111: row_sink = 8'b01111111;
		endcase 
	end
	
	assign red_driver = red_array[count];
	assign green_driver = green_array[count];
	
	always_ff @(posedge clock)
		if (reset)
			count <= 3'b000;
		else
			count <= count + 3'b001;
endmodule 

module driver_testbench();
	logic clock,reset;
	logic [7:0][7:0]	red_array, green_array;
	logic [7:0] red_driver, green_driver, row_sink;
	logic [2:0] count;
		driver dut (.clock, .reset, .red_array, .green_array, .red_driver, .green_driver, .row_sink);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clock <= 0;
	forever #(CLOCK_PERIOD/2) clock <= ~clock;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
	reset<= 1;													@(posedge clock);
	reset<= 0;red_array <= {8'b0,8'b0,8'b0,8'b11111011,8'b11111101,8'b11111110,8'b0,8'b0};	green_array <= 8'b00000001;@(posedge clock);
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
																	@(posedge clock);
																	@(posedge clock);
																	@(posedge clock);
																	@(posedge clock);
																	@(posedge clock);
	$stop; // End the simulation.
	end
endmodule
 