`timescale 1ns/1ps
module UART_ROM_counter_top_tb #(parameter
    CLKS_PER_BIT=3, 
	WIDTH=8, DEPTH=84, 
	ADDR= $clog2(DEPTH),
	FILE= "rom_data_names_hex.txt"
	)();

	//signal declaration
    reg clk, rst; 
    reg uart_en_tb;
    wire uart_tx_out_dut;
    wire uart_busy_dut;

    reg [9:0] tx_out_reg;

    //instantiation
    UART_ROM_counter_top #(CLKS_PER_BIT) dut (
    	.clk(clk), 
    	.rst(rst), 
        .uart_en(uart_en_tb),
        .uart_tx_out(uart_tx_out_dut),
        .uart_busy(uart_busy_dut)
    );

    initial begin
 		clk=1'b0;
 		forever #1 clk= ~clk;
    end
    
    //stimulus generation
    integer i;
	initial begin
    	rst =1'b0;
    	repeat (20) @(negedge clk);

    	rst=1'b1;

        for (i=0; i<10*(DEPTH-1); i=i+1) begin //farme is 10 bits
			uart_en_tb=1'b1;
        	@(negedge clk);
        	uart_en_tb=1'b0;
        	@(negedge clk);
        	
			repeat (CLKS_PER_BIT-2) @(negedge clk);
			tx_out_reg[i%10]=uart_tx_out_dut;

            //test at the lasty bit 9,19,29,...hence i/10
			if (i%10==9 && tx_out_reg != {1'b1, dut.rom_counter_top.rom.rom[(i/10)] ,1'b0}) begin
				$stop;
			end

			if (i%10==9) repeat(CLKS_PER_BIT) @(negedge clk);

    	end
		@(negedge clk);
        $stop;
    end
		
endmodule



