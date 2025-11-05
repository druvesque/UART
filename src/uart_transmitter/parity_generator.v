`include "uart_params.vh"
module parity_generator(
    input                        load,
    input  [`DATA_WIDTH - 1 : 0] in,
    output reg                   out
);

   always @(*) 
   begin
       if (load) 
           out <= ^in;
       else
           out <= 1'b0;
   end
endmodule

