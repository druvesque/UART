`include "uart_params.vh"
module piso(
    input                            tx_clk,
    input                            load,
    input                            shift,
    input      [`DATA_WIDTH - 1 : 0] parallel_in,
    output reg                       serial_out
);

    reg [`DATA_WIDTH - 1 : 0] temp_data;
    integer i = 0; 

    always @(posedge tx_clk) begin

        if (load) 
            temp_data <= parallel_in;

        else if (shift) begin
            serial_out <= temp_data[i];
            i = i + 1;
        end

    end
  
endmodule
