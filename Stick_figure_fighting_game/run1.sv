module run1(
						output q,
						input  d,
						input [14:0] write_address,read_address,
						input we,oe,clk
										);
logic  mem [14:0] ;
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
initial
begin
$readmemb("run1.txt", mem);
end








endmodule