module tb();

parameter width=3;
parameter depth=4;
reg clk,we;
reg [$clog2(depth)-1:0]addr;
reg [width-1:0]wdata;
wire [width-1:0]rdata;

single_port_ram a1(.clk(clk),.we(we),.addr(addr),.wdata(wdata),.rdata(rdata));

reg [width-1:0] expected_mem [depth-1:0];

initial
begin
clk=0;
end
always #5 clk=~clk;

task write(input we_in,input [width-1:0]wdata_in,input  [$clog2(depth)-1:0]addr_in);
begin
#2;
we=we_in;
wdata=wdata_in;
addr=addr_in;
@(posedge clk);
	if(we_in)
	expected_mem[addr_in]=wdata_in;

end
endtask


task read(input [$clog2(depth)-1:0] addr_in);
begin
    addr = addr_in;
    #1;

    if(rdata == expected_mem[addr_in])
        $display("PASS");
    else
        $display("FAIL: addr=%b expected=%b actual=%b",
                 addr_in, expected_mem[addr_in], rdata);
end
endtask
initial
begin
	
	write(1,3'b001,2'b00);
	write(1,3'b010,2'b01);
	write(1,3'b100,2'b10);
	write(1,3'b011,2'b11);
#2;	
	read(2'b00);
#2;
	read(2'b01);

#2;
	read(2'b11);

#2;
	read(2'b10);
 // Verify write enable = 0 does not modify memory

    write(0, 3'b111, 2'b01);

    #2;
    read(2'b01);

    $finish;

end

initial
begin
$monitor("Time=%t,wdata=%b,rdata=%b,addr=%b,we=%b",$time,wdata,rdata,addr,we);
end
endmodule
