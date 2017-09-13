module mode_choose (input logic [9:0] ballxsig, ballysig,
						  input logic VGA_VS, Reset_h, Clk, stand_left, stand_right, kick_2, fight_2, jump_2, dodge_2, back_2, du, sin, st, p1win, p2win,
						  input logic [15:0] keycode, keycode1,
						  input logic [1:0] back2,
						  output logic right, left,stand, kick, fight, jump, dodge, back0,
						  output logic [9:0]  ballxsig1, ballysig1); //, BallS );



logic right1, left1, stand1, kick1, fight1, jump1, dodge1, back1, right2, left2, stand2, kick2, fight2, jump2, dodge2, back12;
logic [9:0] ballxsig_1, ballxsig_2, ballysig_1, ballysig_2;

 ball_second ball_second_instance(		
								.Reset(Reset_h),
								.frame_clk(VGA_VS), .*,
								.BallX(ballxsig_1),
								.BallY(ballysig_1),
								.right(right1), .left(left1), .stand(stand1), .kick(kick1), .fight(fight1), .jump(jump1), .BallX1(ballxsig), .BallY1(ballysig), .dodge(dodge1), .back(back1),
								.keycode(keycode), .keycode1(keycode1)
								);
								
AI AI0(						.Reset(Reset_h),
								.frame_clk(VGA_VS), .*,
								.BallX(ballxsig_2),
								.BallY(ballysig_2),
								.right(right2), .left(left2), .stand(stand2), .kick(kick2), .fight(fight2), .jump(jump2), .BallX1(ballxsig), .BallY1(ballysig), .dodge(dodge2), .back(back12));
							
always_comb begin
			right = 0;
			left = 0;
			stand = 0;
			kick = 0;
			fight = 0;
			jump = 0;
			dodge = 0;
			back0 = 0;
			ballxsig1 = 0;
			ballysig1 = 0;
			
	if(du) begin
			right = right1;
			left = left1;
			stand = stand1;
			kick = kick1;
			fight = fight1;
			jump = jump1;
			dodge = dodge1;
			back0 = back1;
			ballxsig1 = ballxsig_1;
			ballysig1 = ballysig_1;
			end
			
	else if (sin) begin
			right = right2;
			left = left2;
			stand = stand2;
			kick = kick2;
			fight = fight2;
			jump = jump2;
			dodge = dodge2;
			back0 = back12;
			ballxsig1 = ballxsig_2;
			ballysig1 = ballysig_2;
			end
			
	end
	
endmodule
			
								