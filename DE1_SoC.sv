module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, KEY, SW, GPIO_0);
	input CLOCK_50;
	input [3:0] KEY;  // True when not pressed, False when pressed
	input [9:0] SW;
	output logic [6:0] HEX0, HEX1, HEX2;
	output logic [35:0] GPIO_0; 
	
	//set up clock
	logic [31:0] clk;
	parameter con = 16;
	clock_divider cdiv (CLOCK_50, clk);
	
	logic reset, crash, up;
	logic [7:0] red_driver, green_driver, row_sink, current;
	logic [7:0][7:0] redInput, greenInput;
	
	assign reset = SW[9];
	assign GPIO_0[35:28] = red_driver;
	assign GPIO_0[27:20] = green_driver;
	assign GPIO_0[19:12] = row_sink;
	
	press p (.clock(clk[con]), .in(~KEY[0]), .go(up));
	cc redDot (.clock(clk[con]), .reset(reset), .crash(crash), .press(up), .green(greenInput));
	roll lines (.clock(clk[con]), .reset(reset), .line(current));
	pipeSetup pipe (.clock(clk[con]), .reset(reset), .crash(crash), .current(current), .red(redInput));
	driver d (.clock (clk[con]), .reset(reset), .red_array(redInput), .green_array(greenInput), .red_driver(red_driver), .green_driver(green_driver), .row_sink(row_sink));
	hit gameOver (.clock(clk[con]), .reset(reset), .red(redInput), .green(greenInput), .crash(crash));
	score one (.clock(clk[con]), .reset(reset), .crash(crash), .redInput (redInput[5]), .h0(7'b0010000), .h1(7'b0010000), .h2(HEX0));
	score ten (.clock(clk[con]), .reset(reset), .crash(crash), .redInput (redInput[5]), .h0(7'b0010000), .h1(HEX0), .h2(HEX1));
	score hundred (.clock(clk[con]), .reset(reset), .crash(crash), .redInput (redInput[5]), .h0(HEX0), .h1(HEX1), .h2(HEX2));
	
endmodule
	
	
// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz,
//[25] = 0.75Hz, ...
module clock_divider (clock, divided_clocks);
	input logic clock;
	output logic [31:0] divided_clocks;

	initial divided_clocks = 0;

	always @(posedge clock)
		divided_clocks = divided_clocks + 1;
endmodule


module DE1_SoC_testbench();
	logic clock;
	logic [3:0] KEY;
	logic [35:0] GPIO_0;
	logic [9:0]SW;
	logic [6:0] HEX0, HEX1, HEX2;
	
//	logic [7:0][7:0] redInput, greenInput, current;
//	logic [7:0] red_array, green_array;
	DE1_SoC dut (clock, HEX0, HEX1, HEX2, KEY, SW, GPIO_0);
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clock <= 0;
	forever #(CLOCK_PERIOD/2) clock <= ~clock;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
	SW[9] <= 1;					@(posedge clock);
	SW[9] <= 0;	KEY[0] <= 1;@(posedge clock);
									@(posedge clock);
									@(posedge clock);
					KEY[0] <= 0;@(posedge clock);
					KEY[0] <= 1;@(posedge clock);
					KEY[0] <= 0;@(posedge clock);
					KEY[0] <= 1;@(posedge clock);
					KEY[0] <= 0;@(posedge clock);
					KEY[0] <= 1;@(posedge clock);
					KEY[0] <= 0;@(posedge clock);
					KEY[0] <= 1;@(posedge clock);
									@(posedge clock);
									@(posedge clock);
									@(posedge clock);
									@(posedge clock);
					KEY[0] <= 0;@(posedge clock);
					KEY[0] <= 1;@(posedge clock);
					KEY[0] <= 0;@(posedge clock);
					KEY[0] <= 1;@(posedge clock);
					KEY[0] <= 0;@(posedge clock);
					KEY[0] <= 1;@(posedge clock);
					KEY[0] <= 0;@(posedge clock);
					KEY[0] <= 1;@(posedge clock);
					
	end
endmodule	
					
	