`include "uart_params.vh"
module parity_checker(
    input                       parity_load,
    input                       rx_in,
    input [`DATA_WIDTH - 1 : 0] parallel_in,
    output reg                  parity_bit_error
);

    always @(*) begin
        if (parity_load)
            parity_bit_error <= (rx_in == ^parallel_in);
        else
            parity_bit_error <= 1'b0;
    end
endmodule
