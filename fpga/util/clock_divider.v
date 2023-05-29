`default nettype none

module clock_divider #(parameter N = 'd4) (
    input wire clk_in,
    input wire rst,
    output wire clk_out,
);

    reg [N - 1:0] counter;

    always @(posedge clk_in) 
        if (rst) begin
            counter <= '{default: '0};
        end
        else counter <= counter + 1;
    end

    assign clk_out = counter[N - 1];

endmodule

