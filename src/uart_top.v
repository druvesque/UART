`include "uart_params.vh"
module uart_top(
    input TX_CLK,
    input RX_CLK,
    input [`DATA_WIDTH - 1 : 0] PARALLEL_INPUT_DATA,
    output PARITY_BIT_ERROR,
    output STOP_BIT_ERROR,
    output [`DATA_WIDTH - 1 : 0] RX_DATA
);

endmodule
