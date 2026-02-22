`timescale 1ns/1ns
module tb_clock ();

reg      mode        ;
reg      add         ;
reg      subtraction ;
reg     sys_clk      ;
reg     sys_rst_n    ;
wire   [6:0]   seg1   ;
wire   [6:0]   seg2   ;
wire   [6:0]   seg3   ;
wire   [6:0]   seg4   ;
wire   [6:0]   seg5   ;
wire   [6:0]   seg6   ;

//对sys_clk,sys_rst_n赋初始值
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
//clk:产生时钟
always #10 sys_clk = ~sys_clk;
//重新定义参数值，缩短仿真时间
defparam  clock_inst.clk_1s_inst.num=26'd20;
defparam  clock_inst.tube_display_inst.key_filter_inst.CNT_MAX = 20'd4;
defparam  clock_inst.tube_display_inst.key_filter_inst2.CNT_MAX = 20'd4;
defparam  clock_inst.tube_display_inst.key_filter_inst3.CNT_MAX = 20'd4;

clock clock_inst
(
    . mode           (mode) ,//控制移到那个数码管上
    . add            (add) ,//使数码管数字增加
    . subtraction    (subtraction) ,//使数码管数字减少
    .sys_clk         (sys_clk) ,
    .sys_rst_n       (sys_rst_n) ,
    .seg1 (seg1), //右数的第一个数码管
    .seg2 (seg2), //右数的第二个数码管
    .seg3 (seg3), //右数的第三个数码管
    .seg4 (seg4), //右数的第四个数码管
    .seg5 (seg5), //右数的第五个数码管
    .seg6 (seg6) //右数的第六个数码管
    
);
endmodule