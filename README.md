# ForFlipCountDownDemo

使用了CALayer框架来做出3D翻页效果的倒计时demo。
<br><br>
# 效果图：

![]http://s12.sinaimg.cn/mw690/0028NHt6gy6TAwZS09teb&690

<br><br>
# How to use：

使用起来非常简单：
<br>（1）引入头文件：“#import "JHFlipCountDownView.h"”； 
<br>（2）调用JHFlipCountDownView类的一个接口：-(id)initWithFrame:(CGRect)frame countDownType:(COUNT_DOWN_TYPE)countDowntype countDownTime:(NSDate *)countDownTime; 

<br>代码如下： 
<br>//使用JHFlipCountDownView
    <br>JHFlipCountDownView *flipCountDownView = [[JHFlipCountDownView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-320)/2, 150, 320, 80) countDownType:TYPE_HHmmss countDownTime:[self p_haveTime]]; 
    <br>[self.view addSubview:flipCountDownView]; 
    
<br>以上代码就已经把倒计时View加入了UI。

<br>（3）最后，开启倒计时，[flipCountDownView startCountDown];

<br>使用就是这么简单！！！
