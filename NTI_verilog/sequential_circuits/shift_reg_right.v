module shift_reg_right #(parameter WIDTH=4)(
    input wire rst, clk, en,
    input wire in,
    output reg d_out
);

reg [WIDTH-1:0] d;

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        d <= 'b0;
        d_out <= 'b0;
    end
    else if (en) begin
        d <= {in,d[WIDTH-1:1]};
        d_out <= d[0];
    end 
end

endmodule