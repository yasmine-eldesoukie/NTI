module sync_dff #(parameter WIDTH=1)(
    input wire rst, clk, 
    input wire [WIDTH-1:0] in,
    output reg [WIDTH-1:0] d
);

always @(posedge clk) begin
    if (!rst) begin
        d <= {WIDTH{1'b0}};
    end
    else begin
        d <= in;
    end 
end

endmodule