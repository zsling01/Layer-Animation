//
//  ZSFragmentView.m
//  ZSMaskDemo
//
//  Created by zsling on 17/7/14.
//  Copyright © 2017年 zsling. All rights reserved.
//

#import "ZSFragmentView.h"

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight    [UIScreen mainScreen].bounds.size.height

static const NSInteger horizenCount = 15;
static const NSInteger verticalCount = 2;

@implementation ZSFragmentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpBaseView];
    }
    return self;
}

- (void)setUpBaseView {
    CGFloat perWidth = 1.0 * kScreenWidth / horizenCount;
    CGFloat perHeight = 1.0 * kScreenHeight / verticalCount;
    
    for (int i = 0 ; i < horizenCount; i ++) {
        for (int j = 0; j < verticalCount; j++) {
            CGRect frame = CGRectMake(i * perWidth, j * perHeight, perWidth, perHeight);
            UIView *maskView = [[UIView alloc] initWithFrame:frame];
            maskView.backgroundColor = [UIColor redColor];
            [self addSubview:maskView];
        }
    }
}

- (void)show {
    for (int i = 0 ; i < horizenCount; i ++) {
        for (int j = 0; j < verticalCount; j++) {
            NSInteger idx = i * verticalCount + j;
            UIView *maskView = (UIView *)[self.subviews objectAtIndex:idx];
            
            [UIView animateWithDuration:0.7 delay:0.175 * idx options:UIViewAnimationOptionCurveLinear animations:^{
                maskView.alpha = 0;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

- (void)hide {
    for (int i = horizenCount - 1 ; i >= 0; i --) {
        for (int j = verticalCount - 1; j >= 0; j--) {
            NSInteger idx = i * verticalCount + j;
            UIView *maskView = (UIView *)[self.subviews objectAtIndex:idx];
            
            [UIView animateWithDuration:0.7 delay:0.175 * idx options:UIViewAnimationOptionCurveLinear animations:^{
                maskView.alpha = 1;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

@end
