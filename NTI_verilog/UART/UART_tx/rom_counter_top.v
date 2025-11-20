module rom_counter_top #(parameter 
	WIDTH=8, DEPTH=84, 
	ADDR= $clog2(DEPTH),
	FILE= "rom_data_names_hex.txt"
	)
    (
	input wire clk, rst, increment,
	output wire [WIDTH-1:0] data_out
	);

	wire [ADDR-1:0] rd_addr;

	ROM rom (
		.clk(clk),
		.rd_addr(rd_addr),
		.data_out(data_out)
	);

	rom_addr_counter rom_addr_counter (
		.clk(clk),
		.rst(rst),
		.increment(increment),
		.rom_addr(rd_addr)
	);

endmodule