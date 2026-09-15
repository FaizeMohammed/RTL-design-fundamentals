module seq_d_tb();
reg clk,din,rstn;
wire detected;

seq_det dut(.din(din),.clk(clk),.rstn(rstn),.detected(detected));


	task check(input expected_tb);
	begin
	if( expected_tb==detected)
		$display("PASS detected");
	else
	$display("FAIL detected");
	end
	endtask

initial
begin
	clk=0;
	din=0;
	rstn=0;
end

always #5 clk=~clk;

initial
begin
	#2;
	rstn=1;
	din=1;
	@(posedge clk);
#1;
	check(0);

	#1;
	  din=0;
	@(posedge clk);
#1;

	check(0);

	#1;
	 din=1;
	@(posedge clk);#1;

	check(0);

	#1;
	 din=1;
	@(posedge clk);
#1;
	check(1);

#1;
	  din=0;
	@(posedge clk);
#1;
check(0);

	#1;
	 din=1;
	@(posedge clk);
#1;
	check(0);

	#1;
	 din=1;
	@(posedge clk);
#1;
check(1);

	#1;
	 din=1;
	@(posedge clk);
#1;
	check(0);

	#1;
	din=1;
	@(posedge clk);
#1;
check(0);

	#1;
	din=1;
	@(posedge clk);
#1;
check(0);

	#1;
	din=1;
	rstn=0;
	#1;
	@(posedge clk);
#1;
check(0);

	#1;
	rstn=1;
	din=1;
	@(posedge clk);
#1;
check(0);

	#1;
	din=0;
	@(posedge clk);
#1;
check(0);

	#1;
	din=0;
	@(posedge clk);
#1;
check(0);

	#5;
	$finish;
end

initial
$monitor("time=%d,rstn=%b,din=%b,state=%b,detected=%b",$time,rstn,din,dut.present_state,detected);

endmodule