module lfsr_tb ();
 parameter WIDTH=4;
 reg clk, rst, en_tb;
 reg in_tb;
 wire [WIDTH-1:0] lfsr_dut;

 reg [WIDTH-1:0] in;

 lfsr dut (
    .clk(clk),
    .rst(rst),
    .en(en_tb),
    .in(in_tb),
    .lfsr(lfsr_dut)
 );

 initial begin
    clk= 0;
    forever begin
        #2 clk= ~clk;
    end
 end


 integer i;
 initial begin
    rst=1'b0;
    en_tb=1'b0;
    repeat (50) @(negedge clk);
    
    rst =1'b1;
    en_tb=1'b1;
    for (i=0; i<4; i=i+1) begin
        in= 'b1010;
        in_tb=in[i];
        @(negedge clk);
    end
    
    en_tb=1'b0;
    repeat (5) @(negedge clk);
    $stop;
 end
endmodule