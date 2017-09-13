module blitter(input logic[9:0] positionX, DrawX, DrawY, positionY, positionX1, positionY1,BallX,BallY,
					input logic [14:0] data0,
					input logic frame_clk, right,stand, left, kick, Clk, fight, right1,stand1, left1, kick1, fight1,start, jump, jump1, near1, dodge, dodge1, Reset, back, back0,
					output logic stand_left, stand_right, stand_left1,stand_right1, kick_1, fight_1, jump_1, dodge_1, kick_2, fight_2, jump_2, dodge_2, back_1, back_2, p1win, p2win,
					output logic [1:0] back1, back2,
					output logic [7:0]  Red, Green, Blue);
					
logic [9:0]  addr, addr1, shape_size, hp_Y, hp_Y1, hp_X, hp_X1, hp_size, hp1x, hp2x;
logic [0:99] data, data_kick, data_fight, data1, data_kick1, data_fight1, data_jump, data_jump1, data_dodge, data_dodge1, data_back, data_back1, data_sad1, data_sad2, data_happy1, data_happy2;

logic shape_on, shape_on1, shape_on2, shape_on3, background;
logic valid1,valid2, kick_valid, kick_valid1, fight_valid, fight_valid1, jump_valid, jump_valid1, dodge_valid, dodge_valid1;


assign valid1 = ((positionX1 > positionX) & (positionX1 - positionX <= 10'd70) & near1 & stand_right) || ((positionX > positionX1) & ( positionX - positionX1 <= 10'd70) & near1 & stand_left);
assign valid2 = ((positionX1 > positionX) & (positionX1 - positionX <= 10'd70) & near1 & stand_left1) || ((positionX > positionX1) & ( positionX - positionX1 <= 10'd70) & near1 & stand_right1);
assign shape_size = 10'd100;
assign hp_Y = 10'd29;
assign hp_Y1 = 10'd39;
assign hp_X = 10'd75;
assign hp_X1 = 10'd565;
assign hp_size = 10'd200;

hp hp0( .kick1(kick_valid), .kick2(kick_valid1), .fight1(fight_valid), .fight2(fight_valid1), .*, .jump1(jump_valid), .jump2(jump_valid1), .dodge1(dodge_valid), .dodge2(dodge_valid1));


state_machine state0(.*);

state_machine1 state1(.*, .stand(stand1), .right(right1), .left(left1), .kick(kick1), .fight(fight1), .jump(jump1), .dodge(dodge1), .stand_left(stand_left1), .stand_right(stand_right1));

standpic standpic0(.addr(addr), .frame_clk(frame_clk), .stand1(stand), .data(data));
kick kick0(.addr(addr), .frame_clk(frame_clk), .data(data_kick), .kick(kick), .kick_1(kick_1), .*);
fight fight0(.addr(addr), .frame_clk(frame_clk), .data(data_fight), .fight(fight), .fight_1(fight_1), .*);
jump jump0(.addr(addr), .frame_clk(frame_clk), .data(data_jump), .jump(jump), .jump_1(jump_1), .*);
dodge dodge0(.addr(addr), .frame_clk(frame_clk), .data(data_dodge), .dodge(dodge), .dodge_1(dodge_1), .*);
back back10(.addr(addr), .frame_clk(frame_clk), .data(data_back), .back_1(back_1), .*);
sad_ending sad_ending0(.addr(addr), .frame_clk(frame_clk), .data(data_sad1), .win(p2win));
happy_ending happy_ending0(.addr(addr), .frame_clk(frame_clk), .data(data_happy1), .win(p1win));

standpic standpic1(.addr(addr1), .frame_clk(frame_clk), .stand1(stand1), .data(data1));
kick kick10(.addr(addr1), .frame_clk(frame_clk), .data(data_kick1), .kick(kick1), .kick_1(kick_2), .kick_valid(kick_valid1));
fight fight10(.addr(addr1), .frame_clk(frame_clk), .data(data_fight1), .fight(fight1), .fight_1(fight_2), .fight_valid(fight_valid1));
jump jump10(.addr(addr1), .frame_clk(frame_clk), .data(data_jump1), .jump(jump1), .jump_1(jump_2), .jump_valid(jump_valid1));
dodge dodge10(.addr(addr1), .frame_clk(frame_clk), .data(data_dodge1), .dodge(dodge1), .dodge_1(dodge_2), .dodge_valid(dodge_valid1));
back back11(.addr(addr1), .frame_clk(frame_clk), .data(data_back1), .back_1(back_2), .back(back0), .*);
sad_ending sad_ending1(.addr(addr1), .frame_clk(frame_clk), .data(data_sad2), .win(p1win));
happy_ending happy_ending1(.addr(addr1), .frame_clk(frame_clk), .data(data_happy2), .win(p2win));



