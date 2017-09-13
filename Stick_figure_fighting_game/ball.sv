module  ball ( input logic  frame_clk, Reset, Clk, kick_1, fight_1, jump_1, dodge_1, stand_left1, stand_right1, back_1, p1win, p2win,
					input logic [15:0] keycode,keycode1,
					input logic [9:0] BallX1, BallY1,
					input logic [1:0] back1,
					output logic right, left, stand, kick, fight, jump, start, near1, dodge, back,
               output logic [9:0]  BallX, BallY); //, BallS );
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion;
	 logic near;
	 

    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=5;      // Step size on the X axis
	 parameter [9:0] Ball_X_back=1;      // Step size on the X axis
	 parameter [9:0] Ball_Y_Step=8;      // Step size on the Y axis
	 
	 gravity gravity0(.*);
	 
	 always_comb begin
	 		if( (BallX1 >= Ball_X_Pos) && (BallX1 - Ball_X_Pos <= 10'd40) || (BallX1 <= Ball_X_Pos) && (Ball_X_Pos - BallX1 <= 10'd40))
			near <= 1'b1;
		else
			near <= 1'b0;
			end
			
		 always_comb begin
	 		if( (BallY1 >= Ball_Y_Pos) && (BallY1 - Ball_Y_Pos <= 10'd50) || (BallY1 <= Ball_Y_Pos) && (Ball_Y_Pos - BallY1 <= 10'd50))
			near1 <= 1'b1;
		else
			near1 <= 1'b0;
			end		
	 
    always_ff @ ( posedge frame_clk or posedge Reset )
    begin: Move_Ball
	 		if(Reset) begin
		Ball_X_Pos <= 10'd0;
		Ball_Y_Pos <= 10'd300;
		Ball_X_Motion <= 10'b0;
		stand <= 1'b1;
		right <= 1'b0;
		left <= 1'b0;
		kick <= 1'b0;
		fight <= 1'b0;
		jump <= 1'b0;
		dodge <= 1'b0;
		start <= 1'b0;
		back <= 1'b0;
		end
		
		else	begin
		
		if(p1win || p2win) begin
							right <= 1'b0;
							left <= 1'b0;
							stand <= 1'b1;
							kick <= 1'b0;
							fight <= 1'b0;
							jump <= 1'b0;
							dodge <= 1'b0;
							back <= 1'b0;
							Ball_X_Motion <= 10'd0;
			end
				
							
		
		else if(back1 == 2'd2) begin
							right <= 1'b0;
							left <= 1'b0;
							stand <= 1'b0;
							kick <= 1'b0;
							fight <= 1'b0;
							jump <= 1'b0;
							dodge <= 1'b0;
							back <= 1'b1;
							
				 if ( (Ball_X_Pos + 10'd80) >= Ball_X_Max ||  BallX1 > Ball_X_Pos && (BallX1 - Ball_X_Pos <= 10'd40) && near1) 
						 Ball_X_Motion <= (~ (Ball_X_back) + 1'b1);// You need to remove this and make both X and Y respond to keyboard input
				 else if (Ball_X_Pos <= 10'd10 ||  BallX1 < Ball_X_Pos && ( Ball_X_Pos - BallX1 <= 10'd40) && near1) 
						Ball_X_Motion <= Ball_X_back;		
				 else 
					if(stand_left1)
					Ball_X_Motion <= (~ (10'd8) + 1'b1);
						else if(stand_right1)
						Ball_X_Motion <= 10'd8;
						else
						Ball_X_Motion <= 10'd0;
							end 
			
			else if(back1 == 2'd1) begin
							right <= 1'b0;
							left <= 1'b0;
							stand <= 1'b0;
							kick <= 1'b0;
							fight <= 1'b0;
							jump <= 1'b0;
							dodge <= 1'b1;
							back <= 1'b0;
							
				 if ( (Ball_X_Pos + 10'd80) >= Ball_X_Max ||  BallX1 > Ball_X_Pos && (BallX1 - Ball_X_Pos <= 10'd40) && near1) 
						 Ball_X_Motion <= (~ (Ball_X_back) + 1'b1);// You need to remove this and make both X and Y respond to keyboard input
				 else if (Ball_X_Pos <= 10'd10 ||  BallX1 < Ball_X_Pos && ( Ball_X_Pos - BallX1 <= 10'd40) && near1) 
						Ball_X_Motion <= Ball_X_back;		
				 else 
					if(stand_left1)
					Ball_X_Motion <= (~ (Ball_X_back) + 1'b1);
						else if(stand_right1)
						Ball_X_Motion <= Ball_X_back;
						else
						Ball_X_Motion <= 10'd0;
							end 
	 
	  else if ((keycode[7:0] == 8'h18 || keycode[15:8] == 8'h18 || keycode1[7:0] == 8'h18 || keycode1[15:8] == 8'h18)  && ~fight_1 && ~kick_1 && ~jump_1 && ~dodge_1 && back1 ==1'b0 && ~back_1)		begin					
							right <= 1'b0;
							left <= 1'b0;
							stand <= 1'b0;
							kick <= 1'b1;
							fight <= 1'b0;
							jump <= 1'b0;
							dodge <= 1'b0;
							back <= 1'b0;
					
				if ( (Ball_X_Pos + 10'd80) >= Ball_X_Max ||  BallX1 > Ball_X_Pos && (BallX1 - Ball_X_Pos <= 10'd40) && near1) 
						 Ball_X_Motion <= (~ (Ball_X_back) + 1'b1);// You need to remove this and make both X and Y respond to keyboard input
				 else if (Ball_X_Pos <= 10'd10 ||  BallX1 < Ball_X_Pos && ( Ball_X_Pos - BallX1 <= 10'd40) && near1) 
						Ball_X_Motion <= Ball_X_back;		
				 else 
					Ball_X_Motion <= 10'd0;					
							end 
		else if ((keycode[7:0] == 8'h0C || keycode[15:8] == 8'h0C || keycode1[7:0] == 8'h0C || keycode1[15:8] == 8'h0C) && ~kick_1 && ~fight_1 && ~dodge_1 && ~jump_1 && back1 ==2'b0 && ~back_1)		begin					
							right <= 1'b0;
							left <= 1'b0;
							stand <= 1'b0;
							kick <= 1'b0;
							fight <= 1'b1;
							jump <= 1'b0;
							dodge <= 1'b0;
							back <= 1'b0;
					
				if ( (Ball_X_Pos + 10'd80) >= Ball_X_Max ||  BallX1 > Ball_X_Pos && (BallX1 - Ball_X_Pos <= 10'd40) && near1) 
						 Ball_X_Motion <= (~ (Ball_X_back) + 1'b1);// You need to remove this and make both X and Y respond to keyboard input
				 else if (Ball_X_Pos <= 10'd10 ||  BallX1 < Ball_X_Pos && ( Ball_X_Pos - BallX1 <= 10'd40) && near1) 
						Ball_X_Motion <= Ball_X_back;		
				 else 
					Ball_X_Motion <= 10'd0;					
							end 
		
		else if ((keycode[7:0] == 8'h1C || keycode[15:8] == 8'h1C || keycode1[7:0] == 8'h1C || keycode1[15:8] == 8'h1C) && ~kick_1 && ~fight_1 && ~jump_1 && back1 ==2'b0 && ~back_1)		begin					
							right <= 1'b0;
							left <= 1'b0;
							stand <= 1'b0;
							kick <= 1'b0;
							fight <= 1'b0;
							jump <= 1'b0;
							dodge <= 1'b1;
							back <= 1'b0;
					
				if ( (Ball_X_Pos + 10'd80) >= Ball_X_Max ||  BallX1 > Ball_X_Pos && (BallX1 - Ball_X_Pos <= 10'd40) && near1) 
						 Ball_X_Motion <= (~ (Ball_X_back) + 1'b1);// You need to remove this and make both X and Y respond to keyboard input
				 else if (Ball_X_Pos <= 10'd10 ||  BallX1 < Ball_X_Pos && ( Ball_X_Pos - BallX1 <= 10'd40) && near1) 
						Ball_X_Motion <= Ball_X_back;		
				 else 
					Ball_X_Motion <= 10'd0;					
							end 
							
		else  if ((keycode[7:0] == 8'h1a || keycode[15:8] == 8'h1a || keycode1[7:0] == 8'h1a || keycode1[15:8] == 8'h1a)  && ~kick_1 && ~fight_1 && ~dodge_1 && back1 ==2'b0 && ~back_1)	begin
							
							right <= 1'b0;
							left <= 1'b0;
							stand <= 1'b0;
							kick <= 1'b0;
							fight <= 1'b0;
							jump <= 1'b1;
							dodge <= 1'b0;
							back <= 1'b0;
							
				if ((Ball_X_Pos + 10'd80) >= Ball_X_Max ||  BallX1 > Ball_X_Pos && (BallX1 - Ball_X_Pos <= 10'd40) && near1) 
				
						 Ball_X_Motion <= (~ (Ball_X_back) + 1'b1);// You need to remove this and make both X and Y respond to keyboard input
						 
				 else if (Ball_X_Pos <= 10'd10 ||  BallX1 < Ball_X_Pos && ( Ball_X_Pos - BallX1 <= 10'd40) && near1) 
				 
						Ball_X_Motion <= Ball_X_back;		
						
				 else begin
				 if(keycode[7:0] == 8'h04 || keycode[15:8] == 8'h04 || keycode1[7:0] == 8'h04 || keycode1[15:8] == 8'h04)	begin
					
					if ((Ball_X_Pos + 10'd80) >= Ball_X_Max ||  BallX1 > Ball_X_Pos && (BallX1 - Ball_X_Pos <= 10'd40) && near1) 
				
						 Ball_X_Motion <= (~ (Ball_X_back) + 1'b1);// You need to remove this and make both X and Y respond to keyboard input
						 
				 else if (Ball_X_Pos <= 10'd10 ||  BallX1 < Ball_X_Pos && ( Ball_X_Pos - BallX1 <= 10'd40) && near1) 
				 
						Ball_X_Motion <= Ball_X_back;	
					else Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);
					end
				 else if  (keycode[7:0] == 8'h07 || keycode[15:8] == 8'h07 || keycode1[7:0] == 8'h07 || keycode1[15:8] == 8'h07) begin
					if ((Ball_X_Pos + 10'd80) >= Ball_X_Max ||  BallX1 > Ball_X_Pos && (BallX1 - Ball_X_Pos <= 10'd40) && near1) 
				
						 Ball_X_Motion <= (~ (Ball_X_back) + 1'b1);// You need to remove this and make both X and Y respond to keyboard input
						 
				 else if (Ball_X_Pos <= 10'd10 ||  BallX1 < Ball_X_Pos && ( Ball_X_Pos - BallX1 <= 10'd40) && near1) 
				 
						Ball_X_Motion <= Ball_X_back;	
						
					else Ball_X_Motion <= Ball_X_Step;
					end
					else	begin
						Ball_X_Motion <= 10'd0;
						end
							end 
							end
			
		else  if ((keycode[7:0] == 8'h04 || keycode[15:8] == 8'h04 || keycode1[7:0] == 8'h04 || keycode1[15:8] == 8'h04) && ~kick_1 && ~fight_1 && ~jump_1 && ~dodge_1 && back1 ==2'b0 && ~back_1)		begin
							
							right <= 1'b0;
							left <= 1'b1;
							stand <= 1'b0;
							kick <= 1'b0;
							fight <= 1'b0;
							jump <= 1'b0;
							dodge <= 1'b0;
							back <= 1'b0;
								
				if ( Ball_X_Pos <= 10'd10 ||  BallX1 < Ball_X_Pos && ( Ball_X_Pos - BallX1 <= 10'd40) && near1) 
							 Ball_X_Motion <= Ball_X_back;
				else if ( (Ball_X_Pos + 10'd80) >= Ball_X_Max ||  BallX1 > Ball_X_Pos && (BallX1 - Ball_X_Pos <= 10'd40) && near1) begin
						 Ball_X_Motion <= (~ (Ball_X_back) + 1'b1);
						 end
				else 
					Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);
			end
			
		 else if ((keycode[7:0] == 8'h07 || keycode[15:8] == 8'h07 || keycode1[7:0] == 8'h07 || keycode1[15:8] == 8'h07) && ~kick_1 && ~fight_1 && ~jump_1 && ~dodge_1 && back1 ==2'b0 && ~back_1)		begin					
		 
							right <= 1'b1;
							left <= 1'b0;
							stand <= 1'b0;
							kick <= 1'b0;
							fight <= 1'b0;
							jump <= 1'b0;
							dodge <= 1'b0;
							back <= 1'b0;

				  if ( (Ball_X_Pos + 10'd80) >= Ball_X_Max ||  BallX1 > Ball_X_Pos && (BallX1 - Ball_X_Pos <= 10'd40) && near1) begin
						 Ball_X_Motion <= (~ (Ball_X_back) + 1'b1);
						 end
				  else if ( Ball_X_Pos <= 10'd10 ||  BallX1 < Ball_X_Pos && ( Ball_X_Pos - BallX1 <= 10'd40) && near1) 
							 Ball_X_Motion <= Ball_X_back;
				  else 
					Ball_X_Motion<= Ball_X_Step;
						 end
						 
			else if (keycode[7:0] == 8'h28 || keycode[15:8] == 8'h28 || keycode1[7:0] == 8'h28 || keycode1[15:8] == 8'h28)	
					start=1'b1;
					
			
					
			
			else     
			 begin
			 Ball_X_Motion <= 10'b0;
			 stand <= 1'b1;
			 right <= 1'b0;
			 left <= 1'b0;
			 kick <= 1'b0;
			 fight <= 1'b0;
			 jump <= 1'b0;
			 dodge <= 1'b0;
			 back <= 1'b0;
				end
				

					
			
				 Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);  // Update ball position
				 Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
				 
			end
	
			end

			

    assign BallX = Ball_X_Pos;
	 assign BallY = Ball_Y_Pos;
   

endmodule

		/*	8'h16:		begin
							Ball_X_Motion <= 10'd0;
							
		       if ( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
					  Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.
					  
				 else if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
					  Ball_Y_Motion <= Ball_Y_Step;
				 else if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max ) 
						 Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);// You need to remove this and make both X and Y respond to keyboard input
				 else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min ) 
						Ball_X_Motion <= Ball_X_Step;		
				 else 
					Ball_Y_Motion<= Ball_Y_Step;					
							end */
