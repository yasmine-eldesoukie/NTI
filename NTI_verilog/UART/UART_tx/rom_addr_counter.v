module rom_addr_counter #(parameter 
	DEPTH=84, 
	ADDR= $clog2(DEPTH))
    (
	input wire clk, rst, increment,
	output reg [ADDR-1:0] rom_addr
	);

	always @(posedge clk or negedge rst) begin
		if (!rst) begin
			rom_addr<= {ADDR{1'b0}};
		end
		else if (rom_addr==DEPTH-1) begin
			rom_addr<= {ADDR{1'b0}};
		end
		else if (increment) begin
			rom_addr<= rom_addr+1;
		end
	end

endmodule