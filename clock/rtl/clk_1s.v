module clk_1s
#(
    parameter   num = 26'd49_999_999
)
(
    input wire       sys_clk     ,//50M的时钟频率（也就是20ns的周期，T=1/f,f是频率）
    input wire       sys_rst_n   ,//复位按键

    output reg      clk_out_1s   //分频（实际上就是把20ns的时间变成1s）
);

reg [25:0]   cnt;

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        cnt <= 26'd0;
    else if(cnt == num)
        cnt <= 26'd0;
    else
        cnt <= cnt + 26'd1;
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        clk_out_1s <= 1'b0;
    else if(cnt == num-26'd1)
        clk_out_1s <= 1'b1;
    else
    clk_out_1s <= 1'b0;
endmodule