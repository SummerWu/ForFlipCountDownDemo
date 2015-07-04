# ForFlipCountDownDemo

使用了CALayer框架来做出3D翻页效果的倒计时demo。

How to use：

使用起来非常简单：
（1）引入头文件：“#import "JHFlipCountDownView.h"”；
（2）调用JHFlipCountDownView类的一个接口：-(id)initWithFrame:(CGRect)frame countDownType:(COUNT_DOWN_TYPE)countDowntype countDownTime:(NSDate *)countDownTime;

代码如下：
//使用JHFlipCountDownView
    JHFlipCountDownView *flipCountDownView = [[JHFlipCountDownView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-320)/2, 150, 320, 80) countDownType:TYPE_HHmmss countDownTime:[self p_haveTime]];
    [self.view addSubview:flipCountDownView];
    
以上代码就已经把倒计时View加入了UI。

（3）最后，开启倒计时，[flipCountDownView startCountDown]; 

使用就是这么简单！！！
