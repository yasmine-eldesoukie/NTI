module rom_addr_counter_tb #(parameter WIDTH=8, DEPTH=84, ADDR= $clog2(DEPTH))();
 reg clk, rst;
 reg increment_tb;
 
 wire [WIDTH-1:0] data_out_dut;

 rom_counter_top dut (
 	.clk(clk),
	.rst(rst),
	.increment(increment_tb),
	.data_out(data_out_dut)
 );
  
  integer i;
  initial begin
 	clk=1'b0;
 	forever #1 clk= ~clk;
  end

  initial begin
  	rst=1'b0;
  	repeat (20) @(negedge clk);

  	rst=1'b1;

    for (i=0; i<DEPTH+1; i=i+1) begin
    	increment_tb=1'b1;
    	@(negedge clk);
  		$display("addr=%d, data_out=%h", dut.rd_addr, data_out_dut);
    end

    @(negedge clk);
    $stop;
  	
  end
endmodule