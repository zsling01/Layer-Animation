//
//  ZSGradientColorLayer.m
//  ZSGradientDemo
//
//  Created by zsling on 17/7/14.
//  Copyright © 2017年 zsling. All rights reserved.
//

#import "ZSGradientColorLayer.h"
#import <UIKit/UIKit.h>

@interface ZSGradientColorLayer ()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@property (nonatomic, strong) CAKeyframeAnimation *anim;

@end

@implementation ZSGradientColorLayer

+ (instancetype)layerWithColors:(NSArray *)colors {
    ZSGradientColorLayer *layer = [[[self class] alloc] init];
    layer.colors = colors;
    return layer;
}


- (instancetype)init {
    if (self = [super init]) {
        [self setUpBaseLayer];
    }
    return self;
}


- (void)startAnimation {
    [self.gradientLayer addAnimation:self.anim forKey:@"colorChangeAnim"];
}


- (void)stopAnimation {
    [self.gradientLayer removeAnimationForKey:@"colorChangeAnim"];
}


- (void)setUpBaseLayer {
    self.gradientLayer = [CAGradientLayer layer];
    [self addSublayer:self.gradientLayer];
    self.gradientLayer.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor blueColor].CGColor];
    
    self.anim = [CAKeyframeAnimation animationWithKeyPath:@"colors"];
    self.anim.repeatCount = HUGE;
    
    self.perDuration = 5;
}


- (void)setColors:(NSArray *)colors {
    _colors = colors;

    NSMutableArray *colorChange = [NSMutableArray arrayWithArray:colors];
    [colorChange addObject:[colors firstObject]];
    self.anim.values = colorChange;
    self.anim.duration = colorChange.count * self.perDuration;
}


- (void)layoutSublayers {
    [super layoutSublayers];
    self.gradientLayer.frame = self.bounds;
}

@end
