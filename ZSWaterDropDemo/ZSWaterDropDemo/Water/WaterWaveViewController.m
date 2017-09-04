//
//  WaterWaveViewController.m
//  02-MASK遮罩
//
//  Created by zsling on 17/7/11.
//  Copyright © 2017年 zsling. All rights reserved.
//

#import "WaterWaveViewController.h"
#import "waterWave.h"

@interface WaterWaveViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) waterWave *water;

@end

@implementation WaterWaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    waterWave *water = [[waterWave alloc] initWithFrame:CGRectMake(0, 0, 135, 135)];
    self.water = water;
    water.center = self.view.center;
    [self.view addSubview:water];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.water setNeedsDisplay];
    
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    [self clickCycle:point];
}

- (void)clickCycle:(CGPoint)point {
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(point.x - 30, point.y - 30, 60, 60);
    layer.cornerRadius = 30;
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.delegate = self;
    group.fillMode = kCAFillModeBackwards;
    group.duration = 1.0;
    
    
    CABasicAnimation *basic = [CABasicAnimation animation];
    basic.keyPath = @"transform.scale";
    basic.fromValue = @1.0;
    basic.toValue = @2.0;
    
    CABasicAnimation *operation = [CABasicAnimation animation];
    operation.keyPath = @"opacity";
    operation.fromValue = @1.0;
    operation.toValue = @0;
    
    group.animations = @[basic, operation];
    [layer addAnimation:group forKey:nil];
    [self.view.layer addSublayer:layer];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [layer removeFromSuperlayer];
    });
}



@end
