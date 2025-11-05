`include "uart_params.vh"
module tx_fsm(
    input  tx_clk,
    input  tx_start,
    output reg load_data,
    output reg shift,
    output reg [1:0] select
    // TODO: ADD BUSY STATE
);

    reg [1:0] state;
    reg [1:0] next_state;
    reg resetn;

    parameter IDLE = 3'b000, START_BIT = 3'b001, DATA_BIT = 3'b010, 
              PARITY_BIT = 3'b011, STOP_BIT = 3'b100;

    integer count = 1;

    always @(state, count, tx_start)
    begin
        case (state)

            IDLE: next_state = (!tx_start) ? START_BIT : IDLE;

            START_BIT: next_state = DATA_BIT;

            DATA_BIT: 
            begin
                next_state = (count != `DATA_WIDTH) ? DATA_BIT : PARITY_BIT; 
                count = count + 1;
            end

            PARITY_BIT: next_state = STOP_BIT;

            STOP_BIT: next_state = IDLE;

            default: next_state = IDLE;

        endcase
    end

    always @(posedge tx_clk) begin
        if (!resetn)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(state) 
    begin
        case (state)
            IDLE: 
            begin
                load_data = 1'b0;
                shift = 1'b0;
                select = 2'b11;
            end

            START_BIT: 
            begin
                load_data = 1'b1;
                shift = 1'b0;
                select = 2'b00;
            end

            DATA_BIT: 
            begin
                load_data = 1'b0;
                shift = 1'b1;
                select = 2'b01;
            end

            PARITY_BIT: 
            begin
                load_data = 1'b1;
                shift = 1'b0;
                select = 2'b10;
            end

            STOP_BIT:
            begin
                load_data = 1'b0;
                shift = 1'b0;
                select = 2'b11;
            end

        endcase
    end

endmodule
