module dff #(parameter width=4)(input clk,rstn,input [width-1:0]d,output reg [width-1:0]q);

always@(posedge clk or negedge rstn)
	begin
		if(!rstn)
			q<=0;
		else
			q<=d;
	end
endmodule
