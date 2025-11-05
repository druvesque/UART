`include "../uart_params.vh"
module tx_top(
    input [`DATA_WIDTH - 1 : 0] DATA_IN,
    input                       TX_CLK,
    input                       TX_START,
    output                      TX_DATA
);
    
    wire load_data, shift, serial_out, parity_bit;
    wire [1:0] select;

    tx_fsm FSM(
        .tx_clk(TX_CLK), 
        .tx_start(TX_START),
        .load_data(load_data), 
        .shift(shift),
        .select(select)
    );

    piso PISO(
        .tx_clk(TX_CLK),
        .load(load_data),
        .shift(shift),
        .parallel_in(DATA_IN),
        .serial_out(serial_out)
    );

    parity_generator PARITY_GEN(
        .load(load_data),
        .in(DATA_IN),
        .out(parity_bit)
    );

    tx_mux MUX(
        .select(select),
        .data_bit(serial_out),
        .parity_bit(parity_bit),
        .tx_data(TX_DATA)
    );
    
endmodule
