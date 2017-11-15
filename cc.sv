module cc (clock, reset,crash, press, green);
	input logic clock, reset, crash;
	input logic press;
	output logic [7:0][7:0] green;
	logic [2:0] count;
	logic [7:0] counter;
	logic on;
	
   always_ff @(posedge clock)
		if (counter == 8'b10000000) begin
			on <= 1'b1;
			counter <= 8'b0;
		end else begin 
			on <= 1'b0;
			counter <= counter + 8'b00000001;
		end
		
	always_ff @(posedge clock)
		if (press)
			count <= count + 3'b001;
		else if(on)
			count <= count - 3'b001;	
		else if(reset)
			count <= 3'b100;
		else if (crash) 
			count <= 3'bx;
			
	always_comb begin
		case (count) 
		3'b000: green = {8'b0,8'b0,8'b00010000,8'b0,8'b0,8'b0,8'b0,8'b0};
		3'b001: green = {8'b0,8'b0,8'b00100000,8'b0,8'b0,8'b0,8'b0,8'b0};
		3'b010: green = {8'b0,8'b0,8'b01000000,8'b0,8'b0,8'b0,8'b0,8'b0};
		3'b011: green = {8'b0,8'b0,8'b10000000,8'b0,8'b0,8'b0,8'b0,8'b0}; 
		3'b100: green = {8'b0,8'b0,8'b00000001,8'b0,8'b0,8'b0,8'b0,8'b0};
		3'b101: green = {8'b0,8'b0,8'b00000010,8'b0,8'b0,8'b0,8'b0,8'b0}; 
		3'b110: green = {8'b0,8'b0,8'b00000100,8'b0,8'b0,8'b0,8'b0,8'b0}; 
		3'b111: green = {8'b0,8'b0,8'b00001000,8'b0,8'b0,8'b0,8'b0,8'b0};	
	endcase
		if (crash) 
		 green <= {8'b0,8'b0,8'b0,8'b0,8'b0,8'b0,8'b0,8'b0};
	end
			

	
endmodule 
module cc_testbench();
	logic clock,reset,press;
	logic [7:0][7:0] green;
	logic crash;
	logic [2:0] count;
	cc dut (clock, reset, crash, press, green);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clock <= 0;
	forever #(CLOCK_PERIOD/2) clock <= ~clock;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
	reset<= 1;													@(posedge clock);
	reset<= 0;	press = 1'b1;	 							@(posedge clock);
					press = 1'b0;								@(posedge clock);
																	@(posedge clock);
					press = 1'b1;	 							@(posedge clock);
					press = 1'b0;	 							@(posedge clock);
																	@(posedge clock);
																	@(posedge clock);
					press = 1'b1;	 							@(posedge clock);
					press = 1'b0;	 							@(posedge clock);
																	@(posedge clock);
																	@(posedge clock);
					press = 1'b1;	 							@(posedge clock);
					press = 1'b0;	 							@(posedge clock);
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
 
			
