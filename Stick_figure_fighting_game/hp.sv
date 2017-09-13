module hp( input logic kick1, kick2, fight1, fight2, valid1, valid2, Clk, Reset, jump1, jump2, dodge1, dodge2,
			  output logic [9:0] hp1x, hp2x,
			  output logic p1win, p2win,
			  output logic[1:0] back1, back2
						);
enum logic [3:0]{S_kick1, S_fight1, S_kick2, S_fight2, S_jump1, S_jump2, normal, is_kick1, is_kick2, is_fight1, is_fight2, is_jump1, is_jump2} state,next_state;						
logic [7:0]hpbar1=200;
logic [7:0]hpbar2=200;
logic p1=1'b0;
logic p2=1'b0;
logic[9:0] hp1_center_x=10'd75;
logic[9:0]hp2_center_x=10'd364;
//logic kick1,kick2,fight1,fight2,jump1,jump2,dodge1,dodge2;

/*assign kick1=~kick1_N;
assign kick2=~kick2_N;
assign fight1=~fight1_N;
assign fight2=~fight2_N;
assign jump1=~jump1_N;
assign jump2=~jump2_N;
assign dodge1=~dodge1_N;
assign dodge2=~dodge2_N;*/
	 

always_ff@ (posedge Clk or posedge Reset)
begin
if (Reset)
begin
state<= normal;
hpbar2<= 8'd200;
hpbar1<= 8'd200;
back1<= 2'b00;
back2<= 2'b00;
p1 <= 1'b0;
p2 <= 1'b0;
end
else if(hpbar2<=0) p1=1'b1;
else if(hpbar1<=0) p2=1'b1;
else
begin
state<=next_state;
	case(state)
		S_kick1:
		
			if(hpbar2<=4'd14)
			hpbar2<=8'b0;
			else if(dodge2==1'b1)
			begin
			hpbar2<=(hpbar2-4'd7);
			back2<=2'b01;
			end
			else
			begin
			hpbar2<=(hpbar2-4'd14);
			back2<=2'b10;
			end
		S_fight1:
			if(hpbar2<=4'd8)
			hpbar2<=8'b0;
			else if(dodge2==1'b1)
			begin
			hpbar2<=(hpbar2-4'd4);
			back2<=2'b01;
			end
			else
			begin
			hpbar2<=(hpbar2-4'd8);
			back2<=2'b10;
			end
		S_kick2:
			if(hpbar1<=4'd14)
			hpbar1<=8'b0;
			else if(dodge1==1'b1)
			begin
			hpbar1<=(hpbar1-4'd7);
			back1<=2'b01;
			end
			else
			begin
			hpbar1<=(hpbar1-4'd14);
			back1<=2'b10;
			end
		S_fight2:
			if(hpbar1<=4'd8)
			hpbar1<=8'b0;
			else if(dodge1==1'b1)
			begin
			hpbar1<=(hpbar1-4'd4);
			back1<=2'b01;
			end
			else
			begin
			hpbar1<=(hpbar1-4'd8);
			back1<=2'b10;
			end
		S_jump1:
			if(hpbar2<=5'd20)
			hpbar2<=8'b0;
			else if(dodge2==1'b1)
			begin
			hpbar2<=(hpbar2-4'd10);
			back2<=2'b01;
			end
			else
			begin
			hpbar2<=(hpbar2-5'd20);
			back2<=2'b10;
			end
		S_jump2:
			if(hpbar1<=5'd20)
			hpbar1<=8'b0;
			else if(dodge1==1'b1)
			begin
			hpbar1<=(hpbar1-4'd10);
			back1<=2'b01;
			end
			else
			begin
			hpbar1<=(hpbar1-5'd20);
			back1<=2'b10;
			end
		normal:
			begin
			hpbar2<=hpbar2;
			hpbar1<=hpbar1;
			back1<=2'b00;
			back2<=2'b00;
			end
		is_kick1:
			begin
			hpbar2<=hpbar2;
			hpbar1<=hpbar1;
			end
		is_fight1:
			begin
			hpbar2<=hpbar2;
			hpbar1<=hpbar1;
			end
		is_kick2:
			begin
			hpbar2<=hpbar2;
			hpbar1<=hpbar1;
			end
		is_fight2:
			begin
			hpbar2<=hpbar2;
			hpbar1<=hpbar1;
			end
		is_jump1:
			begin
			hpbar2<=hpbar2;
			hpbar1<=hpbar1;
			end
		is_jump2:
			begin
			hpbar2<=hpbar2;
			hpbar1<=hpbar1;
			end
	endcase
	end
end
always_comb
	begin
	 next_state=state;
	 unique case (state)

		    S_kick1:
			 next_state<=is_kick1;
			 S_fight1:
			 next_state<=is_fight1;
			 S_kick2:
			 next_state<=is_kick2;
			 S_fight2:
			 next_state<=is_fight2;
			 S_jump1:
			 next_state<=is_jump1;
			 S_jump2:
			 next_state<=is_jump2;
			 is_kick1:
			 begin
			 if(kick1)
			 next_state<=is_kick1;
			 else
			 next_state<=normal;
			 end
			 is_fight1:
			 begin
			 if(fight1)
			 next_state<=is_fight1;
			 else
			 next_state<=normal;
			 end
			 is_kick2:
			 begin
			 if(kick2)
			 next_state<=is_kick2;
			 else
			 next_state<=normal;
			 end
			 is_fight2:
			 begin
			 if(fight2)
			 next_state<=is_fight2;
			 else
			 next_state<=normal;
			 end
			 is_jump1:
			 begin
			 if(jump1)
			 next_state<=is_jump1;
			 else
			 next_state<=normal;
			 end
			 is_jump2:
			 begin
			 if(jump2)
			 next_state<=is_jump2;
			 else
			 next_state<=normal;
			 end			 
			 normal:
			 begin
			 if(kick1==1'b1&&valid1==1'b1&&hpbar1>=0&&hpbar2>=0)
			 next_state<=S_kick1;
			 else if(fight1==1'b1 && valid1==1'b1&&hpbar1>=0&&hpbar2>=0)
			 next_state<=S_fight1;
			 else if(kick2==1'b1 && valid2==1'b1&&hpbar1>=0&&hpbar2>=0)
			 next_state<=S_kick2;
			 else if(fight2==1'b1 && valid2==1'b1&&hpbar1>=0&&hpbar2>=0)
			 next_state<=S_fight2;
			 else if(jump1==1'b1 && valid1==1'b1&&hpbar1>=0&&hpbar2>=0)
			 next_state<=S_jump1;
			 else if(jump2==1'b1 && valid2==1'b1&&hpbar1>=0&&hpbar2>=0)
			 next_state<=S_jump2;
			 else
			 next_state<=normal;
			 end
	 endcase
	end
	assign hp1x=hp1_center_x+(8'd200-hpbar1);
	assign hp2x=hp2_center_x+hpbar2;
	assign p1win=p1;   
	assign p2win=p2;

	
	endmodule
		
		
	 
			 
			

						