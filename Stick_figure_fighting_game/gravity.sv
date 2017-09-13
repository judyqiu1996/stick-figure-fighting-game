module gravity(input  logic [9:0] Ball_Y_Pos, BallY1,
					input  logic jump, Clk, Reset, near,
					output logic [9:0] Ball_Y_Motion);
					
enum logic [2:0] {state0,state1, state2, state3} state, next_state;	
logic [9:0] next_Ball_Y_Motion;


always_ff @(posedge Clk or posedge Reset) begin
	if(Reset) begin
	state <= state0;
	Ball_Y_Motion = 10'd0;
	end
	
	else begin
	state <= next_state;
	Ball_Y_Motion <= next_Ball_Y_Motion;
	end
	end
							
always_comb 
	begin
	
	next_state = state;

		case(state) 
		state0:
			if(jump && Ball_Y_Pos >= 10'd284)
			next_state = state1;
			else
			next_state = state0;
		state1:
			if(Ball_Y_Pos <= 10'd120)
			next_state = state2;
			else 
			next_state = state1;
		state2:
			if(Ball_Y_Pos >= 10'd300)
			next_state = state3;
			else
			next_state = state2;
		state3:
			next_state = state0;
		endcase
	end

always_comb
	begin
	next_Ball_Y_Motion = Ball_Y_Motion;
		case(state) 
		state0:
			next_Ball_Y_Motion = 10'd0;
		state1: 	
			if(near && BallY1 >= Ball_Y_Pos && (BallY1 - Ball_Y_Pos <= 10'd50))
			next_Ball_Y_Motion = 10'd8;
			else
			next_Ball_Y_Motion = (~(10'd8)+1'b1);
		state2:	
			if(near && BallY1 <= Ball_Y_Pos && ( Ball_Y_Pos - BallY1 <= 10'd50))
			next_Ball_Y_Motion = (~(10'd8)+1'b1);
			else
			next_Ball_Y_Motion = 10'd8;
		state3:	
			next_Ball_Y_Motion = 10'd0;
		endcase
	end
	
endmodule
