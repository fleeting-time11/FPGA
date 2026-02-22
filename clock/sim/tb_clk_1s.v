`timescale 1ns/1ns
module tb_clk_1s ();

reg sys_clk     ;
reg sys_rst_n   ;
wire clk_out_1s ;
initial
    begin
        sys_clk = 1'b1;
        sys_rst_n <= 1'b0;
        #50
        sys_rst_n <= 1'b1;
    end

always #10 sys_clk = ~sys_clk;

clk_1s
#(
    .num (26'd4)
)clk_1s_inst
(
    .sys_clk    (sys_clk),
    .sys_rst_n  (sys_rst_n),
    .clk_out_1s (clk_out_1s)
);
endmodule