	lab7_soc u0 (
		.clk_clk                (<connected-to-clk_clk>),                //             clk.clk
		.key3_export            (<connected-to-key3_export>),            //            key3.export
		.keycode_export         (<connected-to-keycode_export>),         //         keycode.export
		.otg_hpi_address_export (<connected-to-otg_hpi_address_export>), // otg_hpi_address.export
		.otg_hpi_cs_export      (<connected-to-otg_hpi_cs_export>),      //      otg_hpi_cs.export
		.otg_hpi_data_in_port   (<connected-to-otg_hpi_data_in_port>),   //    otg_hpi_data.in_port
		.otg_hpi_data_out_port  (<connected-to-otg_hpi_data_out_port>),  //                .out_port
		.otg_hpi_r_export       (<connected-to-otg_hpi_r_export>),       //       otg_hpi_r.export
		.otg_hpi_w_export       (<connected-to-otg_hpi_w_export>),       //       otg_hpi_w.export
		.reset_reset_n          (<connected-to-reset_reset_n>),          //           reset.reset_n
		.sdram_clk_clk          (<connected-to-sdram_clk_clk>)           //       sdram_clk.clk
	);

