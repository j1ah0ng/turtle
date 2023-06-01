`default_nettype none

module top (
    input wire clk48,
    output wire gpio_0,
    output wire gpio_1,
    input wire gpio_5, 
    output wire gpio_6,

    input wire gpio_9
);

wire hi = 1;
wire lo = 0;
wire sclk, rstn;
reg mosi, miso, ss;

clock_divider #(6) div (
    .clk_in (clk48),
    .rst (lo),
    .clk_out (sclk)
);

reg [7:0] tx_out = 8'b10010010;
reg [2:0] counter = 'd0;

always @(posedge sclk) begin 
    mosi <= tx_cout[counter];
    counter <= counter + 1;
end

assign gpio_0 = sclk;
assign gpio_1 = counter[2];

endmodule
