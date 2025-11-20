module ROM #(parameter 
	WIDTH=8, DEPTH=84, //4 names :20 letters (20 ASCII codes) + NTI HIRE READY R12 DIGITAL IC (29) --> 49 , maybe MUSTABIT EL NTI (15) + 7 for 2ol2as -->
	ADDR= $clog2(DEPTH),
	FILE= "rom_data_names_hex.txt"
	 )(
	input wire clk,
	input wire [ADDR-1:0] rd_addr,
	output reg [WIDTH-1:0] data_out
	);

 reg [WIDTH-1:0] rom [DEPTH-1:0];

 initial begin
 	$readmemh(FILE, rom);
 end

 always @(posedge clk) begin
 	data_out<= rom[rd_addr];
 end

endmodule 