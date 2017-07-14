//
//  ZSSlideUnlockView.m
//  ZSGradientDemo
//
//  Created by zsling on 17/7/14.
//  Copyright © 2017年 zsling. All rights reserved.
//

#import "ZSSlideUnlockView.h"

@interface ZSSlideUnlockView ()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@property (nonatomic, strong) CABasicAnimation *anim;

@end

@implementation ZSSlideUnlockView

+ (instancetype)slideUnlockViewWithLabel:(UILabel *)label {
    ZSSlideUnlockView *slideUnlockView = [[[self class] alloc] initWithLabel:label];
    return slideUnlockView;
}


- (instancetype)initWithLabel:(UILabel *)label {
    ZSSlideUnlockView *slideUnloadkView = [[[self class] alloc] init];
    slideUnloadkView.slideLabel = label;
    return slideUnloadkView;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpBaseView];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]) {
        [self setUpBaseView];
    }
    return self;
}

- (void)startAnimation {
    [self.gradientLayer addAnimation:self.anim forKey:@"slideAnim"];
}


- (void)stopAnimation {
    [self.gradientLayer removeAnimationForKey:@"slideAnim"];
}


- (void)setUpBaseView {
    CAGradientLayer *layer = [CAGradientLayer layer];
    self.gradientLayer = layer;
    // 这里可以修改滑动显示的样式，如方向 显示白色的区域
    layer.locations = @[@0.35, @0.5, @0.65];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);
    layer.opacity = 0.8;
    [self.layer addSublayer:layer];
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"locations"];
    self.anim = anim;
    anim.fromValue = @[@0, @0, @0.25];
    anim.toValue = @[@0.75, @1, @1];
    anim.duration = 3.0;
    anim.repeatCount = HUGE;
}


- (void)setSlideLabel:(UILabel *)slideLabel {
    _slideLabel = slideLabel;
    self.gradientLayer.colors = @[(id)slideLabel.textColor.CGColor, (id)[UIColor whiteColor].CGColor, (id)slideLabel.textColor.CGColor];
    // 渐变层的mask layer是文字
    self.gradientLayer.mask = slideLabel.layer;
}


- (void)setDuration:(NSTimeInterval)duration {
    _duration = duration;
    self.anim.duration = duration;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.slideLabel.frame = self.bounds;
    self.gradientLayer.frame = self.bounds;
}

@end
