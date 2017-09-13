module  frameRAM
(
		input [3:0] data_In,
		input [31:0] write_address, read_address,
		input we, Clk,

		output  [3:0] data_Out
);

logic [3:0] mem [0:307199]; 				// Frame buffer through the use of onchip memory

initial
begin
	 $readmemh("space7.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		begin
		mem[write_address] <= data_In;
		end
end
// assign	data_Out=mem[read_address]; 
endmodule