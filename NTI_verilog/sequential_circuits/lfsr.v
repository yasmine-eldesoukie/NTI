module lfsr #(parameter WIDTH=4) (
    input wire clk, rst, en,
    input wire in,
    output reg [WIDTH-1:0] lfsr 

);

wire feedback;

assign feedback = lfsr[3] ^ lfsr[0]; // TAPS=4'b1001

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        lfsr <= 'b0;
    end
    else if (en) begin
        lfsr <= {in, lfsr[WIDTH-1:1]}; 
    end
    else begin
        lfsr <= {feedback, lfsr[WIDTH-1:1]};
    end
end
 
endmodule