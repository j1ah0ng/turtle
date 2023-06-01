module spi_master (
    input wire clk,
    input wire rstn,

    // TX 
    input reg [7:0] tx_data,
    input wire tx_valid,
    output wire tx_done,

    // RX
    output reg [7:0] rx_data,
    output wire rx_valid,

    // SPI interface
    output wire sclk,
    output reg mosi,
    input reg miso,
    output reg ss
);

// sample on rising edge of clock, shift on falling edge.












reg [3:0] state;
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
                tx_capture <= 'd0;
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


endmodule