always_ff @(posedge Clk)	begin
	if(DrawX >= positionX && DrawX < (positionX + shape_size) && DrawY >= positionY && DrawY < (positionY + shape_size)) 
    begin 
	 addr = 	DrawY-positionY;
	 shape_on = 1'b1;
	 background = 1'b0;
	 end
	 
	 else 
	 begin
	 shape_on = 1'b0;
	 background = 1'b1;
	 addr = 10'b0;
	 end
	 
	  if(DrawX >= positionX1 && DrawX < (positionX1 + shape_size) && DrawY >= positionY1 && DrawY < (positionY1 + shape_size))
	  begin
	 	 addr1 = DrawY-positionY1;
		 shape_on1 = 1'b1;
		 background = 1'b0;
	  end
	  
	 else 
	 begin
	 shape_on1 = 1'b0;
	 background = 1'b1;
	 addr1 = 10'b0;
	 end
	 
	 if(DrawX >= hp_X && DrawX < (hp_X + hp_size) && DrawY >= hp_Y && DrawY < hp_Y1)
	  begin
		 shape_on2 = 1'b1;
		 background = 1'b0;
	  end
	  else 
	 begin
		 shape_on2 = 1'b0;
		 background = 1'b1;
	 end
	  
	  if(DrawX >= (hp_X1 - hp_size) && DrawX < hp_X1 &&  DrawY >= hp_Y && DrawY < hp_Y1)
	  	 begin
		 shape_on3 = 1'b1;
		 background = 1'b0;
	 end  
	 else 
	 begin
		 shape_on3 = 1'b0;
		 background = 1'b1;
	 end
end
	 
