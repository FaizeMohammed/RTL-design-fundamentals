module counter #(parameter width=4)(input clk,rstn,en,output reg [width-1:0]count);

always@(posedge clk or negedge rstn)
	begin
		if(!rstn)
			count<=0;
		else if(en)
			count<=count+1;
	end
endmodule
