module  indicator ( input 	logic Reset, frame_clk, st,
						  input 	logic [7:0] keycode,
						  output logic [9:0]  BallX, BallY,
						  output logic dual, single);
    
	 logic Ball_Y_Pos, Ball_X_Pos;

    logic [9:0] Ball_X_Center=155;  // Center position on the X axis
    logic [9:0] Ball_Y_Center=276;  // Center position on the Y axis

    assign Ball_Size = 4;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
				Ball_Y_Pos <= Ball_Y_Center;
				Ball_X_Pos <= Ball_X_Center;
        end
           
        else 
        begin 
	
		  
				 if ( keycode[7:0] == 8'h4e && ~st ) 
					  begin
					  Ball_Y_Center <= 340;
					  dual <=1'b1;
					  single <=1'b0;
					  end
					  
					  
				else if ( keycode[7:0] == 8'h4b && ~st)  
						begin
					  Ball_Y_Center <= 276;
					  dual <= 1'b0;
					  single <= 1'b1;					  
						end
						
		
  
				 
		end  
    end
       
    assign BallX = Ball_X_Center;
   
    assign BallY = Ball_Y_Center;
   
    endmodule 
