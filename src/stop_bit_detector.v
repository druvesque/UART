module stop_bit_detector(
    input      check_stop,
    input      rx_in,
    output reg stop_bit_error 
);

    always @(*) begin
        if (check_stop && !rx_in)
            stop_bit_error <= 1'b1;
    end
endmodule
