//module score (clock, reset, crash, redInput, h0, h1, h2);
//	input logic clock, reset, crash;
//	input logic [7:0]redInput;
//	input logic [6:0] h0, h1;
//	output logic [6:0] h2;
//	
//	logic [6:0] ns, ps;
//	logic [7:0] counter;
//	logic pass, on;
//	
//	always_ff @(posedge clock)
//		if (counter == 8'b1000000) begin
//			on <= 1;
//			counter <= 8'b0;end
//		else begin
//			on <= 0;
//			counter <= counter + 8'b00000001;
//		end
//	
//	always_ff @(posedge clock)
//		if(redInput > 0 & ~crash & on)
//			pass <= 1;
//		else 
//			pass <= 0;
//			
//	always_comb begin
//		case(ps) 
//			7'b1000000: if ((h1 == 7'b0010000 & h0 == 7'b0010000 & pass)) ns = 7'b1111001 ; // 0
//					else ns = 7'b1000000;
//			7'b1111001: if (h1 == 7'b0010000 & h0 == 7'b0010000 & pass) ns = 7'b0100100 ; // 1
//					else ns = 7'b1111001;
//			7'b0100100: if (h1 == 7'b0010000 & h0 == 7'b0010000 & pass) ns = 7'b0110000 ; // 2
//					else ns = 7'b0100100;
//			7'b0110000: if (h1 == 7'b0010000 & h0 == 7'b0010000 & pass) ns = 7'b0011001 ; // 3
//					else ns = 7'b0110000;
//			7'b0011001: if (h1 == 7'b0010000 & h0 == 7'b0010000 & pass) ns = 7'b0010010 ; // 4
//					else ns = 7'b0011001;
//			7'b0010010: if (h1 == 7'b0010000 & h0 == 7'b0010000 & pass) ns = 7'b0000010 ; // 5
//					else ns = 7'b0010010;
//			7'b0000010: if (h1 == 7'b0010000 & h0 == 7'b0010000 & pass) ns = 7'b1111000 ; // 6
//					else ns = 7'b0000010;
//			7'b1111000: if (h1 == 7'b0010000 & h0 == 7'b0010000 & pass) ns = 7'b0000000 ; // 7
//					else ns = 7'b1111000;
//			7'b0000000: if (h1 == 7'b0010000 & h0 == 7'b0010000 & pass) ns = 7'b0010000 ; // 8
//					else ns = 7'b0000000;
//			7'b0010000: if (h1 == 7'b0010000 & h0 == 7'b0010000 & pass) ns = 7'b1000000 ; // 9
//					else ns = 7'b0010000;
//					
//		 default: ns = 7'bX;
//		 endcase	
//	 end
//	 assign h2 = ps;
//	always_ff @(posedge clock) 
//		if (reset) 
//			ps <= 7'b10000000;
//		else 
//			ps <= ns;
//endmodule
//
//
//	
module score (clock, reset, crash, redInput, h0, h1,h2);
	input logic clock, reset, crash;
	input logic [7:0] redInput;
	input logic [6:0] h0,h1;
	output logic [6:0] h2;
	
	logic [6:0] ns; 
	logic [6:0] ps;
	logic pass;

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

		if (redInput > 0 & ~crash & on) 
		pass <= 1;
		else 
		pass <=0;

	always_comb begin
	 case (ps)
	 
	7'b1000000: if (h1 == 7'b0010000 & h0 == 7'b0010000 & pass) ns = 7'b1111001 ; // 0
			else ns = 7'b1000000;
	7'b1111001: if (h1 == 7'b0010000 & h0 == 7'b0010000 & pass) ns = 7'b0100100 ; // 1
			else ns = 7'b1111001;
	7'b0100100: if (h1 == 7'b0010000 & h0 == 7'b0010000 & pass) ns = 7'b0110000 ; // 2
			else ns = 7'b0100100;
	7'b0110000: if (h1 == 7'b0010000 & h0 == 7'b0010000 & pass) ns = 7'b0011001 ; // 3
			else ns = 7'b0110000;
	7'b0011001: if (h1 == 7'b0010000 & h0 == 7'b0010000 & pass) ns = 7'b0010010 ; // 4
			else ns = 7'b0011001;
	7'b0010010: if (h1 == 7'b0010000 & h0 == 7'b0010000 & pass) ns = 7'b0000010 ; // 5
			else ns = 7'b0010010;
	7'b0000010: if (h1 == 7'b0010000 & h0 == 7'b0010000 & pass) ns = 7'b1111000 ; // 6
			else ns = 7'b0000010;
	7'b1111000: if (h1 == 7'b0010000 & h0 == 7'b0010000 & pass) ns = 7'b0000000 ; // 7
			else ns = 7'b1111000;
	7'b0000000: if (h1 == 7'b0010000 & h0 == 7'b0010000 & pass) ns = 7'b0010000 ; // 8
			else ns = 7'b0000000;
	7'b0010000: if (h1 == 7'b0010000 & h0 == 7'b0010000 & pass) ns = 7'b1000000 ; // 9
			else ns = 7'b0010000;
			
	 default: ns = 7'bX;
	 endcase	
	 
	 end
	 
	 assign h2 = ps;
 

 always_ff @(posedge clock)
	 if(reset)
	  ps <= 7'b1000000;
	  else
	  ps <= ns;
	 
endmodule 
 module counter_testbench();
	 logic clock, reset, crash;
	 logic [6:0] h1, h2;
	 logic [6:0] ns; 
	 logic [6:0] ps;
	 logic pass;
	 logic [1:0] count;


		counter dut (clock, reset, crash, h0, h1, h2);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clock <= 0;
	forever #(CLOCK_PERIOD/2) clock <= ~clock;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
																	   @(posedge clock);
	reset <= 1; 												   @(posedge clock);
	reset <= 0; 	h1 = 7'b0010000; @(posedge clock);					
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