//
//  JHFlipCountDownView.m
//  ForFlipBoard
//
//  Created by DamonNG on 15/7/3.
//  Copyright (c) 2015年 DamonNG. All rights reserved.
//

#import "JHFlipCountDownView.h"
#import "JHFlipNumberView.h"

//一个Flip之间的间距
#define ONE_FLIP_MARGIN 2
//两个Flip之间的间距
#define TWO_FLIP_MARGIN 6
//TYPE_HHmmss类型的Flip数量
#define TYPE_HHmmss_NUMBER 6

@implementation JHFlipCountDownView
{
    COUNT_DOWN_TYPE     _countDownType;
    NSDate             *_countDownTime;
    NSMutableArray     *_flipArray;
    
    NSTimer            *_countDowmTimer;
}

-(void)dealloc {
    _countDownTime = nil;
    _flipArray = nil;
    _countDowmTimer = nil;
}

#pragma mark public Methods
-(id)initWithFrame:(CGRect)frame countDownType:(COUNT_DOWN_TYPE)countDowntype countDownTime:(NSDate *)countDownTime {
    self = [super initWithFrame:frame];
    if (self) {
        _countDownType = countDowntype;
        _countDownTime = countDownTime;
        [self p_initUI];
    }
    return self;
}
-(void)startCountDown {
    [_countDowmTimer invalidate];
    _countDowmTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
}
-(void)stopCountDown {
    [_countDowmTimer invalidate];
}

#pragma mark Private Methods
//拿到_countDownTime中第index个数字
-(NSInteger)p_NumberWithIndex:(NSInteger)index {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HHmmss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSString *currentDateStr = [dateFormatter stringFromDate:_countDownTime];
    return [[currentDateStr substringWithRange:NSMakeRange(index,1)] integerValue];
}

-(void)p_initUI {
    if (_countDownType == TYPE_HHmmss) {
        _flipArray = [[NSMutableArray alloc]initWithCapacity:TYPE_HHmmss_NUMBER];
        CGFloat flipWidth = (self.frame.size.width-TWO_FLIP_MARGIN*2-ONE_FLIP_MARGIN*3)/TYPE_HHmmss_NUMBER;
        CGFloat flipHeight = self.frame.size.height;
        CGFloat x=0,y=0;
        NSArray *flipNumberArray = @[@(3),@(10),@(6),@(10),@(6),@(10)];
        for (int i=0; i<TYPE_HHmmss_NUMBER; i++) {
            JHFlipNumberView *flipNumberView = [[JHFlipNumberView alloc]initWithFrame:CGRectMake(x, y, flipWidth, flipHeight) CurrentPage:[self p_NumberWithIndex:i] FlipNumber:[flipNumberArray[i] integerValue]];
            [self addSubview:flipNumberView];
            
            _flipArray[i] = flipNumberView;
            x = x + flipWidth + ONE_FLIP_MARGIN;
            if (i%2 == 1) {
                if (i < TYPE_HHmmss_NUMBER - 1) {
                    UILabel *colonLabel = [[UILabel alloc]initWithFrame:CGRectMake(x-3, flipHeight/6 , 10, flipHeight-flipHeight/3)];
                    colonLabel.text = @":";
                    colonLabel.font = [UIFont systemFontOfSize:40];
                    colonLabel.textColor = [UIColor blueColor];
                    [self addSubview:colonLabel];

                }
                x = x + TWO_FLIP_MARGIN;
            }
        }
    }
}

#pragma mark Action Methods
-(void)countDownAction {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HHmmss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:_countDownTime];
    
    for (int i = TYPE_HHmmss_NUMBER - 1; i>=0; i--) {
        if ([[currentDateStr substringWithRange:NSMakeRange(i, 1)] integerValue] > 0) {
            for (int j = TYPE_HHmmss_NUMBER - 1; j >= i; j --) {
                JHFlipNumberView *flipNumberView = [_flipArray objectAtIndex:j];
                [flipNumberView startOnce];
            }
            break;
        }
    }
    double haveSeconds = _countDownTime.timeIntervalSince1970 - 1;
    _countDownTime = [NSDate dateWithTimeIntervalSince1970:haveSeconds];
}

@end
