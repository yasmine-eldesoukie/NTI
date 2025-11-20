module shift_reg_right_tb ();
 parameter WIDTH=4;
 reg clk, rst;
 reg en_tb;
 reg in_tb;
 wire d_out_dut;

  shift_reg_right dut (
    .clk(clk),
    .rst(rst),
    .en(en_tb),
    .in(in_tb),
    .d_out(d_out_dut)
  );

 initial begin
    clk= 0;
    forever begin
        #2 clk= ~clk;
    end
 end

 


endmodule