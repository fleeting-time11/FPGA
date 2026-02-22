module clock
(
    input wire       mode           ,//控制移到那个数码管上
    input wire       add             ,//使数码管数字增加
    input wire       subtraction     ,//使数码管数字减少
    input wire      sys_clk  ,
    input wire      sys_rst_n   ,
    output wire   [6:0]   seg1  , //右数的第一个数码管
    output wire   [6:0]   seg2  , //右数的第二个数码管
    output wire   [6:0]   seg3  , //右数的第三个数码管
    output wire   [6:0]   seg4  , //右数的第四个数码管
    output wire   [6:0]   seg5  , //右数的第五个数码管
    output wire   [6:0]   seg6   //右数的第六个数码管
    
);
wire clk_out_1s;
clk_1s clk_1s_inst
(
    .sys_clk    (sys_clk),
    .sys_rst_n  (sys_rst_n),
    .clk_out_1s (clk_out_1s)
);

tube_display tube_display_inst
(
    .mode        (mode)   ,//控制移到那个数码管上
    .add         (add)    ,//使数码管数字增加
    .subtraction (subtraction)    ,//使数码管数字减少
    . sys_clk    (sys_clk) ,//这里是系统时钟   
    .clk_out_1s  (clk_out_1s)   ,//接上一个文件，这里是1s
    .sys_rst_n   (sys_rst_n),//复位按键

    .seg1 (seg1), //右数的第一个数码管
    .seg2 (seg2), //右数的第二个数码管
    .seg3 (seg3), //右数的第三个数码管
    .seg4 (seg4), //右数的第四个数码管
    .seg5 (seg5), //右数的第五个数码管
    .seg6 (seg6) //右数的第六个数码管
);
endmodule