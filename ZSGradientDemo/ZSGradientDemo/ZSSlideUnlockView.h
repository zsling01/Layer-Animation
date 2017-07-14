//
//  ZSSlideUnlockView.h
//  ZSGradientDemo
//
//  Created by zsling on 17/7/14.
//  Copyright © 2017年 zsling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSSlideUnlockView : UIView

/**
 将要显示滑动效果的label
 */
@property (nonatomic, strong) UILabel *slideLabel;

/**
 滑动的时间
 */
@property (nonatomic, assign) NSTimeInterval duration;

+ (instancetype)slideUnlockViewWithLabel:(UILabel *)label;

- (instancetype)initWithLabel:(UILabel *)label;

/**
 开始动画
 */
- (void)startAnimation;

/**
 停止动画
 */
- (void)stopAnimation;

@end
