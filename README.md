# ForFlipCountDownDemo

使用了CALayer框架来做出3D翻页效果的倒计时demo。
<br><br>
# 效果图：

![](http://s12.sinaimg.cn/mw690/0028NHt6gy6TAwZS09teb&690)

<br><br>
# How to use：

使用起来非常简单：
<br>（1）引入头文件：“#import "JHFlipCountDownView.h"”； 
<br>（2）调用JHFlipCountDownView类的一个接口：-(id)initWithFrame:(CGRect)frame countDownType:(COUNT_DOWN_TYPE)countDowntype countDownTime:(NSDate *)countDownTime; 

<br>代码如下： 
<br>
    <br>JHFlipCountDownView *flipCountDownView = [[JHFlipCountDownView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-320)/2, 150, 320, 80) countDownType:TYPE_HHmmss countDownTime:[self p_haveTime]]; 
    <br>[self.view addSubview:flipCountDownView]; 
    
<br>以上代码就已经把倒计时View加入了UI。

<br>（3）最后，开启倒计时，[flipCountDownView startCountDown];

<br>使用就是这么简单！！！
<br>

# Tip

使用了CALayer框架来搞，页面在翻转的过程中，你会发现翻过来的同时，背面也有数字。
这是双层的layer，这里有一个小技巧就是，如何创建一个双层的layer？
还有注意的是layer有一个属性，叫doubleSide，意思是背部可见吗？
创建双层layer的方法在我源码的CustomLayer这个类里面。

<br><br>
欢迎大家对我的demo提意见。
