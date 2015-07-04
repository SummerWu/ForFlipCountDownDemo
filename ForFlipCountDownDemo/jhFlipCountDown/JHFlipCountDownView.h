//
//  JHFlipCountDownView.h
//  ForFlipBoard
//
//  Created by DamonNG on 15/7/3.
//  Copyright (c) 2015年 DamonNG. All rights reserved.
//

#import <UIKit/UIKit.h>

//创建倒计时的类型
typedef enum COUNT_DOWN_TYPE{
    TYPE_HHmmss,//HH:mm:ss
    TYPE_s      //s，单个数字
}COUNT_DOWN_TYPE;

@interface JHFlipCountDownView : UIView

/**
 *  初始化一个倒计时表
 *
 *  @param frame         倒计时frame
 *  @param countDowntype 时间的格式
 *  @param countDownTime 传入倒计的时间
 *
 *  @return 返回一个倒计时表
 */
-(id)initWithFrame:(CGRect)frame countDownType:(COUNT_DOWN_TYPE)countDowntype countDownTime:(NSDate *)countDownTime;

/**
 *  开始倒计时
 */
-(void)startCountDown;

/**
 *  停止倒计时
 */
-(void)stopCountDown;

@end
