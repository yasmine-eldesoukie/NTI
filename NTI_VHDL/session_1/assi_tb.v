module assi_tb ();
 reg a_tb, b_tb;
 wire [5:0] z_dut;

 assi_1 dut (
    .a(a_tb),
    .b(b_tb),
    .z(z_dut)
 );

 integer i;
 initial begin
    for (i=0; i<4; i=i+1) begin
        a_tb=i[0];
        b_tb=i[1];
        #1;
    end 
    #1;
    $stop;   
 end

endmodule