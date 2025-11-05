module stop_bit_detector(
    input check_stop,
    input rx_in,
    output stop_bit_error
);

    always @(*) begin
        if (check_stop && !rx_in)
            stop_bit_error <= 1'b1;
        else 
            stop_bit_error <= 1'b0
    end
endmodule
