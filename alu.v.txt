module alu #(parameter width=4)(input [width-1:0]a,b,input [2:0]opcode,output logic [width-1:0]result,output logic carry,zero);

always_comb
	begin
		result=0;
		carry=0;
	
	case(opcode)
		3'b000:{carry,result} = a+b; //ADD
		3'b001:begin
			if(a<b)
				begin
				carry=1;
				end
			result = a-b; //SUB
			end
		3'b010:result = a & b; //AND
		3'b011:result = a|b; //OR
		3'b100:result = a^b; //XOR
		3'b101:result = a<<1; //SHIFTL 
		3'b110:result = a>>1;//SHIFTR
		3'b111:result = a>b;//COMPARE
	endcase
	
	end
assign zero=result?1'b0:1'b1;

endmodule

