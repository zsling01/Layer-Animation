//
//  WaveView.m
//  02-MASK遮罩
//
//  Created by zsling on 17/7/11.
//  Copyright © 2017年 zsling. All rights reserved.
//

#import "WaveView.h"

@interface WaveView ()
{
    CGFloat _width;
    CGFloat _height;
}

/**
 角速度 T ＝ 2 * M_PI / w, 如果想 wave长度内一个周期，则
 angularSpeed = 2 * M_PI / CGRectGetWidth(self.view.frame)
 */
@property (nonatomic, assign) CGFloat angularSpeed;

/**
 相位，可以理解为偏移量
 */
@property (nonatomic, assign) CGFloat phasePosition;

/**
 波动Layer
 */
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

/**
 定时器，刷屏
 */
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation WaveView

// y = Asin(ωx+φ)+k
#pragma mark - LiftCycle
+ (instancetype)waveViewWithFrame:(CGRect)frame {
    WaveView *waveV = [[WaveView alloc] initWithFrame:frame];
    return waveV;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpBaseUI];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setUpBaseUI];
    }
    return self;
}


- (void)dealloc {
    [self.displayLink invalidate];
    self.displayLink = nil;
}


#pragma mark - Public
- (void)startWave {
    if ([self waving]) {
        return;
    }
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.fillColor = self.waveColor.CGColor;
    [self.layer addSublayer:self.shapeLayer];
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(redrawWave)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}


- (void)stopWave {
    [UIView animateWithDuration:1.0f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.displayLink invalidate];
        self.displayLink = nil;
        self.shapeLayer.path = nil;
        self.alpha = 1.0;
    }];
}


- (BOOL)waving {
    if (self.shapeLayer.path) {
        return YES;
    }
    return NO;
}


#pragma mark - Private
- (void)setUpBaseUI {
    _width = CGRectGetWidth(self.frame);
    _height = CGRectGetHeight(self.frame);
    _cycleCount = 1;
    _angularSpeed = 2 * M_PI / _width;
    _amplitude = _height / 2;
    _waveSpeed = 0.1;
}

- (void)setCycleCount:(CGFloat)cycleCount {
    _cycleCount = cycleCount;
    _angularSpeed = _cycleCount * 2 * M_PI / _width;
}


- (void)redrawWave {
    _phasePosition += _waveSpeed;

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 10);
    
    CGFloat y = 0;
    for (CGFloat x = 0; x < _width; x++) {
        y = _amplitude * sin(_angularSpeed * x + _phasePosition);
        CGPathAddLineToPoint(path, NULL, x, y);
    }
    
    CGFloat direction = _waveDirection == WaveDirectionUp ? 1 : -1;
    CGPathAddLineToPoint(path, NULL, _width, direction * _height);
    CGPathAddLineToPoint(path, NULL, 0, direction * _height);
    CGPathCloseSubpath(path);
    
    _shapeLayer.path = path;
    CGPathRelease(path);
}


@end
