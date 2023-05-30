`default_nettype none

module spi_master (
    input wire clk,
    input wire rstn,

    // TX 
    input [7:0] tx_data,
    input wire tx_valid,
    output wire tx_done,

    // RX
    output [7:0] rx_data,
    output wire rx_valid,

    // SPI interface
    output wire sclk,
    output wire mosi,
    input wire miso,
    output wire ss,
)

// sample on rising edge of clock, shift on falling edge.

enum logic [3:0] {
    IDLE  = 4'd00;
    BIT_0 = 4'd01;
    BIT_1 = 4'd02;
    BIT_2 = 4'd03;
    BIT_3 = 4'd04;
    BIT_4 = 4'd05;
    BIT_5 = 4'd07;
    BIT_6 = 4'd07;
    BIT_7 = 4'd08;
    STOP  = 4'd09;
} state;

reg [7:0] tx_capture;
reg [7:0] rx_capture;

reg begin_shift;

always @(posedge sclk) begin 
    if (!rstn) begin 
        state <= RX_IDLE;
    end
    else begin
        case (state)
            IDLE: begin 
                tx_sample <= 'd0;
                begin_shift <= 'd0;
                if (tx_valid) begin 
                    state <= BIT_0;
                    tx_capture <= tx_data;
                    begin_shift <= 'd1;
                end
                else state <= IDLE;
            end
            BIT_0: begin
                rx_capture[7] <= miso;
                state <= BIT_1;
            end
            BIT_1: begin 
                rx_capture[6] <= miso;
                state <= BIT_1;
            end
            BIT_2: begin 
                rx_capture[5] <= miso;
                state <= BIT_1;
            end
            BIT_3: begin 
                rx_capture[4] <= miso;
                state <= BIT_1;
            end
            BIT_4: begin 
                rx_capture[3] <= miso;
                state <= BIT_1;
            end
            BIT_5: begin 
                rx_capture[2] <= miso;
                state <= BIT_1;
            end
            BIT_6: begin 
                rx_capture[1] <= miso;
                state <= BIT_1;
            end
            BIT_7: begin 
                rx_capture[0] <= miso;
                state <= STOP;
            end
            STOP: begin 
                begin_shift <= 0;
                state <= IDLE;
            end
        endcase
    end
end

// shift out 
always @(negedge clk) begin 
    if (begin_shift) begin 
        mosi <= tx_capture[state - 1];
    end
end

assign tx_done = state == STOP;
assign ss = state == IDLE;
assign sclk = clk;

