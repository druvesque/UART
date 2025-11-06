`include "uart_params.vh"
module rx_top(
    input                            RX_IN,
    input                            RX_CLK,
    output                           PARITY_BIT_ERROR,
    output                           STOP_BIT_ERROR,
    output reg [`DATA_WIDTH - 1 : 0] RX_DATA
);

    wire start_bit_detected, shift, parity_load, check_stop;
    wire [`DATA_WIDTH - 1 : 0] parallel_out;

    detect_start DETECT_START(
        .rx_in(RX_IN),
        .start_bit_detected(start_bit_detected)
    );

    rx_fsm RX_FSM(
        .rx_clk(RX_CLK),
        .start_bit_detected(start_bit_detected),
        .parity_bit_error(PARITY_BIT_ERROR),
        .shift(shift),
        .parity_load(parity_load),
        .check_stop(check_stop)
    );

    sipo SIPO(
        .rx_clk(RX_CLK),
        .shift(shift),
        .serial_in(RX_IN),
        .parallel_out(parallel_out)
    );

    parity_checker PARITY_CHECKER(
        .parity_load(parity_load),
        .rx_in(RX_IN),
        .parallel_in(parallel_out),
        .parity_bit_error(PARITY_BIT_ERROR)
    );

    stop_bit_detector STOP_BIT_DETECTOR(
        .check_stop(check_stop),
        .rx_in(RX_IN),
        .stop_bit_error(STOP_BIT_ERROR)
    );

    always @(*) begin
        if (!STOP_BIT_ERROR)
            RX_DATA <= parallel_out;
    end


endmodule
