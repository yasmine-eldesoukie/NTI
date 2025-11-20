module UART_ROM_counter_top #(parameter 
	CLKS_PER_BIT=5208,
	WIDTH=8, DEPTH=84, 
	ADDR= $clog2(DEPTH),
	FILE= "rom_data_names_hex.txt"
	)(
      input wire clk, rst, 
      input wire uart_en,
      output wire uart_tx_out,
      output wire uart_busy
	);

	wire increment;
	wire [WIDTH-1:0] rom_data_out;
	reg uart_en_edge;

	/*

	always @(posedge clk or negedge rst) begin
		if (!rst) begin
			 <= 1'b0;
			
		end
		else if (uart_en_1clk) begin
			uart_en_1clk<= 1'b0;
		end
		else if (uart_en_edge) begin
			uart_en_1clk<= 1'b1;
		end
	end
*/
	rom_counter_top rom_counter_top (
		.clk(clk),
		.rst(rst),
		.increment(increment),
		.data_out(rom_data_out)
	);

	UART_TX_TOP #(CLKS_PER_BIT) uart_tx (
		.clk(clk),
		.rst(rst),
		.p_data(rom_data_out),
		.data_valid(uart_en),
		.tx_out(uart_tx_out),
		.busy(uart_busy),
		.uart_tx_done(increment)
	);
endmodule