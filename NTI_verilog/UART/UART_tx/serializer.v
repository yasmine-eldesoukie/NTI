module serializer #(parameter 
	CLKS_PER_BIT= 5208, //50 mega divided 9600 Hz //since the FPGA clk is 50 Mhz and UART is 9600
	CLK_COUNTER_WIDTH= $clog2(CLKS_PER_BIT)
)
(
input wire [7:0] p_data,
input wire ser_en, clk, rst, 
output reg out_data, 
output reg ser_done
);
reg [2:0] counter;
reg [CLK_COUNTER_WIDTH-1:0] clk_counter;
reg last_ser_bit;

/*always @(posedge clk or negedge rst) begin
   if (!rst) begin
	   counter<=4'b0000;
       ser_done<=1'b0;
   end
   else if (ser_en) begin
       if (counter==8)
          ser_done<=1'b1;
       else 
          ser_done<=1'b0;
       counter <= counter +1'b1;  
   end 
end

always @(posedge clk or negedge rst) begin
if (!rst)
     out_data<=1'b1;
else if (ser_en & !ser_done) begin
     out_data <= p_data [counter];
     $display("data %d:", counter);
     end
else begin
     out_data<=1'b1;
     $display("one");
     end
end
*/

always @(negedge clk or negedge rst) begin
	if (!rst) begin
		clk_counter<='b0;
	end
	else if (clk_counter==CLKS_PER_BIT-1) begin
		clk_counter<= 'b0;
	end
	else if (ser_en) begin
		clk_counter <= clk_counter+1;
	end
end

always @(posedge clk or negedge rst) begin
	if (!rst) begin
		counter<= 'b0;
	end
	else if (clk_counter==CLKS_PER_BIT-1) begin
		counter <= counter+1;
	end
end

always @(posedge clk or negedge rst) begin
	if (!rst) begin
		ser_done<= 1'b0;
		last_ser_bit<=1'b0;
	end
	else if (last_ser_bit) begin
		ser_done<=1'b1;
		last_ser_bit<=1'b0;
	end
	else if (counter==7 && clk_counter== CLKS_PER_BIT-2) begin
		last_ser_bit <= 1'b1;
	end
	else begin
		ser_done<= 1'b0;
		last_ser_bit=1'b0;
	end
end

//assign ser_done = (counter==7 && clk_counter== CLKS_PER_BIT-1);

always @(posedge clk or negedge rst) begin
    if (!rst) begin
	    out_data<=1'b1;
    end
    else if (!ser_done) begin 
        out_data <= p_data [counter];
    end
end

endmodule

