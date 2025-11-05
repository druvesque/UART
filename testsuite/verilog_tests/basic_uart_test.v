`include "../../src/uart_params.vh"
module tb;
    reg clk = 0;
    reg [`DATA_WIDTH - 1 : 0] in;
    reg tx_start;
    wire tx_data;

    tx_top tx(
        .DATA_IN(in),
        .TX_CLK(clk),
        .TX_START(tx_start),
        .TX_DATA(tx_data)
    );

    initial
        forever #10 clk = ~clk;

    initial begin
        #15 tx_start = 0; in = 8'b10101010;
    end

    initial begin
        $monitor("Time: %g, Input: %b, Output: %b", $time, in, tx_data);
        #500 $finish;
    end

endmodule
