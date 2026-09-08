module alu_tb();
parameter width=4;
reg [width-1:0]a,b;
reg [2:0]opcode;
wire [width-1:0]result;
wire carry,zero;

alu a1(.a(a),.b(b),.opcode(opcode),.result(result),.carry(carry),.zero(zero));

initial
	begin
		a=4'd3;
		b=4'd2;
		opcode=3'd0;
#5;
		check();
#5;
		
		a=4'd15;
		b=4'd1;
#5;

		check();
#5;
		a=4'd5;
		b=4'd2;
		opcode=3'd1;
#5;

		check();
#5;
		a=4'd2;
		b=4'd5;
#5;

		check();

#5;
		a=4'b1010;
		b=4'b1100;
		opcode=3'd2;
#5;

		check();

#5;
		opcode=3'd3;
#5;

		check();

#5;
		opcode=3'd4;
#5;

		check();
#5;
		opcode=3'd5;
#5;

		check();

#5;
		opcode=3'd6;
#5;

		check();
#5;
		a=4'd5;
		b=4'd3;
		opcode=3'd7;
#5;

		check();

#5;
		a=4'd3;
		b=4'd5;
#5;

		check();

#5;
$finish;
	end

initial
	begin
	
	$monitor("a=%b,b=%b,opcode=%b,result=%b,carry=%b,zero=%b",a,b,opcode,result,carry,zero);
	end

reg [width-1:0]expected_result=0;
reg expected_carry=0;
reg expected_zero;


task check();
begin
expected_carry=0;
expected_result=0;
case(opcode)
		3'b000:{expected_carry,expected_result} = a+b; //ADD
		3'b001:begin
			if(a<b)
			begin
				expected_carry=1;
			end
			expected_result = a-b; //SUB
			end
		3'b010:expected_result = a & b; //AND
		3'b011:expected_result = a|b; //OR
		3'b100:expected_result = a^b; //XOR
		3'b101:expected_result = a<<1; //SHIFTL 
		3'b110:expected_result = a>>1;//SHIFTR
		3'b111:expected_result = a>b;//COMPARE
	endcase
	
 expected_zero=expected_result?0:1;

if({zero,carry,result}=={expected_zero,expected_carry,expected_result})
	$display("PASS");
else
$display("FAIL");
end
endtask
endmodule
		