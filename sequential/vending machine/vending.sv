module vending_machine( clk,reset,coin,Product,Return);

input clk,reset;
input [1:0]coin;
output Product,Return;

parameter S0=3'b000;
parameter S1=3'b001;
parameter S2=3'b010;
parameter S3=3'b011;
parameter S4=3'b100;

reg [2:0]state,next_state;

always@(posedge clk)
	begin
		if(reset)
			state<=S0;
		else
			state<=next_state;
	end

always@(*)
	begin
	next_state=S0;
		case(state)
			S0:case(coin)
				2'b01:next_state=S1;
				2'b10:next_state=S2;
				default:next_state=S0;
			    endcase
			
			S1:case(coin)
				2'b01:next_state=S2;
				2'b10:next_state=S3;
				default:next_state=S1;
			   endcase

			S2:case(coin)
				2'b01:next_state=S3;
				2'b10:next_state=S4;
				default:next_state=S2;
			  endcase

			S3:next_state=S0;

			S4:next_state=S0;
		endcase
	end

assign Product=(state==S3)||(state==S4);
assign Return=(state==S4);

endmodule
