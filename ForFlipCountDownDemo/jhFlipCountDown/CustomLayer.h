//
//  CustomLayer.h
//  ForFlipBoard
//
//  Created by DamonNG on 15/6/19.
//  Copyright (c) 2015年 DamonNG. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

/**
 *  自定义layer
 */
@interface CustomLayer : CATransformLayer

@property (nonatomic)        CGFloat   rotateDegree;

/**
 *  双层layer
 */
@property (nonatomic,retain) CALayer   *frontLayer;
@property (nonatomic,retain) CALayer   *backLayer;

-(id)initWithFrame:(CGRect)frame;
/**
 *  正面的内容
 *
 *  @param images 正面的图像
 */
-(void)setFrontLayerContent:(UIImage*)images;
/**
 *  背面的内容
 *
 *  @param images 背面的图像
 */
-(void)setBackLayerContent:(UIImage*)images;

@end
