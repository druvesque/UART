module tx_mux(
    input      [1:0] select,
    input      data_bit,
    input      parity_bit,
    output     tx_data 
);

    assign tx_data = (select[1] == 1'b0) ? ((select[0] == 1'b0 ? 0 : data_bit)) : ((select[0] == 1'b0 ? parity_bit : 1));

endmodule
