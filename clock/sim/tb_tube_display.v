`timescale 1ns/1ns
module tb_tube_display ();
reg mode;
reg add;
reg subtraction;
reg sys_clk     ;
reg clk_out_1s  ;
reg sys_rst_n   ;

wire [6:0]   seg1 ;
wire [6:0]   seg2 ;
wire [6:0]   seg3 ;
wire [6:0]   seg4 ;
wire [6:0]   seg5 ;
wire [6:0]   seg6 ;
initial
    begin
        sys_clk = 1'b1;
        sys_rst_n <= 1'b0;
        #50
        sys_rst_n <= 1'b1;
        mode<= 1'b1;
        add<= 1'b1;
        subtraction<= 1'b1;
        
        
    end

always #10 sys_clk = ~sys_clk;
reg [4:0] cnt;
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        cnt <= 5'd0;
    else if(cnt == 5'd9)
        cnt <= 5'd0;
    else
        cnt <= cnt + 5'd1;

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        clk_out_1s <= 1'b0;
    else if(cnt == 5'd8)
        clk_out_1s <= 1'b1;
    else
        clk_out_1s <= 1'b0;
        
tube_display tube_display_inst
(
    .mode         (mode)  ,//控制移到那个数码管上
    .add          (add)   ,//使数码管数字增加
    .subtraction  (subtraction)   ,//使数码管数字减少
    .sys_clk      (sys_clk)  ,//这里是系统时钟   
    .clk_out_1s   (clk_out_1s)  ,//接上一个文件，这里是1s
    .sys_rst_n    (sys_rst_n) ,//复位按键

    .seg1 (seg1) , //右数的第一个数码管
    .seg2 (seg2) , //右数的第二个数码管
    .seg3 (seg3) , //右数的第三个数码管
    .seg4 (seg4) , //右数的第四个数码管
    .seg5 (seg5) , //右数的第五个数码管
    .seg6 (seg6)  //右数的第六个数码管
);
endmodule