module reg_file_tb ();
 //signal declaration
 reg clk, rst;
 reg wr_en_tb, rd_en_tb, wr_addr_tb, rd_addr_tb;
 reg [7:0] wr_data_tb;
 reg busy_tb, uart_tx_done_tb;
 wire uart_tx_data_valid_dut;
 wire [7:0] tx_p_data_dut;
 wire [7:0] rd_data_dut;


 //instantiation
 reg_file dut (
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en_tb),
    .rd_en(rd_en_tb),
    .wr_addr(wr_addr_tb),
    .rd_addr(rd_addr_tb),
    .wr_data(wr_data_tb),
    .rd_data(rd_data_dut),
    .busy(busy_tb), 
    .uart_tx_done(uart_tx_done_tb),
    .tx_p_data(tx_p_data_dut),
    .uart_tx_data_valid(uart_tx_data_valid_dut)
 );
 
 //clk generation 
 initial begin
 	clk=1'b0;
 	forever #1 clk= ~clk;
 end

 //stimulus generation
 integer i,j;
 initial begin
    //test reset dominance
 	rst=1'b0;
 	repeat (20) @(negedge clk);

 	if (rd_data_dut != 'b0 | tx_p_data_dut != 'b0 | uart_tx_data_valid_dut != 'b0) begin
 		$display("ERROR in RESET DOMINANCE");
 		$stop;
 	end

 	rst=1'b1;
    
    //test wr_en=0 dominance
    wr_en_tb=1'b0;
    for (i=0; i<2; i=i+1) begin
    	wr_addr_tb= i;
    	for (j=0; j<256; j=j+1) begin
    		wr_data_tb= j;
    		@(negedge clk);

    		if (dut.reg_control != 'b0 | dut.reg_tx_data != 'b0) begin
    			$display("ERROR in wr_en DOMINANCE");
 				$stop;
    		end
    	end
    end

    //test rd_en=0 dominance , save both busy and done signals =1 in status_reg and try to read it with rd_en =0
    rd_en_tb=1'b0;
    rd_addr_tb=1'b1;
    busy_tb=1'b1;
    uart_tx_done_tb=1'b1;
    @(negedge clk);

	if (rd_data_dut != 'b0) begin
		$display("ERROR in rd_en DOMINANCE");
		$stop;
	end

	//test wr_en=1 dominance over rd_en=1

	wr_en_tb=1'b1;
	rd_en_tb=1'b1;

	wr_addr_tb= 1'b1;
	wr_data_tb= 8'h04;

	rd_addr_tb= 1'b1; //read status register
	//note: last value saved in status register is {'b0, 1,1} --> 3

	repeat (2) @(negedge clk);
    
    if ( ~(rd_data_dut == 'b0 && dut.reg_tx_data == 8'h04) )  begin
		$display("ERROR in wr_en DOMINANCE over rd_en");
		$stop;
	end

	//test writing functionality 
	wr_en_tb=1'b1;

	wr_addr_tb= 0;
	for (i=0; i<256; i=i+1) begin
		wr_data_tb= i;
		@(negedge clk);

		if (dut.reg_control != i) begin
			$display("ERROR in writing reg_control");
			$stop;
		end
	end	

	wr_addr_tb= 1;
	for (i=0; i<256; i=i+1) begin
		wr_data_tb= i;
		@(negedge clk);

		if (dut.reg_tx_data != i) begin
			$display("ERROR in writing reg_tx_data");
			$stop;
		end
	end	

	//test reading functionality
	wr_en_tb=1'b0;
    rd_en_tb=1'b1;
    rd_addr_tb= 1'b1;
    for (i=0; i<4; i=i+1) begin
    	busy_tb= i[0];
    	uart_tx_done_tb= i[1]; 
    	repeat (2) @(negedge clk);

    	if (rd_data_dut != {6'b0, uart_tx_done_tb, busy_tb}) begin
			$display("ERROR in reading");
			$stop;
		end

    end

    @(negedge clk);
    $stop;
 end

endmodule