always_ff @(posedge Clk)
begin

	if(start==1'b1 && ~p1win && ~p2win)
			begin
					if((right == 1'b1 || stand_right == 1'b1) && (shape_on == 1'b1) && data[DrawX-positionX] == 1'b0 && ~kick_1 && ~fight_1 && ~jump_1 && ~dodge_1 && ~back_1)
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
					end
					
					else	if((left == 1'b1 || stand_left == 1'b1) && (shape_on == 1'b1) && data[10'd99+positionX-DrawX] == 1'b0 && ~kick_1 && ~fight_1 && ~jump_1 && ~dodge_1 && ~back_1)
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
					end
					
					else	if(kick_1 == 1'b1 && (right == 1'b1 || stand_right == 1'b1) && (shape_on == 1'b1) && data_kick[DrawX-positionX] == 1'b0 && ~fight_1 && ~jump_1 && ~dodge_1 && ~back_1)
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
					end
					
					else	if(kick_1 == 1'b1 && (stand_left == 1'b1 || left == 1'b1) && (shape_on == 1'b1) && data_kick[10'd99+positionX-DrawX] == 1'b0 && ~fight_1 && ~jump_1 && ~dodge_1 && ~back_1)
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
					end
					
						else	if(fight_1 == 1'b1 && (stand_right == 1'b1 || right == 1'b1) && (shape_on == 1'b1) && data_fight[DrawX-positionX] == 1'b0 && ~kick_1 && ~jump_1 && ~dodge_1 && ~back_1)
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
					end
					
					else	if(fight_1 == 1'b1 && (stand_left == 1'b1 || left == 1'b1) && (shape_on == 1'b1) && data_fight[10'd99+positionX-DrawX] == 1'b0 && ~kick_1 && ~jump_1 && ~dodge_1 && ~back_1)
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
					end
					
					else	if(jump_1 == 1'b1 && (stand_right == 1'b1 || right == 1'b1) && (shape_on == 1'b1) && data_jump[DrawX-positionX] == 1'b0 && ~kick_1 && ~fight_1 && ~dodge_1 && ~back_1)
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
					end
					
					else	if(jump_1 == 1'b1 && (stand_left == 1'b1 || left == 1'b1 ) && (shape_on == 1'b1) && data_jump[10'd99+positionX-DrawX] == 1'b0 && ~kick_1 && ~fight_1 && ~dodge_1 && ~back_1)
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
					end
					
					else	if(dodge_1 == 1'b1 && (stand_right == 1'b1 || right == 1'b1) && (shape_on == 1'b1) && data_dodge[DrawX-positionX] == 1'b0 && ~kick_1 && ~fight_1 && ~jump_1 && ~back_1)
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
					end
					
					else	if(dodge_1 == 1'b1 && (stand_left == 1'b1 || left == 1'b1) && (shape_on == 1'b1) && data_dodge[10'd99+positionX-DrawX] == 1'b0 && ~kick_1 && ~fight_1 && ~jump_1 && ~back_1)
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
					end
					
					else	if(back_1 == 1'b1 && (stand_right == 1'b1 || right == 1'b1) && (shape_on == 1'b1) && data_back[DrawX-positionX] == 1'b0 && ~kick_1 && ~fight_1 && ~jump_1 && ~dodge_1)
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
					end
					
					else	if(back_1 == 1'b1 && (stand_left == 1'b1 || left == 1'b1) && (shape_on == 1'b1) && data_back[10'd99+positionX-DrawX] == 1'b0 && ~kick_1 && ~fight_1 && ~jump_1 && ~dodge_1)
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
					end
					
				//second figure	
					
					else	if((right1 == 1'b1 || stand_right1 == 1'b1) && (shape_on1 == 1'b1) && data1[DrawX-positionX1] == 1'b0 && ~kick_2 && ~fight_2 && ~jump_2 && ~dodge_2 && ~back_2)
					begin
						Red = 8'hff;
						Green = 8'hff;
						Blue = 8'hff;
					end
					
					else	if((left1 == 1'b1 || stand_left1 == 1'b1) && (shape_on1 == 1'b1) && data1[10'd99+positionX1-DrawX] == 1'b0 && ~kick_2 && ~fight_2 && ~jump_2 && ~dodge_2 && ~back_2)
					begin
						Red = 8'hff;
						Green = 8'hff;
						Blue = 8'hff;
					end
					
					else	if(kick_2 == 1'b1 && (stand_right1 == 1'b1 || right1 == 1'b1) && (shape_on1 == 1'b1) && data_kick1[DrawX-positionX1] == 1'b0 && ~fight_2 && ~jump_2 && ~dodge_2 && ~back_2)
					begin
						Red = 8'hff;
						Green = 8'hff;
						Blue = 8'hff;
					end
					
					else	if(kick_2 == 1'b1 && (stand_left1 == 1'b1 || left1 == 1'b1) && (shape_on1 == 1'b1) && data_kick1[10'd99+positionX1-DrawX] == 1'b0 && ~fight_2 && ~jump_2 && ~dodge_2 && ~back_2)
					begin
						Red = 8'hff;
						Green = 8'hff;
						Blue = 8'hff;
					end
					
						else	if(fight_2 == 1'b1 && (stand_right1 == 1'b1 || right1 == 1'b1) && (shape_on1 == 1'b1) && data_fight1[DrawX-positionX1] == 1'b0 && ~kick_2 && ~jump_2 && ~dodge_2 && ~back_2)
					begin
						Red = 8'hff;
						Green = 8'hff;
						Blue = 8'hff;
					end
					
					else	if(fight_2 == 1'b1 && (stand_left1 == 1'b1 || left1 == 1'b1) && (shape_on1 == 1'b1) && data_fight1[10'd99+positionX1-DrawX] == 1'b0 && ~kick_2 && ~jump_2 && ~dodge_2 && ~back_2)
					begin
						Red = 8'hff;
						Green = 8'hff;
						Blue = 8'hff;
					end
					
					else	if(jump_2 == 1'b1 && (stand_right1 == 1'b1 || right1 == 1'b1) && (shape_on1 == 1'b1) && data_jump1[DrawX-positionX1] == 1'b0 && ~kick_2 && ~fight_2 && ~dodge_2 && ~back_2)
					begin
						Red = 8'hff;
						Green = 8'hff;
						Blue = 8'hff;
					end
					
					else	if(jump_2 == 1'b1 && (stand_left1 == 1'b1 || left1 == 1'b1 ) && (shape_on1 == 1'b1) && data_jump1[10'd99+positionX1-DrawX] == 1'b0 && ~kick_2 && ~fight_2 && ~dodge_2 && ~back_2)
					begin
						Red = 8'hff;
						Green = 8'hff;
						Blue = 8'hff;
					end
					
					else	if(dodge_2 == 1'b1 && (stand_right1 == 1'b1 || right1 == 1'b1) && (shape_on1 == 1'b1) && data_dodge1[DrawX-positionX1] == 1'b0 && ~kick_2 && ~fight_2 && ~jump_2 && ~back_2)
					begin
						Red = 8'hff;
						Green = 8'hff;
						Blue = 8'hff;
					end
					
					else	if(dodge_2 == 1'b1 && (stand_left1 == 1'b1 || left1 == 1'b1) && (shape_on1 == 1'b1) && data_dodge1[10'd99+positionX1-DrawX] == 1'b0 && ~kick_2 && ~fight_2 && ~jump_2 && ~back_2)
					begin
						Red = 8'hff;
						Green = 8'hff;
						Blue = 8'hff;
					end
					
					else	if(back_2 == 1'b1 && (stand_right1 == 1'b1 || right1 == 1'b1) && (shape_on1 == 1'b1) && data_back1[DrawX-positionX1] == 1'b0 && ~kick_2 && ~fight_2 && ~jump_2 && ~dodge_2)
					begin
						Red = 8'hff;
						Green = 8'hff;
						Blue = 8'hff;
					end
					
					else	if(back_2 == 1'b1 && (stand_left1 == 1'b1 || left1 == 1'b1) && (shape_on1 == 1'b1) && data_back1[10'd99+positionX1-DrawX] == 1'b0 && ~kick_2 && ~fight_2 && ~jump_2 && ~dodge_2)
					begin
						Red = 8'hff;
						Green = 8'hff;
						Blue = 8'hff;
					end
					
					// hp
					
				   else if(shape_on2 && DrawX >= hp1x) begin
						Red = 8'hff;
						Green = 8'd123+(DrawX-9'd75)/(2'd2);
						Blue = 8'h00;
						end

					else if(shape_on3 && DrawX <= hp2x) begin
						Red = 8'hff;
						Green = 8'd233-(DrawX-(9'd365))/(2'd2);
						Blue = 8'h00;
						end
						

					
					else
					 begin 
					Red = data0[14:10]*8; 
					Green = data0[9:5]*8;
					Blue = data0[4:0]*8 ;//- DrawX[9:3]
					end
			end
	else	if(start==1'b1 && p1win && ~p2win) begin
					if((shape_on == 1'b1) && data_happy1[DrawX-positionX] == 1'b0 )
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
					end
					
						else	if((shape_on1 == 1'b1) && data_sad2[10'd99+positionX1-DrawX] == 1'b0 )
					begin
						Red = 8'hff;
						Green = 8'hff;
						Blue = 8'hff;
					end
					
						else if(shape_on2 && DrawX >= hp1x) begin
						Red = 8'hff;
						Green = 8'd123+(DrawX-9'd75)/(2'd2);
						Blue = 8'h00;
						end

					else if(shape_on3 && DrawX <= hp2x) begin
						Red = 8'hff;
						Green = 8'd233-(DrawX-(9'd365))/(2'd2);
						Blue = 8'h00;
						end
						
					
				 else
					 begin 
					Red = data0[14:10]*8; 
					Green = data0[9:5]*8;
					Blue = data0[4:0]*8 ;//- DrawX[9:3]
					end
					
		end
					
		else	if(start==1'b1 && ~p1win && p2win) begin
					if((shape_on == 1'b1) && data_sad1[DrawX-positionX] == 1'b0 )
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
					end
					
						else	if((shape_on1 == 1'b1) && data_happy2[10'd99+positionX1-DrawX] == 1'b0 )
					begin
						Red = 8'hff;
						Green = 8'hff;
						Blue = 8'hff;
					end
					
					else if(shape_on2 && DrawX >= hp1x) begin
						Red = 8'hff;
						Green = 8'd123+(DrawX-9'd75)/(2'd2);
						Blue = 8'h00;
						end

					else if(shape_on3 && DrawX <= hp2x) begin
						Red = 8'hff;
						Green = 8'd233-(DrawX-(9'd365))/(2'd2);
						Blue = 8'h00;
						end
						
					
					else
					 begin 
					Red = data0[14:10]*8; 
					Green = data0[9:5]*8;
					Blue = data0[4:0]*8 ;//- DrawX[9:3]
					end
					
					end 
	else  
				begin
						 logic ball_on;
						 int DistX, DistY, Size;
						 DistX = DrawX - BallX;
						 DistY = DrawY - BallY;
						 Size = 10;
							  if ( ( DistX*DistX + DistY*DistY) <= (Size * Size) )
									begin
									ball_on = 1'b1;
									end
							  else 
									begin
									ball_on = 1'b0;
									end		
							 if ((ball_on == 1'b1)) 
										begin 
											Red = 8'hff;
											Green = 8'hff;
											Blue = 8'hff;
										end       
							  else 
									begin
									Red = data0[14:10]*8; 
									Green = data0[9:5]*8;
									Blue = data0[4:0]*8 ;
									end     
				end		 

end
	
endmodule						