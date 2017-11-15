module light (clk, reset, w, out);
	input logic clk, reset;
	input logic [1:0] w;
	output logic [2:0] out;
	reg [2:0] ps, ns;
	

	//state variables
	parameter [2:0] A = 3'b001, B = 3'b010,  C = 3'b100, D = 3'b101; 
	

	//Next state logic
	always_comb
		case (ps)
			A : if (w == 2'b00)  //calm
				ns = D;
				else if (w == 2'b01) //Right to Left
				ns = B;
				else //Left to Right
				ns = C;
			B : if (w == 2'b00)
					ns = D;
				else if (w == 2'b01)
					ns = C;
				else 
					ns = A;
			C : if (w == 2'b00)
					ns = D;
				else if (w == 2'b01)
					ns = A;
				else
					ns = B;
			D : if (w == 2'b00)
					ns = B;
				else if (w == 2'b01)
					ns = A;
				else 
					ns = C;
			default: ns = 3'bxxx;
		endcase
	
	assign out = ps;
	
	// DFFs
   always_ff @(posedge clk)
      if (reset)
         ps <= A;
		else
			ps <= ns;
endmodule
					
module light_testbench();
logic clk, reset;
logic [1:0]w;
logic [2:0]out;

light dut (clk, reset, w, out);

// Set up the clock.
parameter CLOCK_PERIOD=100;
initial begin
clk <= 0;
forever #(CLOCK_PERIOD/2) clk <= ~clk;
end

// Set up the inputs to the design. Each line is a clock cycle.
initial begin
								@(posedge clk);
reset <= 1;					@(posedge clk);
reset <= 0; w <= 2'b00; @(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
				w <= 2'b01; @(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
				w <= 2'b10; @(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
				w <= 2'b00; @(posedge clk);
								@(posedge clk);
								@(posedge clk);
				$stop; // End the simulation.
end
endmodule
				