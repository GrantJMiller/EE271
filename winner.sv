
// module to control who wins the tug-o-war game

module winner (victor, clk, reset, L, R, LED9, LED1);
	input logic clk, reset, L, R, LED9, LED1;
	output logic [6:0] victor;
	
	enum {off, player1, player2} ps, ns;
	
	always_comb begin
		case(ps)
			off: if(L & ~R & LED9) ns = player1;
				  else if(~L & R & LED1) ns = player2;
				  else ns = off;
							
			player1: ns = player1;
			player2: ns = player2;
			
		endcase
		
		if(ns == player2) victor = 7'b1111001;
		else if (ns == player1) victor = 7'b0100100; 
		else victor = 7'b1111111;

	end
	
	always_ff @(posedge clk) begin
		if(reset)
			ps <= off;
		else
			ps <= ns;
	end
	
endmodule

module winner_testbench();
	logic clk, reset, L, R, LED9, LED1;
	logic [6:0] victor;
	
	winner dut (.victor, .clk, .reset, .L, .R, .LED9, .LED1);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD / 2) clk <= ~clk; // forever toggle the clock
	end
	
	initial begin
		reset <= 1;										@(posedge clk);
															@(posedge clk);
		reset <= 0;										@(posedge clk);
															@(posedge clk);
		LED9 <= 1; LED1 <= 0; L <= 1; R <= 0;	@(posedge clk);
															@(posedge clk);
		LED9 <= 0; LED1 <= 1;						@(posedge clk);
															@(posedge clk);
		LED9 <= 1; LED1 <= 1;						@(posedge clk);
															@(posedge clk);
					  LED1 <= 0; 			R <= 1;  @(posedge clk);
															@(posedge clk);
		reset <= 1;		       L <= 0;				@(posedge clk);
															@(posedge clk);
		LED9 <= 0; LED1 <= 1; 						@(posedge clk);
															@(posedge clk);
		reset <= 0;										@(posedge clk);
															@(posedge clk);
		LED9 <= 0; LED1 <= 1; L <= 1; R <= 0;	@(posedge clk);
															@(posedge clk);
		LED9 <= 1;				 						@(posedge clk);
															@(posedge clk);
		LED9 <= 0; LED1 <= 0; L <= 0;	R <= 1;	@(posedge clk);
															@(posedge clk);
		LED9 <= 1; 										@(posedge clk);
															@(posedge clk);
		LED9 <= 0;										@(posedge clk);
		$stop;
	end
endmodule