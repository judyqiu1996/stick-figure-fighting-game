module ram_640x480x8(
						output q,
						input  d,
						input [19:0] write_address,read_address,
						input we,oe,clk
										);
logic  mem [19:0] ;
initial
begin
$readmemb("space1.txt", mem);
end
always_ff @ (posedge clk) 
begin
if (we)
begin
mem[write_address] <= d;
end
if(oe)
begin
q <= mem[read_address];
end
end

endmodule