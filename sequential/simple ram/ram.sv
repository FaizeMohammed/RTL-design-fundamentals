module single_port_ram#(parameter width=3,parameter depth=4)(clk,we,addr,wdata,rdata);
input clk,we;
input [$clog2(depth)-1:0]addr;
input [width-1:0]wdata;
output [width-1:0]rdata;

	logic [width-1:0]mem[depth-1:0];

always@(posedge clk)
begin
	if(we)
		mem[addr]<=wdata;
end

assign rdata=mem[addr];

endmodule
		
