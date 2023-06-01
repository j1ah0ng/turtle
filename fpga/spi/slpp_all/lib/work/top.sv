`default_nettype none

module top (
    input wire clk48,
    output wire gpio_0,
    output wire gpio_1,
    input wire gpio_5, 
    output wire gpio_6,

    input wire gpio_9
);

reg [7:0] counter = 'd0;
assign gpio_0 = clk48;
assign gpio_1 = counter[7];
assign gpio_6 = counter[0];
always @(posedge clk48) begin 
    counter <= counter + 1;
end


// wire sclk, mosi, miso, ss, rstn;
// 
// wire hi = 1;
// wire lo = 0;
// 
// assign gpio_0 = sclk;
// assign gpio_1 = mosi;
// assign miso = gpio_5;
// assign gpio_6 = ss;
// 
// assign rstn = ~gpio_9;
// 
// clock_divider #(8) divider (
//     .clk_in (clk48),
//     .rst (rstn),
//     .clk_out (sclk)
// );
// 
// reg [7:0] tx_data = {1, 0, 1, 0, 1, 0, 1, 0};
// reg [7:0] rx_data;
// 
// wire tx_done, rx_valid;
// 
// spi_master sm (
//     .clk (sclk),
//     .rstn (rstn),
//     .tx_data (tx_data),
//     .tx_valid (hi),
//     .tx_done (tx_done),
//     .rx_data (rx_data),
//     .rx_valid (rx_valid),
//     .sclk (),
//     .mosi (mosi),
//     .miso (miso),
//     .ss (ss)
// );



endmodule
