//-------------------------------------------------------------------------
//      lab7_usb.sv                                                      --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Fall 2014 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 7                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module  lab8 		( input         CLOCK_50,
                       input[3:0]    KEY, //bit 0 is set up as Reset
							  output [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
							  //output [8:0]  LEDG,
							  //output [17:0] LEDR,
							  // VGA Interface 
                       output [7:0]  VGA_R,					//VGA Red
							                VGA_G,					//VGA Green
												 VGA_B,					//VGA Blue
							  output        VGA_CLK,				//VGA Clock
							                VGA_SYNC_N,			//VGA Sync signal
												 VGA_BLANK_N,			//VGA Blank signal
												 VGA_VS,					//VGA virtical sync signal	
												 VGA_HS,					//VGA horizontal sync signal
							  // CY7C67200 Interface
							  inout [15:0]  OTG_DATA,						//	CY7C67200 Data bus 16 Bits
							  output [1:0]  OTG_ADDR,						//	CY7C67200 Address 2 Bits
							  output        OTG_CS_N,						//	CY7C67200 Chip Select
												 OTG_RD_N,						//	CY7C67200 Write
												 OTG_WR_N,						//	CY7C67200 Read
												 OTG_RST_N,						//	CY7C67200 Reset
							  input			 OTG_INT,						//	CY7C67200 Interrupt
							  // SDRAM Interface for Nios II Software
							  output [12:0] DRAM_ADDR,				// SDRAM Address 13 Bits
							  inout [31:0]  DRAM_DQ,				// SDRAM Data 32 Bits
							  output [1:0]  DRAM_BA,				// SDRAM Bank Address 2 Bits
							  output [3:0]  DRAM_DQM,				// SDRAM Data Mast 4 Bits
							  output			 DRAM_RAS_N,			// SDRAM Row Address Strobe
							  output			 DRAM_CAS_N,			// SDRAM Column ASDddress Strobe
							  output			 DRAM_CKE,				// SDRAM Clock Enable
							  output			 DRAM_WE_N,				// SDRAM Write Enable
							  output			 DRAM_CS_N,				// SDRAM Chip Select
							  output			 DRAM_CLK,				// SDRAM Clock	
							  output [19:0] SRAM_ADDR,
							  inout  [15:0] SRAM_DQ,
							  output			 SRAM_CE_N,
							  output			 SRAM_UB_N,
							  output			 SRAM_LB_N,
							  output        SRAM_OE_N,
							  output			 SRAM_WE_N
											);
												
    logic Reset_h, vssig, Clk, right, left, stand, kick, fight, jump, dodge, st, du, sin, near1, back, back0;
	 logic right1, left1, stand1, kick1, fight1, jump1, dodge1;
	 logic p1win, p2win;
	 logic stand_left, stand_right, stand_left1, stand_right1, kick_1, fight_1, jump_1, dodge_1, kick_2, fight_2, jump_2, dodge_2, back_1, back_2;
    logic [9:0] drawxsig, drawysig, ballxsig, ballysig, ballxsig1, ballysig1, inX, inY;
	 logic [15:0] keycode, keycode1;
	 logic [1:0] back1, back2;
	 assign Clk = CLOCK_50;
    assign {Reset_h}=~ (KEY[0]);  // The push buttons are active low
	 always_comb
	 begin
	 SRAM_CE_N = 1'b0;
	 SRAM_UB_N = 1'b0;
	 SRAM_LB_N = 1'b0;
	 SRAM_OE_N = 1'b0;
	 SRAM_WE_N = 1'b1;
	 end
	 
	 wire [1:0] hpi_addr;
	 wire [15:0] hpi_data_in, hpi_data_out;
	 wire hpi_r, hpi_w,hpi_cs;
	 
	 hpi_io_intf hpi_io_inst(   .from_sw_address(hpi_addr),
										 .from_sw_data_in(hpi_data_in),
										 .from_sw_data_out(hpi_data_out),
										 .from_sw_r(hpi_r),
										 .from_sw_w(hpi_w),
										 .from_sw_cs(hpi_cs),
		 								 .OTG_DATA(OTG_DATA),    
										 .OTG_ADDR(OTG_ADDR),    
										 .OTG_RD_N(OTG_RD_N),    
										 .OTG_WR_N(OTG_WR_N),    
										 .OTG_CS_N(OTG_CS_N),    
										 .OTG_RST_N(OTG_RST_N),   
										 .OTG_INT(OTG_INT),
										 .Clk(Clk),
										 .Reset(~KEY[1])
	 );
	 

	 nios_system nios_system(
										 .clk_clk(Clk),         
										 .reset_reset_n(KEY[1]),   
										 .sdram_wire_addr(DRAM_ADDR), 
										 .sdram_wire_ba(DRAM_BA),   
										 .sdram_wire_cas_n(DRAM_CAS_N),
										 .sdram_wire_cke(DRAM_CKE),  
										 .sdram_wire_cs_n(DRAM_CS_N), 
										 .sdram_wire_dq(DRAM_DQ),   
										 .sdram_wire_dqm(DRAM_DQM),  
										 .sdram_wire_ras_n(DRAM_RAS_N),
										 .sdram_wire_we_n(DRAM_WE_N), 
										 .sdram_clk_clk(DRAM_CLK),
										 .keycode_export(keycode),  
										 .otg_hpi_address_export(hpi_addr),
										 .otg_hpi_data_in_port(hpi_data_in),
										 .otg_hpi_data_out_port(hpi_data_out),
										 .otg_hpi_cs_export(hpi_cs),
										 .otg_hpi_r_export(hpi_r),
										 .otg_hpi_w_export(hpi_w),
										 .keycode1_export(keycode1)								 
									);
		address				address( .drawx(drawxsig),
											.drawy(drawysig),
											.address(SRAM_ADDR),
											.start(st),
											.dual(du),
											.single(sin)
										//	.OE(SRAM_OE_N)
											);
	


		blitter(
										 .*, .Reset(Reset_h),
										.positionX(ballxsig), 
										.DrawX(drawxsig), 
										.DrawY(drawysig),
										.BallX(inX),
										.BallY(inY),
										.positionX1(ballxsig1), 
										.positionY1(ballysig1),
										.positionY(ballysig), 
										.data0(SRAM_DQ[14:0]), 
										.frame_clk(VGA_VS),
										.right(right), 
										.left(left), 
										.stand(stand), 
										.kick(kick),
										.start(st),
										.Red(VGA_R), 
										.Green(VGA_G), 
										.Blue(VGA_B)
										);
			  
    vga_controller vgasync_instance(
													.*,
													.Reset(Reset_h),
													.hs(VGA_HS),
													.vs(VGA_VS),
													.pixel_clk(VGA_CLK),
													.blank(VGA_BLANK_N),
													.sync(VGA_SYNC_N),
													.DrawX(drawxsig),
													.DrawY(drawysig)
													);
	
   
    ball ball_instance(		
								.frame_clk(VGA_VS), .*,
								.Reset(Reset_h),
								.BallX(ballxsig),
								.BallY(ballysig),
								.right(right), .left(left), .stand(stand), .kick(kick), .start(st), .BallX1(ballxsig1), .BallY1(ballysig1),
								.keycode(keycode), .keycode1(keycode1),
								);
	
	/* ball_second ball_second_instance(		
								.Reset(Reset_h),
								.frame_clk(VGA_VS), .*,
								.BallX(ballxsig1),
								.BallY(ballysig1),
								.right(right1), .left(left1), .stand(stand1), .kick(kick1), .fight(fight1), .jump(jump1), .BallX1(ballxsig), .BallY1(ballysig), .dodge(dodge1), .back(back0),
								.keycode(keycode), .keycode1(keycode1)
								); */
								
	mode_choose mode_choose0(.*, .right(right1), .left(left1), .stand(stand1), .kick(kick1), .fight(fight1), .jump(jump1), .dodge(dodge1));
	
	
	indicator indicator( .*,
								.Reset(Reset_h),
								.frame_clk(VGA_VS),
								.keycode(keycode[7:0]),
								.BallX(inX),
								.BallY(inY),
								.dual(du),
								.single(sin)
								);
   

										  
	 HexDriver hex_inst_0 (keycode[3:0], HEX0);
	 HexDriver hex_inst_1 (jump_1, HEX1);
    HexDriver hex_inst_2 (fight_1, HEX2);
	 HexDriver hex_inst_3 (dodge_1, HEX3);
	 HexDriver hex_inst_5 (kick_1, HEX4);
	 HexDriver hex_inst_6 (stand_right, HEX5);
    HexDriver hex_inst_7 (back2[1:0], HEX6);
	 HexDriver hex_inst_8 (back1[1:0], HEX7);
    

	 /**************************************************************************************
	    ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
		 Hidden Question #1/2:
          What are the advantages and/or disadvantages of using a USB interface over PS/2 interface to
			 connect to the keyboard? List any two.  Give an answer in your Post-Lab.
     **************************************************************************************/
endmodule
