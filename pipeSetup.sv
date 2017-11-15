module pipeSetup (clock, reset, crash, current, red);
	input logic clock,reset;
	input logic [7:0] current;
	output logic [7:0][7:0] red;
	input logic crash;
	logic [1:0] count2;
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
	
	always @(posedge clock)
		if (reset)	
			count2 <= 2'b00;
	   else if (crash) 
			count2 <= 2'bx;
		else
			count2 <= count2 + 2'b01;

	always_comb begin	
		case(count2)	
		2'b11: red[0] <= current; 
		default: red[0] <= 8'b0;
	endcase
		 if (reset) begin
		  red[0] <= 8'b0;
		 end else if (crash) begin
		 red[0] <= 8'b11111111;
		end
	end
		
	always_ff @(posedge clock) begin
		if (on & ~crash) begin
		red[1] <= red[0]; 
		red[2] <= red[1]; 
		red[3] <= red[2]; 
		red[4] <= red[3]; 
		red[5] <= red[4]; 
		red[6] <= red[5]; 
		red[7] <= red[6]; 
		end else if (crash) begin
		red[1] <= 8'b11111111;
		red[2] <= 8'b11111111; 
		red[3] <= 8'b11111111;
		red[4] <= 8'b11111111; 
		red[5] <= 8'b11111111;
		red[6] <= 8'b11111111;
		red[7] <= 8'b11111111;

		end else if (reset) begin
		red[1] <= 8'b0;  
		red[2] <= 8'b0;  
		red[3] <= 8'b0;  
		red[4] <= 8'b0;  
		red[5] <= 8'b0;  
		red[6] <= 8'b0;  
		red[7] <= 8'b0; 

		end
	end


endmodule 
module pipeSetup_testbench();
	logic clock,reset;
	logic [7:0] current;
	logic [7:0][7:0] red;
	logic crash;
	//logic [3:0] count1;
	logic [1:0] count2;
		pipe dut (clock, reset, crash, current, red);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clock <= 0;
	forever #(CLOCK_PERIOD/2) clock <= ~clock;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
	reset<= 1;														@(posedge clock);
	reset<= 0;	current <= 8'b00000100;	 					@(posedge clock);
					current <= 8'b00000010;						@(posedge clock);
					current <= 8'b00000001;						@(posedge clock);
					current <= 8'b00010000;						@(posedge clock);
																	@(posedge clock);
																	@(posedge clock);
					current <= 8'b00000001;					@(posedge clock);
																	@(posedge clock);
																	@(posedge clock);
																	@(posedge clock);
					current <= 8'b00000010;					@(posedge clock);
																	@(posedge clock);
																	@(posedge clock);

																
					
					
	$stop; // End the simulation.
	end
endmodule
 
						
						
			
			
			
	
		
	
			
	