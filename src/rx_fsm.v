`include "uart_params.vh"
module rx_fsm(
    input      rx_clk,
    input      start_bit_detected,
    input      parity_bit_error,
    output reg shift,
    output reg parity_load,
    output reg check_stop
);

    reg [1:0] state, next_state;

    parameter IDLE = 2'b00, DATA_BIT = 2'b01, PARITY_BIT = 2'b10, STOP_BIT = 2'b11;

    reg resetn = 1'b1;

    reg start;
    integer rx_count;

    always @(state, rx_count, start_bit_detected, parity_bit_error)
    begin

        $display("State: %d, Count: %d", state, rx_count);
        $display("Shift: %b", shift);
        case (state)

            IDLE: next_state = (start_bit_detected) ? DATA_BIT : IDLE;

            DATA_BIT: begin
                start = (rx_count == `DATA_WIDTH) ? 1'b0 : 1'b1;
                next_state = (rx_count == `DATA_WIDTH) ? PARITY_BIT : DATA_BIT;
            end

            PARITY_BIT: begin
                next_state = (parity_bit_error) ? IDLE : STOP_BIT; 
            end

            STOP_BIT: next_state = IDLE;

            default: next_state = IDLE;
              
        endcase
    end

    always @(posedge rx_clk) begin
        if (!resetn)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(state) 
    begin
        case (state) 
            IDLE: begin
                shift = 1'b0;
                parity_load = 1'b0;
                check_stop = 1'b0;
            end

            DATA_BIT: begin
                shift = 1'b1;
                parity_load = 1'b0;
                check_stop = 1'b0;
            end

            PARITY_BIT: begin
                shift = 1'b0;
                parity_load = 1'b1;
                check_stop = 1'b0;
            end

            STOP_BIT: begin
                shift = 1'b0;
                parity_load = 1'b0;
                check_stop = 1'b1;
            end
        endcase
    end

    always @(posedge rx_clk)
        if(start)
            rx_count <= rx_count + 1;
        else
            rx_count <= 1;
endmodule
