//
//  JHFlipNumberView.h
//  ForFlipBoard
//
//  Created by DamonNG on 15/7/2.
//  Copyright (c) 2015年 DamonNG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHFlipNumberView : UIView

/**
 *  初始化一个NumberView
 *
 *  @param frame       NumberView frame
 *  @param currentPage 当前的页面
 *  @param flipNumber  总页面数目
 *
 *  @return 返回一个NumberView
 */
-(id)initWithFrame:(CGRect)frame CurrentPage:(NSInteger)currentPage FlipNumber:(NSInteger)flipNumber;

/**
 *  开始循环翻转
 */
-(void)startCycle;

/**
 *  开始翻转
 */
-(void)startOnce;

/**
 *   停止翻转
 */
-(void)stop;

@end
