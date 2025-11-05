module rx_fsm(
    input      rx_clk,
    input      start_bit_detected,
    input      parity_bit_error,
    output reg shift,
    output reg parity_load,
    output reg check_stop
);

    reg [1:0] state, next_state;

    parameter IDLE = 2'b00, DATA_BIT = 2'b01, PARITY_BIT = 2'b10, STOP_BIT = 2'b11

    integer count = -1;

    always @(state, count, start_bit_detected)
    begin

        case (state)

            IDLE: begin
                next_state = (start_bit_detected) ? DATA_BIT : IDLE;
                count = count + 1;
            end

            DATA_BIT: begin
                next_state = (count != `DATA_WIDTH) ? DATA_BIT : PARITY_BIT;
                count = count + 1;
            end

            PARITY_BIT: (parity_bit_error) ? IDLE : STOP_BIT;

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
endmodule
