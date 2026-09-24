module tb();
reg clk,rstn,wr_en,rd_en;
reg [7:0]data_in;
wire [7:0]data_out;
wire full,empty;
reg [7:0] expected_queue[$];
reg [7:0]expected_data;

fifo dut(clk,rstn,wr_en,rd_en,data_in,data_out,full,empty);

initial
begin
 clk=0;
forever #5 clk=~clk;
end

task resetn();
 begin
	rstn=0; //like this or should it be flipped like first edge then stimulus
	@(negedge clk);
	rstn=1;
	@(negedge clk);
  end
endtask

task write(input wr_ena,input [7:0]data_inp);
	begin
		@(negedge clk);
	
		wr_en=wr_ena;
		data_in=data_inp;

	#1;if (wr_ena && !full) begin
      expected_queue.push_back(data_inp);
    end
	//	expected_queue.push_back(data_inp);

	end
endtask

task read(input  rd_ena);
   begin
      rd_en=rd_ena;

if(!empty)
  begin
      expected_data = expected_queue[0];
      expected_queue.pop_front();
	end
	

	@(posedge clk);
	#1;
if(data_out==expected_data)
		$display("Correct data out");
	else
		$display("Wrong data out expected_queue is %p and expected_dout is %d",expected_queue,expected_data);

  end
endtask

task write_read(input [7:0]data_inp);
begin
	wr_en=1;
	rd_en=1;
	data_in=data_inp;
	if(!empty)
		expected_data = expected_queue[0];

	@(posedge clk);
	#1;

if(!empty)
begin	
	if(data_out==expected_data)
	$display("Correct data out");
	else
	$display("Wrong data out expected_queue is %p and expected_dout is %d",expected_queue,expected_data);

expected_queue.pop_front();

end
 
 if(!full)
expected_queue.push_back(data_inp);
	
end
endtask

initial
begin
$monitor("Time=%d,rstn=%b,wr_en=%b,rd_en=%b,data_in=%d,data_out=%d,count=%d,full=%b,empty=%b",$time,rstn,wr_en,rd_en,data_in,data_out,dut.count,full,empty);
end

initial
begin
resetn;@(negedge clk);
#2;

@(negedge clk);
repeat(8)
write(1'b1,{$random}%256);
#10;
write(1'b0,8'd100);

repeat(10)
read(1'b1);
#20;
read(1'b0);

repeat(10)
write_read({$random}%100);
#10;

wr_en=0;
rd_en=0;
#50;
$finish;
end

endmodule

