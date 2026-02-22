module tube_display
(
    input wire       mode           ,//控制移到那个数码管上
    input wire       add             ,//使数码管数字增加
    input wire       subtraction     ,//使数码管数字减少
    input wire       sys_clk     ,//这里是系统时钟   
    input wire       clk_out_1s     ,//接上一个文件，这里是1s
    input wire       sys_rst_n   ,//复位按键

    output reg   [6:0]   seg1  , //右数的第一个数码管
    output reg   [6:0]   seg2  , //右数的第二个数码管
    output reg   [6:0]   seg3  , //右数的第三个数码管
    output reg   [6:0]   seg4  , //右数的第四个数码管
    output reg   [6:0]   seg5  , //右数的第五个数码管
    output reg   [6:0]   seg6   //右数的第六个数码管
);
//这里我是这样设计的
//每一个数码管都是独立的，但秒分时不独立
//因此，首先将两个数码管绑定是秒，分，时也一样
reg [3:0] second1,second2;
reg [3:0] minute1,minute2;
reg [3:0] hour1,hour2;
//
//给mode的按键记次数
reg [2:0] cnt;
//
//按键消抖，通过调用消抖文件（暂未验证）引出标志位
//消抖这部分是用的B站野火教程的
wire mode_flag,add_flag,subtraction_flag;
//这里是调试 时分秒 的设置，所以用的系统时钟，因为1s的话反应太慢了
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        cnt <= 3'd0;
    else if(cnt == 3'd5)
        cnt <= 3'd0;
    else if(mode_flag == 1'b1)
        cnt <= cnt + 3'd1;
    else
        cnt <= cnt;
//按键加的操作，首先选定模式，然后按加键进行加数
//按键减的操作，首先选定模式，然后按减键进行减数//自动计时的过程

 always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        second1 <= 4'b0000;
    else if((add_flag == 1'b1 && cnt == 3'd0)|| clk_out_1s ==1'b1)
        if(second1 >= 4'b1001&&clk_out_1s ==1'b1)
        second1 <= 4'b0000; else second1 <= second1 + 4'b0001; 
    else if(subtraction_flag == 1'b1 && cnt == 3'd0)
        second1 <= second1 - 4'b0001;
    else
        second1 <= second1;
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        second2 <= 4'b0000;
    else if((add_flag == 1'b1 && cnt == 3'd1)|| (clk_out_1s ==1'b1 && second1 == 4'b1001))
        if(second2 >= 4'b0110 && clk_out_1s ==1'b1)
        second2 <= 4'b0000; else second2 <= second2 + 4'b0001; 
    else if(subtraction_flag == 1'b1 && cnt == 3'd1)
        second2 <= second2 - 4'b0001;
    else
        second2 <= second2;
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        minute1 <= 4'b0000;
    else if((add_flag == 1'b1 && cnt == 3'd2)|| (clk_out_1s ==1'b1 && second2 == 4'b0110))
        if(minute1 >= 4'b1001 && clk_out_1s ==1'b1)
        minute1 <= 4'b0000; else minute1 <= minute1 + 4'b0001; 
    else if(subtraction_flag == 1'b1 && cnt == 3'd2)
        minute1 <= minute1 - 4'b0001;
    else
        minute1 <= minute1;
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        minute2 <= 4'b0000;
    else if((add_flag == 1'b1 && cnt == 3'd3)||(clk_out_1s ==1'b1 && minute1 == 4'b1001))
        if(minute2 >= 4'b0110 && clk_out_1s ==1'b1)
        minute2 <= 4'b0000; else minute2 <= minute2 + 4'b0001; 
    else if(subtraction_flag == 1'b1 && cnt == 3'd3)
        minute2 <= minute2 - 4'b0001;
    else
        minute2 <= minute2;
always@(negedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        hour1 <= 4'b0000;
    else if((add_flag == 1'b1 && cnt == 3'd4)||(clk_out_1s ==1'b1 && minute2 == 4'b0110))
        if(hour1 >= 4'b0100 && clk_out_1s ==1'b1)
        hour1 <= 4'b0000; else hour1 <= hour1 + 4'b0001;
    else if(subtraction_flag == 1'b1 && cnt == 3'd4)
        hour1 <= hour1 - 4'b0001;
    else
        hour1 <= hour1;
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        hour2 <= 4'b0000;
    else if((add_flag == 1'b1 && cnt == 3'd5)||(clk_out_1s ==1'b1 && hour1 == 4'b0100))
        if(hour2 >= 4'b0010 && clk_out_1s ==1'b1)
        hour2 <= 4'b0000; else hour2 <= hour2 + 4'b0001;
    else if(subtraction_flag == 1'b1 && cnt == 3'd5)
        hour2 <= hour2 - 4'b0001;
    else
        hour2 <= hour2;  



//下面就是六个数码管了
//
always@(posedge clk_out_1s or negedge sys_rst_n)
    begin
    case (second1)
	    4'b0000: seg1<=7'b100_0000;//显示0  40
	    4'b0001: seg1<=7'b111_1001;//1      79
	    4'b0010: seg1<=7'b010_0100;//2      24
	    4'b0011: seg1<=7'b011_0000;//3      30
	    4'b0100: seg1<=7'b001_1001;//4      19
	    4'b0101: seg1<=7'b001_0010;//5      12
	    4'b0110: seg1<=7'b000_0010;//6      02
	    4'b0111: seg1<=7'b111_1000;//7      78
	    4'b1000: seg1<=7'b000_0000;//8      00
	    4'b1001: seg1<=7'b001_0000;//9      10
	    default: seg1<=7'b100_0000;//0      40
	 endcase
     end
always@(posedge clk_out_1s or negedge sys_rst_n)
    case (second2)
	    4'b0000: seg2<=7'b1000000;//显示0
	    4'b0001: seg2<=7'b1111001;//1
	    4'b0010: seg2<=7'b0100100;//2
	    4'b0011: seg2<=7'b0110000;//3
	    4'b0100: seg2<=7'b0011001;//4
	    4'b0101: seg2<=7'b0010010;//5
	    4'b0110: seg2<=7'b0000010;//6
	    4'b0111: seg2<=7'b1111000;//7
	    4'b1000: seg2<=7'b0000000;//8
	    4'b1001: seg2<=7'b0010000;//9
	    default: seg2<=7'b1000000;//0
	 endcase

always@(posedge clk_out_1s or negedge sys_rst_n)
    case (minute1)
	    4'b0000: seg3<=7'b1000000;//显示0
	    4'b0001: seg3<=7'b1111001;//1
	    4'b0010: seg3<=7'b0100100;//2
	    4'b0011: seg3<=7'b0110000;//3
	    4'b0100: seg3<=7'b0011001;//4
	    4'b0101: seg3<=7'b0010010;//5
	    4'b0110: seg3<=7'b0000010;//6
	    4'b0111: seg3<=7'b1111000;//7
	    4'b1000: seg3<=7'b0000000;//8
	    4'b1001: seg3<=7'b0010000;//9
	    default: seg3<=7'b1000000;//0
	 endcase
always@(posedge clk_out_1s or negedge sys_rst_n)
    case (minute2)
	    4'b0000: seg4<=7'b1000000;//显示0
	    4'b0001: seg4<=7'b1111001;//1
	    4'b0010: seg4<=7'b0100100;//2
	    4'b0011: seg4<=7'b0110000;//3
	    4'b0100: seg4<=7'b0011001;//4
	    4'b0101: seg4<=7'b0010010;//5
	    4'b0110: seg4<=7'b0000010;//6
	    4'b0111: seg4<=7'b1111000;//7
	    4'b1000: seg4<=7'b0000000;//8
	    4'b1001: seg4<=7'b0010000;//9
	    default: seg4<=7'b1000000;//0
	 endcase

always@(posedge clk_out_1s or negedge sys_rst_n)
    case (hour1)
	    4'b0000: seg5<=7'b1000000;//显示0
	    4'b0001: seg5<=7'b1111001;//1
	    4'b0010: seg5<=7'b0100100;//2
	    4'b0011: seg5<=7'b0110000;//3
	    4'b0100: seg5<=7'b0011001;//4
	    4'b0101: seg5<=7'b0010010;//5
	    4'b0110: seg5<=7'b0000010;//6
	    4'b0111: seg5<=7'b1111000;//7
	    4'b1000: seg5<=7'b0000000;//8
	    4'b1001: seg5<=7'b0010000;//9
	    default: seg5<=7'b1000000;//0
	 endcase
always@(posedge clk_out_1s or negedge sys_rst_n)
    case (hour2)
	    4'b0000: seg6<=7'b1000000;//显示0
	    4'b0001: seg6<=7'b1111001;//1
	    4'b0010: seg6<=7'b0100100;//2
	    4'b0011: seg6<=7'b0110000;//3
	    4'b0100: seg6<=7'b0011001;//4
	    4'b0101: seg6<=7'b0010010;//5
	    4'b0110: seg6<=7'b0000010;//6
	    4'b0111: seg6<=7'b1111000;//7
	    4'b1000: seg6<=7'b0000000;//8
	    4'b1001: seg6<=7'b0010000;//9
	    default: seg6<=7'b1000000;//0
	 endcase
     
key_filter
#(
    .CNT_MAX (20'd999_999)// 
)key_filter_inst
(
    .sys_clk    (sys_clk) ,
    .sys_rst_n  (sys_rst_n) ,
    .key_in     (mode) ,
    .key_flag   (mode_flag)
);
key_filter key_filter_inst2
(
    .sys_clk    (sys_clk) ,
    .sys_rst_n  (sys_rst_n) ,
    .key_in     (add) ,
    .key_flag   (add_flag)
);
key_filter key_filter_inst3
(
    .sys_clk    (sys_clk) ,
    .sys_rst_n  (sys_rst_n) ,
    .key_in     (subtraction) ,
    .key_flag   (subtraction_flag)
);

endmodule