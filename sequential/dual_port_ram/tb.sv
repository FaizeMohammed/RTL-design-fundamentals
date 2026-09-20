module tb;

reg we,re,clk;
reg [2:0]wr_addr,rd_addr;
reg [15:0]data_in;
wire [15:0]data_out;

reg [15:0] expected_mem [7:0];

dual_port_ram_8x16 dut(.clk(clk),.we(we),.re(re),.wr_addr(wr_addr),.rd_addr(rd_addr),.data_in(data_in),.data_out(data_out));

task write(input [2:0]wr_addr_t,input [15:0]data_in_t);
begin
	we=1'b1;
	wr_addr=wr_addr_t;
	data_in=data_in_t;

	@(posedge clk);

	expected_mem[wr_addr]=data_in_t;
$display("write operation we=%b,wr_addr=%b,data_in=%d",we,wr_addr,data_in);

	we=0;
	@(posedge clk);
	
end
endtask

task read (input [2:0]rd_addr_t);
begin
	re=1;
	rd_addr=rd_addr_t;

	@(posedge clk);
#1;
if(data_out === expected_mem[rd_addr_t])
        $display("READ PASS: addr=%b expected=%d actual=%d",
                 rd_addr_t, expected_mem[rd_addr_t], data_out);
    else
        $display("READ FAIL: addr=%b expected=%d actual=%d",
                 rd_addr_t, expected_mem[rd_addr_t], data_out);

	re=0;

	@(posedge clk);

	
end
endtask

task read_write(input [2:0]wr_addr_t,input [15:0]data_in_t,input [2:0]rd_addr_t);
reg [15:0]old_data;
begin
	old_data=expected_mem[rd_addr_t];

		we=1;
	wr_addr=wr_addr_t;
	data_in=data_in_t;

	re=1;
	rd_addr=rd_addr_t;

	@(posedge clk);
#1;

	expected_mem[wr_addr_t]=data_in_t;

	 if(data_out === old_data)
        $display("READ-WRITE PASS: wr_addr=%b data=%d rd_addr=%b old_data=%d",
                 wr_addr_t, data_in_t, rd_addr_t, data_out);
    else
        $display("READ-WRITE FAIL: wr_addr=%b data=%d rd_addr=%b expected_old=%d actual=%d",
                 wr_addr_t, data_in_t, rd_addr_t, old_data, data_out);
	we=0;
	re=0;
	@(posedge clk);
	

end
endtask

initial clk=1'b0;
always #5 clk=~clk;

initial begin
    we = 0;
    re = 0;
    wr_addr = 0;
    rd_addr = 0;
    data_in = 0;
end
initial
	begin
		 write(3'b010,16'd156);
		#5;
		 read (3'b010);		
#5;
		 read_write(3'b100,16'd125,3'b100);
#2;
		read(3'b100);
#3;
	 write(3'b000,16'd111);
		 read (3'b011);

#10;
$finish;
end
	initial
begin
    $monitor("Time=%0t we=%b re=%b wr_addr=%b rd_addr=%b data_in=%d data_out=%d",
             $time, we, re, wr_addr, rd_addr, data_in, data_out);
end

	
endmodule
	
		
		

 
