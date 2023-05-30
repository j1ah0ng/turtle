`default_nettype none

module top (
    input clk48,
    output gpio_0,
    output gpio_1
);

    reg [23:0] counter = 0;
    reg [31:0] clk_ctr = 0;

    always @(posedge clk48) begin
        counter <= counter + 1;
    end

    assign gpio_0 = counter < (1 << 23);
    assign gpio_1 = counter > (1 << 23);

endmodule
