module UART_RX_tb #(parameter CLKS_PER_BIT= 5208)();
reg clk, rst; 
reg tx_data_out_tb;
wire rx_busy_dut, rx_done_dut, error_dut;
wire [7:0] rx_data_out_dut;

//instantiation
UART_RX #(.CLKS_PER_BIT(3)) dut (
    .clk(clk),
    .rst(rst),
    .tx_data_out(tx_data_out_tb),
    .rx_busy(rx_busy_dut), 
    .rx_done(rx_done_dut), 
    .error(error_dut),
    .rx_data_out(rx_data_out_dut)
);

//clk generation
initial begin
    clk=1'b0;
    forever #1 clk= ~clk;
end

//stimulus generation
integer i;
initial begin
    rst= 1'b0;
    repeat (20) @(negedge clk);

    rst=1'b1;
    tx_data_out_tb=1'b1;

    for (i=0; i<256; i=i+1) begin
        tx_frame_tb={1'b1, i[7:0], 1'b0};
        for (j=0; j<10; j=j+1) begin
            repeat (CLKS_PER_BIT) begin
              tx_data_out_tb= tx_frame_tb[j];
            end
            
        end
    end
end

endmodule