module seq_det(input din,clk,rstn,output detected);

	reg[2:0]next_state,present_state;

parameter s0=3'b000;//idle
parameter s1=3'b001;//1
parameter s2=3'b010;//10
parameter s3=3'b011;//101
parameter s4=3'b100;//1011

always@(posedge clk or negedge rstn)	
  begin
	if(!rstn)
		present_state<=s0;
	else
		present_state<=next_state;
end

always@(present_stae or din)
	begin
	next_state=s0;

	case(present_state)
		s0:if(din)
			next_state=s1;
			else
			next_state=s0;
		s1:if(din)
			next_state=s1;
			else
			next_state=s2;
		s2:if(din)
			next_state=s3;
			else
			next_state=s0;
		s3:if(din)
			next_state=s4;
			else
			next_state=s2;
		s4:if(din)
			next_state=s1;
			else
			next_state=s2;
	endcase
	end

assign detected =(present_state ==s4);
endmodule

