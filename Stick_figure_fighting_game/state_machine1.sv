module state_machine1(input logic left, right, stand, Clk, kick, fight, jump, dodge, Reset,
							 output logic stand_left, stand_right);
							
enum logic [2:0] {reset, state1, state2, state3, state4, state5} state, next_state;	

always_ff @(posedge Clk or posedge Reset ) begin
if (Reset) begin
	state <= reset;
	end
	else begin
	state <= next_state;
	end
	end
							
always_comb 
	begin
	next_state = state;
		case(state) 
		reset:
			if(left||right)
			next_state = state1;
			else
			next_state = reset;
		state1:
			if(left)
			next_state = state2;
			else if(right)
			next_state = state3;
			else 
			next_state = state1;
		state2:
			if(stand || kick || fight || jump || dodge)
			next_state = state4;
			else if(right)
			next_state = state1;
			else
			next_state = state2;
		state3:
			if(stand || kick || fight || jump || dodge)
			next_state = state5;
			else if(left)
			next_state = state1;
			else
			next_state = state3;
		state4:
			if(right)
			next_state = state1;
			else
			next_state = state4;
		state5:
			if(left)
			next_state = state1;
			else
			next_state = state5;
		endcase
	end

always_ff @(posedge Clk)
	begin
	stand_left = stand_left;
	stand_right = stand_right;
		case(state) 
		reset: begin
			stand_left = 1'b1;
			stand_right = 1'b0;	
				end
		state1: ;
		state2: 	begin
			stand_left = 1'b0;
			stand_right = 1'b0;
			end 
		state3:	begin
			stand_left = 1'b0;
			stand_right = 1'b0;
			end 
		state4:	begin
			stand_left = 1'b1;
			stand_right = 1'b0;
			end
		state5:	begin
			stand_left = 1'b0;
			stand_right = 1'b1;
			end
		endcase
	end
	
endmodule
