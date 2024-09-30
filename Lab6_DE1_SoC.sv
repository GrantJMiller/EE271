
// module that puts all the submodules together and connects inputs/outputs to the DE1 board.

module Lab6_DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);

	 input logic 	CLOCK_50;
	 input logic   [3:0] KEY; // keys are active low
	 input logic   [9:0] SW;
	 output logic 	[6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 output logic 	[9:0] LEDR;
	 
	 logic key0, key3, key0_Stable, key3_Stable;
	 
	 assign HEX5 = 7'b1111111;
	 assign HEX4 = 7'b1111111;
	 assign HEX3 = 7'b1111111;
	 assign HEX2 = 7'b1111111;
	 assign HEX1 = 7'b1111111;
	 
	 doubleDFF DFF1 (.clk(CLOCK_50), .reset(SW[9]), .in(~KEY[0]), .out(key0_Stable));
	 doubleDFF DFF2 (.clk(CLOCK_50), .reset(SW[9]), .in(~KEY[3]), .out(key3_Stable));
	 userInput keyZero (.out(key0), .clk(CLOCK_50), .reset(SW[9]), .button(key0_Stable));
	 userInput keyThree (.out(key3), .clk(CLOCK_50), .reset(SW[9]), .button(key3_Stable));
	
	 //Setup LEDS 1-9
	 normalLight one (.lightOn(LEDR[1]), .clk(CLOCK_50), .reset(SW[9]), .L(key3), .R(key0), .NL(LEDR[2]), .NR(1'b0));
	 normalLight two (.lightOn(LEDR[2]), .clk(CLOCK_50), .reset(SW[9]), .L(key3), .R(key0), .NL(LEDR[3]), .NR(LEDR[1]));
	 normalLight three (.lightOn(LEDR[3]), .clk(CLOCK_50), .reset(SW[9]), .L(key3), .R(key0), .NL(LEDR[4]), .NR(LEDR[2]));
	 normalLight four (.lightOn(LEDR[4]), .clk(CLOCK_50), .reset(SW[9]), .L(key3), .R(key0), .NL(LEDR[5]), .NR(LEDR[3]));
	 // Center light LED
	 centerLight five (.lightOn(LEDR[5]), .clk(CLOCK_50), .reset(SW[9]), .L(key3), .R(key0), .NL(LEDR[6]), .NR(LEDR[4]));
	 
	 normalLight six (.lightOn(LEDR[6]), .clk(CLOCK_50), .reset(SW[9]), .L(key3), .R(key0), .NL(LEDR[7]), .NR(LEDR[5]));
	 normalLight seven (.lightOn(LEDR[7]), .clk(CLOCK_50), .reset(SW[9]), .L(key3), .R(key0), .NL(LEDR[8]), .NR(LEDR[6]));
	 normalLight eight (.lightOn(LEDR[8]), .clk(CLOCK_50), .reset(SW[9]), .L(key3), .R(key0), .NL(LEDR[9]), .NR(LEDR[7]));
	 normalLight nine (.lightOn(LEDR[9]), .clk(CLOCK_50), .reset(SW[9]), .L(key3), .R(key0), .NL(1'b0), .NR(LEDR[8]));
	 
	 //Update hex display based on who wins
	 winner gameOver (.victor(HEX0), .clk(CLOCK_50), .reset(SW[9]), .L(key3), .R(key0), .LED9(LEDR[9]), .LED1(LEDR[1]));
	 
	 
endmodule


module Lab6_DE1_SoC_testbench();
	logic 		CLOCK_50;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	
	Lab6_DE1_SoC dut (.CLOCK_50, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD / 2) CLOCK_50 <= ~CLOCK_50; // forever toggle the clock
	end
	
	initial begin
												@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		SW[9] <= 1;							@(posedge CLOCK_50);
												@(posedge CLOCK_50);
												@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		SW[9] <= 0;							@(posedge CLOCK_50);
												@(posedge CLOCK_50);
												@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[3] <= 1;						@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[3] <= 0;						@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[3] <= 1;						@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[3] <= 0; 						@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[3] <= 1;						@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[3] <= 0;						@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[3] <= 1;						@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[3] <= 0;						@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[3] <= 1;						@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[3] <= 0;						@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[3] <= 1;						@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[3] <= 0;						@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[3] <= 1; 						@(posedge CLOCK_50);
												@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		SW[9] <= 1;							@(posedge CLOCK_50);
												@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		SW[9] <= 0;							@(posedge CLOCK_50);
						 KEY[0] <= 0; 		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 1;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
						 KEY[0] <= 0;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
						 KEY[0] <= 1;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		SW[9] <= 1;	 KEY[0] <= 0;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
						 KEY[0] <= 1;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		SW[9] <= 0;	 KEY[0] <= 0;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
						 KEY[0] <= 1;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[3] <= 1; KEY[0] <= 0;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
												@(posedge CLOCK_50);
												@(posedge CLOCK_50);
												@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 1;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
						 KEY[0] <= 0;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
						 KEY[0] <= 1;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
						 KEY[0] <= 0;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
						 KEY[0] <= 1;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
						 KEY[0] <= 0;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
						 KEY[0] <= 1;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
						 KEY[0] <= 0;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[3] <= 1; KEY[0] <= 0;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
						 KEY[0] <= 1;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
						 KEY[0] <= 1;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
						 KEY[0] <= 0;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
						 KEY[0] <= 1;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
						 KEY[0] <= 0;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
						 KEY[0] <= 1;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
						 KEY[0] <= 0;		@(posedge CLOCK_50);
												@(posedge CLOCK_50);
												@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		$stop;
	end
endmodule