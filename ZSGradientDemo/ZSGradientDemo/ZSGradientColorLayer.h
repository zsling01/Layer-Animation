//
//  ZSGradientColorLayer.h
//  ZSGradientDemo
//
//  Created by zsling on 17/7/14.
//  Copyright © 2017年 zsling. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface ZSGradientColorLayer : CALayer

/**
  渐变的颜色数组
 */
@property (nonatomic, strong) NSArray *colors;

/**
 两个渐变的时间间隔，默认 5s
 */
@property (nonatomic, assign) NSTimeInterval perDuration;

+ (instancetype)layerWithColors:(NSArray *)colors;

/**
 开始动画
 */
- (void)startAnimation;

/**
 结束动画
 */
- (void)stopAnimation;

@end
