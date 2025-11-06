`include "../../src/uart_params.vh"
module basic_rx_test;
    reg rx_in;
    reg rx_clk = 0;
    wire parity_bit_error, stop_bit_error;
    wire [`DATA_WIDTH - 1 : 0] rx_data;

    rx_top r1(rx_in, rx_clk, parity_bit_error, stop_bit_error, rx_data);

    initial
        forever #10 rx_clk = ~rx_clk;

    initial begin
        rx_in = 1;
        #5 rx_in = 0;  // start
        #40 rx_in = 1; // data
        #20 rx_in = 0; //
        #20 rx_in = 1; //
        #20 rx_in = 0; //
        #20 rx_in = 1; //
        #20 rx_in = 0; //
        #20 rx_in = 1; //
        #20 rx_in = 0; //
        #20 rx_in = 0; // parity
        #20 rx_in = 1; // stop
    end

    initial begin
        $monitor("Time: %g, RX_IN: %b, RX_DATA: %b, Parity Bit Error: %b, Stop bit error: %b", $time, rx_in, rx_data, parity_bit_error, stop_bit_error);
        #300 $finish;
    end
endmodule
