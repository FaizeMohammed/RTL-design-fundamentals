module dff_multibit_tb();
parameter width=4;
reg clk,rstn;
reg [width-1:0]d;
wire [width-1:0]q;


reg [width-1:0]q_expected;

		always@(posedge clk or negedge rstn)
		begin
		if(!rstn)
			q_expected<=0;
		else
	
			q_expected<=d;
	
		end

dff #(.width(width)) dut (
    .clk(clk),
    .rstn(rstn),
    .d(d),
    .q(q)
);

initial
begin
	clk=0;
	rstn=0;
	d=0;
end

always #5 clk=~clk;

initial
	begin
		#2;
		 rstn=0;
	
		check();

		#2;
		 rstn=1;
		check();

		 d=4'b1010;

		@(posedge clk);
		#1;	
		check();

		d=4'b0110;
		#1;	
		check();

		@(posedge clk);

		#1;
		check();

		 rstn=0;

		#2;
		 rstn=1;
		check();

		#20;
		$finish;
	end

initial
	$monitor("time=%t,rstn=%b,d=%b,q=%b",$time,rstn,d,q);

	
task check();
	begin

	if(q_expected==q)
		$display("PASS,Time=%t,rstn=%b,d=%b,q=%b",$time,rstn,d,q);
	else
		$display("FAIL,Time=%t,rstn=%b,d=%b,q=%b",$time,rstn,d,q);
	end
endtask

endmodule
		
