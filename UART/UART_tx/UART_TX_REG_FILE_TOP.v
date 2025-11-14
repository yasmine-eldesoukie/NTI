module UART_TX_REG_FILE_TOP #(parameter CLKS_PER_BIT=5208)( //wrapper
    //reg_file
    input wire clk, rst,
    input wire wr_en, rd_en, 
    input wire wr_addr, rd_addr,
    input wire [7:0] wr_data, 
    output wire [7:0] rd_data,
    //UART_TX
    output wire tx_out
);

wire busy, uart_tx_done;
wire data_valid;
wire [7:0] tx_p_data;

UART_TX_TOP #(.CLKS_PER_BIT(CLKS_PER_BIT)) uart_tx (
    .clk(clk),
    .rst(rst),
    .data_valid(data_valid),
    .p_data(tx_p_data),
    .busy(busy),
    .uart_tx_done(uart_tx_done),
    .tx_out(tx_out)
); 

reg_file reg_file (
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .wr_addr(wr_addr),
    .rd_addr(rd_addr),
    .wr_data(wr_data),
    .rd_data(rd_data),
    .busy(busy), 
    .uart_tx_done(uart_tx_done),
    .tx_p_data(tx_p_data),
    .uart_tx_data_valid(data_valid)
);
endmodule