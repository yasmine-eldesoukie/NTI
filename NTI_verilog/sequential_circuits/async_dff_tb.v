module async_dff_tb ();
 parameter WIDTH=1;
 reg clk, rst;
 reg [WIDTH-1:0] in_tb;
 wire [WIDTH-1:0] d_dut;

 async_dff dut (
    .clk(clk),
    .rst(rst),
    .in(in_tb),
    .d(d_dut)
 );

 initial begin
    clk= 0;
    forever begin
        #2 clk= ~clk;
    end
 end

 initial begin
    rst=1'b0;
    repeat (50) @(negedge clk);
    
    in_tb='b1;
    repeat (10) @(negedge clk);

    rst =1'b1;
    repeat (10) @(negedge clk);
    in_tb='b1;

 end
endmodule