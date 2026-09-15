module V_TB();

reg clk,reset;
reg [1:0]coin;
wire Product,Return;

vending_machine dut(.clk(clk),.reset(reset),.coin(coin),.Product(Product),.Return(Return));

task rst;
	begin
	@(posedge clk);
		reset=1'b1;
	@(posedge clk);
		reset=1'b0;
	end
endtask

task insert_coin(input [1:0]coins);
	begin
	@(posedge clk);
		coin=coins;
	@(posedge clk);
		#1;
		coin=2'b00;
	end
endtask

task check(input P_check,R_check);
	begin
		if(P_check==Product && R_check==Return)
			$display("PASS");
		else
			$display("FAILED ,Expected Product=%b, & Return=%b,Actual Product=%b,Return=%b",P_check,R_check,Product,Return);
	end
endtask

initial	clk=1'b0;
		always #5 clk=~clk;
	

initial
begin
    rst;

    // TESTCASE 1: 1 + 1 + 1 = 3 => Product
    insert_coin(2'b01);
    insert_coin(2'b01);
    insert_coin(2'b01);
    @(posedge clk);
    check(1,0);

    // TESTCASE 2: 2 + 2 = 4 => Product + Return
    insert_coin(2'b10);
    insert_coin(2'b10);
    @(posedge clk);
    check(1,1);

    // TESTCASE 3: 1 + 2 = 3 => Product
    insert_coin(2'b01);
    insert_coin(2'b10);
    @(posedge clk);
    check(1,0);

    // TESTCASE 4: 2 + 1 = 3 => Product
    insert_coin(2'b10);
    insert_coin(2'b01);
    @(posedge clk);
    check(1,0);

    // TESTCASE 5: Only 1 coin => No Product
    insert_coin(2'b01);
    @(posedge clk);
    check(0,0);

    rst;

    // TESTCASE 6: No coin inserted => Stay idle
    @(posedge clk);
    check(0,0);

    // TESTCASE 7: Invalid coin = 11 => Ignore
    @(posedge clk);
    coin = 2'b11;
    @(posedge clk);
    coin = 2'b00;
    @(posedge clk);
    check(0,0);

    // TESTCASE 8: Reset in middle transaction
    insert_coin(2'b01);   // total = 1
    rst;
    @(posedge clk);
    check(0,0);

    // TESTCASE 9: Back-to-back purchases
    insert_coin(2'b01);
    insert_coin(2'b10);
    @(posedge clk);
    check(1,0);

    insert_coin(2'b10);
    insert_coin(2'b10);
    @(posedge clk);
    check(1,1);

    // TESTCASE 10: Hold coin high multiple clocks
    @(posedge clk);
    coin = 2'b01;
    @(posedge clk);
    @(posedge clk);
    coin = 2'b00;
    @(posedge clk);

    $finish;
end
initial
begin
$monitor("T=%0t coin=%b Product=%b Return=%b",
$time,coin,Product,Return);
end
endmodule


