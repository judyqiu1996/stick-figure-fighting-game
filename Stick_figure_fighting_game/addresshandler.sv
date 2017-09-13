module address(input [9:0] drawx,drawy,
					input start,
					input dual,
					input single,
					output OE,
					output [31:0] address
					//output [3:0] location
					);
assign OE=1'b0;
always_comb
begin
if (start==1'b1 &&dual==1'b1)
begin
address= 20'h4b000+(drawx*480+drawy);
end
else if (start==1'b1 &&single==1'b1)
begin
address= 20'h96000+(drawx*480+drawy);
end
else
begin					
address= (drawx*480+drawy);//(2d'16)
end
end

//assign location=(drawy*480+drawx)%(2d'16);
endmodule