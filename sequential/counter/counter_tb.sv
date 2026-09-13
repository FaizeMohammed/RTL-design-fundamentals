module counter_tb();
parameter width=4;
reg rstn,clk,en;
wire [width-1:0]count;
reg [width-1:0]count_expected;

counter a1(.rstn(rstn),.en(en),.clk(clk),.count(count));

initial
	begin
		rstn=0;
		clk=0;
		en=0;
	end

always #5 clk=~clk;

always @(posedge clk or negedge rstn)
begin
    if(!rstn)
        count_expected <= 0;
    else if(en)
        count_expected <= count_expected + 1;
end

task check();
begin
		if(count_expected==count)
	$display("PASS,count_expected=%d,count_dut=%d",count_expected,count);

	else
	$display("FAIL,count_expected=%d,count_dut=%d",count_expected,count);
end
endtask

initial
	begin
		rstn=0; //

		#2;
		rstn=1;  

		en=1;    //start counting

		repeat(15)
		@(posedge clk);

		#1;
		check();   //now count is 15

		repeat(2)
		@(posedge clk);
		#1;

		check();    //count is 1 now

		rstn=0;    //asynchronous reset checked
		#1;
		check();

		rstn=1; 
		en=1;
		repeat(10) //now count is again incremented
		@(posedge clk);


		en=0; //count should remaiin 10
		@(posedge clk);
		@(posedge clk);
		#1;

		check();
		

		$finish;
	end

	initial
		begin
		$monitor("time=%t,rstn=%b,en=%b,count=%b",$time,rstn,en,count);
		end

