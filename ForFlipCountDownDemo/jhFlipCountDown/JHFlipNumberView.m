//
//  JHFlipNumberView.m
//  ForFlipBoard
//
//  Created by DamonNG on 15/7/2.
//  Copyright (c) 2015年 DamonNG. All rights reserved.
//

#import "JHFlipNumberView.h"
#import "CustomLayer.h"
#import "Flip.h"

#define kDegreesToRadian(x) (M_PI * (x) / 180.0 )

#define kRadianToDegrees(radian) (radian* 180.0 )/(M_PI)


@interface JHFlipNumberView ()
{
    //存储所有数字的View
    NSMutableArray *viewArray;
    //存储所有的layer
    NSMutableArray *layerArray;
    //存储辅助的layer
    NSMutableArray *layerHelperArray;
    //存储底部的View
    NSMutableArray *bottomViewArray;
    //正在翻滚的页面
    CustomLayer* _dragging_layer;
    //下一个页面
    CustomLayer* _next_layer;
    //这个layer停留在bottom，造成视觉效果
    CustomLayer* _bottom_layer;
    //当前页数
    NSInteger    _currentPage;
    //总页数
    NSInteger    _flipNumber;
    //View下半部分的显示
    UIImageView     *_bottomImageView;
    
    NSTimer  *timer;
}

@end

@implementation JHFlipNumberView

-(void)dealloc{
    [timer invalidate];
    timer = nil;
    viewArray=nil;
    bottomViewArray=nil;
    layerArray=nil;
    layerHelperArray=nil;
    _dragging_layer = nil;
    _next_layer = nil;
    _bottom_layer = nil;
    _bottomImageView = nil;
}

-(id)initWithFrame:(CGRect)frame CurrentPage:(NSInteger)currentPage FlipNumber:(NSInteger)flipNumber{
    self = [super initWithFrame:frame];
    if (self) {
        _flipNumber = flipNumber;
        _currentPage = _flipNumber-currentPage-1;
        [self p_initUI];
        [self p_allocData];
        [self p_buildLayers];
        [self p_initData];
    }
    return self;
}

-(void)startCycle {
    [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
}

-(void)startOnce {
    [self timerFired];
}

-(void)stop {
    [timer invalidate];
}

-(void)p_initUI {
    _bottomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height/2, self.frame.size.width, self.frame.size.height/2)];
    [self addSubview:_bottomImageView];
}

-(void)p_allocData {
    viewArray = [[NSMutableArray alloc]initWithCapacity:_flipNumber];
    bottomViewArray = [[NSMutableArray alloc]initWithCapacity:_flipNumber];
    layerArray = [NSMutableArray arrayWithCapacity:_flipNumber];
    layerHelperArray = [[NSMutableArray alloc]initWithCapacity:_flipNumber];
}

-(void)p_initData {
    _bottomImageView.image = bottomViewArray[_currentPage];
}

-(void)p_buildLayers
{
    for (int a=0; a<_flipNumber; a++) {
        UIView *helpView = [[UIView alloc]initWithFrame:self.frame];
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:helpView.bounds];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",a]];
        [helpView addSubview:imageView];
        [viewArray addObject:helpView];
    }
    
    CGRect layerFrame=CGRectMake(0.0f, self.bounds.size.height/2, self.bounds.size.width, self.bounds.size.height/2);
    
    for (int a=(int)_flipNumber-1; a>=0; a--) {
        CustomLayer* layer=[[CustomLayer alloc]initWithFrame:layerFrame];
        [layer setFrontLayerContent:JHFlip_make_hsplit_images_for_view(viewArray[a])[0]];
        [bottomViewArray addObject:JHFlip_make_hsplit_images_for_view(viewArray[a])[1]];
        if (a == 0) {
            [layer setBackLayerContent:JHFlip_make_hsplit_images_for_view(viewArray[_flipNumber-1])[1]];
        }
        else{
            [layer setBackLayerContent:JHFlip_make_hsplit_images_for_view(viewArray[a-1])[1]];
        }
        layer.hidden = YES;
        //[self.view.layer insertSublayer:layer below:self.view.layer];
        [self.layer addSublayer:layer];
        layer.rotateDegree = 0.0f;
        [layerHelperArray addObject:layer];
    }
    _bottom_layer = [layerHelperArray objectAtIndex:_currentPage];
    _bottom_layer.hidden = NO;
    // _bottom_layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    for (int a=(int)_flipNumber-1; a>=0; a--) {
        CustomLayer* layer=[[CustomLayer alloc]initWithFrame:layerFrame];
        [layer setFrontLayerContent:JHFlip_make_hsplit_images_for_view(viewArray[a])[0]];
        [bottomViewArray addObject:JHFlip_make_hsplit_images_for_view(viewArray[a])[1]];
        if (a == 0) {
            [layer setBackLayerContent:JHFlip_make_hsplit_images_for_view(viewArray[_flipNumber-1])[1]];
        }
        else{
            [layer setBackLayerContent:JHFlip_make_hsplit_images_for_view(viewArray[a-1])[1]];
        }
        layer.hidden = YES;
        //[self.view.layer insertSublayer:layer below:self.view.layer];
        [self.layer addSublayer:layer];
        layer.rotateDegree = 0.0f;
        [layerArray addObject:layer];
        _dragging_layer = layer;
    }
    _dragging_layer = [layerHelperArray objectAtIndex:_currentPage];
    _dragging_layer.hidden = NO;
}
-(void)timerFired
{
    //[_dragging_layer removeAllAnimations];
    _dragging_layer =  [layerArray objectAtIndex:_currentPage];
    _currentPage = (_currentPage+1)%_flipNumber;
    _dragging_layer.hidden = NO;
    [_dragging_layer addAnimation:[self rotation:0.5 degree:kDegreesToRadian ( 180 ) direction:1 repeatCount:0] forKey:@"transform"];
}

-( CABasicAnimation *)rotation:( float )dur degree:( float )degree direction:( int )direction repeatCount:( int )repeatCount

{
    //[CATransaction begin];
    CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath : @"transform" ];
    
    //animation. toValue = [ NSValue valueWithCATransform3D :rotationTransform];
    animation.fromValue	= [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 1, 0, 0)];
    animation.toValue   = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 0, 0)];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation. duration   =  dur;
    
    //这两句是保持移动后保持不变
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation. delegate = self ;
    return animation;
    
}

- (void)animationDidStart:(CAAnimation *)anim
{
    _next_layer = [layerArray objectAtIndex:_currentPage];
    _next_layer.transform = CATransform3DMakeRotation(0, 1, 0, 0);
    _next_layer.hidden = NO;
    
    _bottom_layer.hidden = NO;
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(here) userInfo:nil repeats:NO];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;
{
    [self bringSubviewToFront:_bottomImageView];
    
    _bottom_layer = [layerHelperArray objectAtIndex:(_currentPage-1+_flipNumber)%_flipNumber];
    _bottom_layer.transform = CATransform3DMakeRotation(0, 1, 0, 0);
    ((CustomLayer*)[layerHelperArray objectAtIndex:_currentPage]).hidden = YES;
    ((CustomLayer*)[layerHelperArray objectAtIndex:_currentPage]).transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    
    [_dragging_layer removeAnimationForKey: @"transform"];
    _dragging_layer.hidden = YES;

    
}

-(void)here {
    _bottomImageView.image = nil;
    _bottomImageView.image = bottomViewArray[_currentPage];
}

@end
