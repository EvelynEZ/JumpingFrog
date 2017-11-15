module comparator (clk, a, b, pressed);
	input logic [9:0] a, b;
	input logic clk;
	output logic pressed; 
	assign pressed = (a < b);
endmodule
	
module comparator_testbench();
	logic [9:0] a, b;
	logic clk;
	logic greater;
	
	comparator dut(clk, a, b, greater);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	initial begin
	a <= 10'b0000000010; b<=10'b0000000100; @(posedge clk);
	a <= 10'b0000000100; b<=10'b0000000010; @(posedge clk);
	a <= 10'b0000010000; b<=10'b0000000100; @(posedge clk);
	a <= 10'b0010000000; b<=10'b0010000000; @(posedge clk);
	a <= 10'b0000010000; b<=10'b0000000100; @(posedge clk);
	a <= 10'b0000000011; b<=10'b0000010000; @(posedge clk);
	
	end
endmodule
