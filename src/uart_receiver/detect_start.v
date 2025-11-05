module detect_start(
    input      rx_in,
    output reg start_bit_detected
);

    always @(*) begin
        if (!rx_in)
            start_bit_detected <= 1'b1;
    end
endmodule
