module fifo(input clk,rstn,wr_en,rd_en,
input [7:0]data_in,output reg[7:0]data_out,output full,empty);

reg [7:0]mem[7:0];
reg [2:0]wr_ptr;
reg [2:0]rd_ptr;
reg[3:0]count;
always@(posedge clk or negedge rstn)
begin
	if(!rstn)
	begin
		data_out<=0;
		wr_ptr<=0;
		rd_ptr<=0;
		count<=0;
	end
	else 
	    begin
		   if((wr_en==1 && !full) && (rd_en==1 && !empty))
			begin
				mem[wr_ptr]<=data_in;
				     wr_ptr<=wr_ptr+1;
				data_out<=mem[rd_ptr];
				rd_ptr<=rd_ptr+1;
			end
		    else if(wr_en==1 && !full)
		
			begin
				mem[wr_ptr]<=data_in;
				wr_ptr<=wr_ptr+1;
				count<=count+1;
			end
		    else if(rd_en==1 && !empty)
			
			begin
			data_out<=mem[rd_ptr];
			rd_ptr<=rd_ptr+1;
			count<=count-1'b1;
			end
	      end
end
assign empty=(count==0);
assign full =(count==8);
endmodule

