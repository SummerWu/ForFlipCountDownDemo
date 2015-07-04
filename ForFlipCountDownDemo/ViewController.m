//
//  ViewController.m
//  ForFlipCountDownDemo
//
//  Created by DamonNG on 15/7/3.
//  Copyright (c) 2015年 JiehaoWu. All rights reserved.
//

#import "ViewController.h"
#import "JHFlipCountDownView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //使用JHFlipCountDownView
    JHFlipCountDownView *flipCountDownView = [[JHFlipCountDownView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-150)/2, 100, 150, 35) countDownType:TYPE_HHmmss countDownTime:[self p_haveTime]];
    [self.view addSubview:flipCountDownView];
    
    [flipCountDownView startCountDown];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Private Methods
-(NSDate*)p_haveTime {
    NSDate *nowDate = [NSDate date];
    NSDate *tomorrowDate = [nowDate dateByAddingTimeInterval:24*60*60];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd";
    NSString * stringDate = [df stringFromDate:tomorrowDate];
    
    tomorrowDate = [df dateFromString:stringDate];
    
    NSDate *haveDate = [NSDate dateWithTimeIntervalSinceReferenceDate:(tomorrowDate.timeIntervalSince1970-nowDate.timeIntervalSince1970)];
    
    return haveDate;
}


@end
