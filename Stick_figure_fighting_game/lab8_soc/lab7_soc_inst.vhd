	component lab7_soc is
		port (
			clk_clk                : in  std_logic                     := 'X';             -- clk
			key3_export            : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			keycode_export         : out std_logic_vector(15 downto 0);                    -- export
			otg_hpi_address_export : out std_logic_vector(1 downto 0);                     -- export
			otg_hpi_cs_export      : out std_logic;                                        -- export
			otg_hpi_data_in_port   : in  std_logic_vector(15 downto 0) := (others => 'X'); -- in_port
			otg_hpi_data_out_port  : out std_logic_vector(15 downto 0);                    -- out_port
			otg_hpi_r_export       : out std_logic;                                        -- export
			otg_hpi_w_export       : out std_logic;                                        -- export
			reset_reset_n          : in  std_logic                     := 'X';             -- reset_n
			sdram_clk_clk          : out std_logic                                         -- clk
		);
	end component lab7_soc;

	u0 : component lab7_soc
		port map (
			clk_clk                => CONNECTED_TO_clk_clk,                --             clk.clk
			key3_export            => CONNECTED_TO_key3_export,            --            key3.export
			keycode_export         => CONNECTED_TO_keycode_export,         --         keycode.export
			otg_hpi_address_export => CONNECTED_TO_otg_hpi_address_export, -- otg_hpi_address.export
			otg_hpi_cs_export      => CONNECTED_TO_otg_hpi_cs_export,      --      otg_hpi_cs.export
			otg_hpi_data_in_port   => CONNECTED_TO_otg_hpi_data_in_port,   --    otg_hpi_data.in_port
			otg_hpi_data_out_port  => CONNECTED_TO_otg_hpi_data_out_port,  --                .out_port
			otg_hpi_r_export       => CONNECTED_TO_otg_hpi_r_export,       --       otg_hpi_r.export
			otg_hpi_w_export       => CONNECTED_TO_otg_hpi_w_export,       --       otg_hpi_w.export
			reset_reset_n          => CONNECTED_TO_reset_reset_n,          --           reset.reset_n
			sdram_clk_clk          => CONNECTED_TO_sdram_clk_clk           --       sdram_clk.clk
		);

