module dual_port_ram_8x16(input clk,
		input we,
		input re,
		input [2:0]wr_addr,
		input [2:0]rd_addr,
		input [15:0]data_in,
		output reg [15:0]data_out);

reg [15:0]mem[7:0];

always@(posedge clk)
	begin
		if(we) begin
			mem[wr_addr] <= data_in;
			end


		if(re) begin
			data_out<=mem[rd_addr];
			end
		end
endmodule	
