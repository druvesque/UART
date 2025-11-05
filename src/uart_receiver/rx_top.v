module rx_top(
    input                        RX_IN,
    output                       PARITY_BIT_ERROR,
    output                       STOP_BIT_ERROR,
    output [`DATA_WIDTH - 1 : 0] RX_DATA
);

    wire start_bit_detected;

    detect_start(
        .rx_in(RX_IN),
        .start_bit_detected(start_bit_detected)
    );

    sipo();

    parity_checker();

    stop_bit_checker();

    rx_fsm();

endmodule
