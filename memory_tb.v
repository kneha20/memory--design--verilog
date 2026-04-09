`include "memory.v"
module memory_tb;
parameter WIDTH=8;
parameter DEPTH=32;
parameter ADDR_WIDTH=$clog2(DEPTH);

reg clk,res,wr_rd,valid;
reg [ADDR_WIDTH-1:0]addr;
reg [WIDTH-1:0]wdata;
wire[WIDTH-1:0]rdata;
wire ready;

memory dut(.clk(clk),.res(res),.wr_rd(wr_rd),.wdata(wdata),.rdata(rdata),.valid(valid),.ready(ready),.addr(addr));
integer i;
reg[8*DEPTH-1:0]test_name;
always #5 clk=~clk;
initial begin
  clk=0;
  res=1;
  addr=0;
  wr_rd=0;
  wdata=0;
  valid=0;
  repeat(2) @(posedge clk)
  res=0;

$value$plusargs("test_name=%0s",test_name);
case(test_name)
  "1WR_1RD":begin
     write(10,1);
	 read(10,1);
  end
  "5WR_5RD":begin
     write(10,5);
	 read(10,5);
  end
  "FDWR_FDRD":begin
     write(0,32);
	 read(0,32);
  end
  "BDWR_BDRD":begin
     bd_write();
	 bd_read();
  end
  "FDWR_BDRD":begin
     write(0,DEPTH);
	 bd_read();
  end
  "BDWR_FDRD":begin
     bd_write();
	 read(0,DEPTH);
  end
  "1st_Quarter":begin
     write(0,DEPTH/4);
	 read(0,DEPTH/4);
  end
  "2nd_Quarter":begin
     write(DEPTH/4,DEPTH/4);
	 read(DEPTH/4,DEPTH/4);
  end
  "3rd_Quarter":begin
     write(DEPTH/2,DEPTH/4);
	 read(DEPTH/2,DEPTH/4);
  end
  "4th_Quarter":begin
     write((3*DEPTH)/4,DEPTH/4);
	 read((3*DEPTH)/4,DEPTH/4);
  end
  "consecutive":begin
     for(i=0;i<DEPTH;i=i+1)
	 consecutive_wr_rd(i);
	 end

  default:$display("test case failed");
endcase

    #50;
  $finish;
end
task write(input reg[ADDR_WIDTH-1:0]start_loc,input reg[ADDR_WIDTH:0]num_loc);begin
  //write
  for(i=start_loc;i<(start_loc+num_loc);i=i+1)begin // to write @ all locations
  @(posedge clk);// loop shld exist only @(posedge clk)
  wr_rd=1;
  addr=i;
  wdata=$random;
  valid=1;
  wait(ready==1);
  end
  @(posedge clk);//it should reset @ next posedge
  wr_rd=0;
  addr=0;
  wdata=0;
  valid=0;
  end
endtask
task read(input reg[ADDR_WIDTH-1:0]start_loc,input reg[ADDR_WIDTH:0]num_loc);begin
 //read
  for(i=start_loc;i<(start_loc+num_loc);i=i+1)begin // to read @ all loactions
  @(posedge clk) // loop shld exist only @ (posedge clk)
  wr_rd=0;
  addr=i;
  valid=1;
  wait(ready==1);
  end
  @(posedge clk);//reset @ next posedge 
  addr=0;
  valid=0;
  end
endtask
task bd_write();
  $readmemh("input.hex",dut.mem);
endtask
task bd_read();
 $writememh("output.hex",dut.mem);
endtask
task consecutive_wr_rd(input integer N);begin
  @(posedge clk)
  wr_rd=1;
  addr=N;
  wdata=$random;
  valid=1;
  wait(ready==1);
  @(posedge clk)
  wr_rd=0;
  addr=0;
  wdata=0;
  valid=0;
 @(posedge clk)
  wr_rd=0;
  addr=N;
  valid=1;
  wait(ready==1);
  @(posedge clk)
  wr_rd=0;
  addr=0;
  wdata=0;
  valid=0;

  end
endtask
endmodule

