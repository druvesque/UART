`include "uart_params.vh"
module sipo(
    input                            rx_clk,
    input                            shift,
    input                            load,
    input                            serial_in,
    output reg [`DATA_WIDTH - 1 : 0] parallel_out
);

    reg [`DATA_WIDTH - 1 : 0] temp_data;
    integer i = 0;

    always @(posedge rx_clk) begin

        if (shift) begin
            temp_data[i] = serial_in;
            i = i + 1;
        end

        if (i == `DATA_WIDTH)
            parallel_out <= temp_data;

    end

endmodule
