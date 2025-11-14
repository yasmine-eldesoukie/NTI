`timescale 1ns/1ps
module UART_TX_REG_FILE_tb #(parameter PERIOD=5, CLKS_PER_BIT=3);
    //signal declaration
    //inputs
    reg clk, rst;
    reg wr_en_tb, rd_en_tb;
    reg wr_addr_tb, rd_addr_tb;
    reg [7:0] wr_data_tb;
    
    //dut outputs
    wire tx_out_dut;
    wire [7:0] rd_data_dut;
 
    //expected outputs
    reg tx_out_expec;
    reg [7:0] rd_data_expec;

    reg busy_expec, done_expec;
    
    //internal signals
    reg [9:0] tx_out_reg;
    
         //equality task inputs//
    //reg [7:0] x_dut, x_expec; 
    //reg [2:0] error_code;


    //instantiation
    UART_TX_REG_FILE_TOP #(.CLKS_PER_BIT(CLKS_PER_BIT)) dut (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en_tb),
        .rd_en(rd_en_tb),
        .wr_addr(wr_addr_tb),
        .rd_addr(rd_addr_tb),
        .wr_data(wr_data_tb),
        .rd_data(rd_data_dut),
        .tx_out(tx_out_dut)
    );

    //clk generation
    always #(PERIOD/2) clk=~clk;

    //stimulus generation in case of a parity bit
    integer i,j;
    initial begin
        $dumpfile("UART_TX.vcd");
        $dumpvars;

        clk=1'b0;

    ///////// Test case 1: Reset dominance /////////
    	reset_dominance;

    //////// Test case 2: microcontroller writing ///////
        check_micro_write;
        
    ///////// Test case 3: Normal functionality /////////
        //uart enable signal =1 

        rst=1'b0; 
        wr_en_tb=1'b0;
        rd_en_tb= 1'b0;
        repeat (20) @(negedge clk);
        rst=1'b1; 
        repeat (20) @(negedge clk);

        //test different uart p_data (reading from tx_out_dut & checking busy and done signals from reg_file)
        // steps: 1-load p_data  2-turn off enable siganl  3-turn on rd_en until uart_done signal  4-turn on uart enable again  
        for (i=0 ; i<256 ; i=i+1) begin
        	//1- enable uart
        	rd_en_tb=1'b0;
        	wr_en_tb= 1'b1;
	        wr_addr_tb= 1'b0;
	        wr_data_tb= 8'b1;
	        repeat (2) @(negedge clk);

	        check_equlaity(tx_out_dut, 1'b0, 5); //check start bit beacuse it starts right after enable signal
	        check_equlaity(dut.uart_tx.busy, 1'b1, 6);
        	//2-load p_data
        	rd_en_tb=1'b0;
        	wr_en_tb= 1'b1;
        	wr_addr_tb= 1'b1;
            wr_data_tb=i;

            //generating expected output
            tx_out_reg={1'b1             ,wr_data_tb,1'b0};
            rd_data_expec= 8'b1; //busy signal on

            //test the frame
            for (j=1; j<10*CLKS_PER_BIT; j=j+1 ) begin //because one bit of the start bits has already shown and was tested
                //3-turn off enable signal 1 clk after loading p_data
                if (j==2) begin
                	wr_en_tb=1'b1;
            		wr_addr_tb= 1'b0;
            		wr_data_tb= 1'b0;
                end
                tx_out_expec=tx_out_reg[j/CLKS_PER_BIT];
                
                @(negedge clk);
                check_equlaity(tx_out_dut, tx_out_expec, 7);

                //busy signal can be tested internally for the first 2 clks and then with reg_file rd_data, because for the 1st 2 clks, wr_en is on, rd_en will not work
                if (j==1 |j==2) begin
                	check_equlaity(dut.uart_tx.busy, 1'b1, 8);
                end 
                else begin
                	check_equlaity(rd_data_dut, rd_data_expec, 9);
                end
                
                //4-turn on rd_en to look for busy
                wr_en_tb=1'b0;
                rd_en_tb=1'b1;
                rd_addr_tb= 1'b1;
            end
            
            //$stop;
            //frame is done, now look for done signal
            rd_data_expec=8'd2;
            repeat (3) @(negedge clk); //1 clk after last bit in the frame, 1 clk to load it in reg_status and 1 clk to read it on rd_data
            check_equlaity(rd_data_dut, rd_data_expec, 10);

        	@(negedge clk);
        end

        @(negedge clk);
        $stop;

    end

    task check_equlaity;
        input [7:0] x_dut, x_expec;
        input [3:0] error_code;
			begin				
				if (x_dut != x_expec) begin
	                $display("error in %d", error_code);
	                $stop;
	            end
			end
	endtask

    task reset_dominance;
        begin
	    	rst=1'b0;

	        tx_out_expec=1'b1;
	        busy_expec=  1'b0;
	        done_expec=  1'b0;
	        repeat (20) @(negedge clk);

	        for (i=0; i<50 ; i=i+1) begin
	            wr_en_tb= $random;
	            rd_en_tb= $random;
	            wr_addr_tb= $random;
	            rd_addr_tb= $random;
	            wr_data_tb= $random;
	            for (j=0; j<10*CLKS_PER_BIT; j=j+1) begin
	            	@(negedge clk);
		            check_equlaity( tx_out_dut, tx_out_expec, 0);
		            check_equlaity( dut.uart_tx.busy, busy_expec, 1);
		            check_equlaity( dut.uart_tx.uart_tx_done, done_expec, 2);
		        end
	        end

	        rst= 1'b1;
    	end
    endtask

    task check_micro_write;
        begin
            //test uart_tx_en =1 and that the wr_data is loaded in the UART p_data port
            wr_en_tb = 1'b1;
            wr_addr_tb= 1'b0;
            wr_data_tb= 8'h01; //enable siganl "data_valid" on
            @(negedge clk); 

            wr_en_tb = 1'b1;
            wr_addr_tb= 1'b1; //start issuing data

            for (j=0; j<256; j=j+1) begin
                wr_data_tb =j;
                @(negedge clk);
                check_equlaity( dut.uart_tx.p_data, wr_data_tb, 3);
            end  
      
        end 
    endtask

endmodule
