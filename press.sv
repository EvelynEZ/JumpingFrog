module press (clock, in, go);
	input logic clock, in;
	output logic go;
	logic ns, ps;
	
	//Key: True when not pressed, False when pressed 
	always_ff @(posedge clock)
		ns <= in;
	always_ff @(posedge clock)
		ps <= ns;
		
	assign go = ns & ~ps;
endmodule

module press_testbench();
 logic clock, in, go;

 press dut (clock, in, go);

 // Set up the clock.
 parameter CLOCK_PERIOD=100;
 initial begin
 clock <= 0;
 forever #(CLOCK_PERIOD/2) clock <= ~clock;
 end

 // Set up the inputs to the design. Each line is a clock cycle.
 initial begin
							@(posedge clock);
				in <= 0; @(posedge clock);
							@(posedge clock);
							@(posedge clock);
				in <= 1; @(posedge clock);
							@(posedge clock);
							@(posedge clock);
							@(posedge clock);
$stop; // End the simulation.
 end
endmodule 

