//
//  ReplicatorViewController.m
//  02-MASK遮罩
//
//  Created by zsling on 17/7/12.
//  Copyright © 2017年 zsling. All rights reserved.
//

#import "ReplicatorViewController.h"
#import "RepliView.h"

@interface ReplicatorViewController ()

@property (weak, nonatomic) IBOutlet UIView *musicContentV;
@property (weak, nonatomic) IBOutlet RepliView *repliContentView;
@property (weak, nonatomic) IBOutlet UIView *repLContent;
@property (weak, nonatomic) IBOutlet UIView *circleWaveContent;
@property (weak, nonatomic) IBOutlet UIView *circleRectContent;

@end

@implementation ReplicatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addMusicJump];
    [self addReflectView];
    [self circleWave];
    [self circleRect];
}

// 音乐跳动条
- (void)addMusicJump {
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 2, 50);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    layer.anchorPoint = CGPointMake(0.5, 1);
    layer.position = CGPointMake(10, self.musicContentV.bounds.size.height);
    [self.musicContentV.layer addSublayer:layer];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
        basic.toValue = @0.4;
        basic.duration = 0.5;
        basic.repeatCount = HUGE_VALF;
        basic.autoreverses = YES;
        [layer addAnimation:basic forKey:nil];
    });
    
    CAReplicatorLayer *repLayer = [CAReplicatorLayer layer];
    repLayer.instanceCount = 5;
    repLayer.instanceDelay = 0.3;
    repLayer.instanceTransform = CATransform3DMakeTranslation(10, 0, 0);
    [self.musicContentV.layer addSublayer:repLayer];
    [repLayer addSublayer:layer];
}


// 倒影
- (void)addReflectView {
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.contents = (id)[UIImage imageNamed:@"hehua"].CGImage;
    layer.anchorPoint = CGPointMake(0.5, 1);
    layer.position = CGPointMake(50, 50);
    [self.repLContent.layer addSublayer:layer];
    
    CAReplicatorLayer *replayer = [CAReplicatorLayer layer];
    replayer.instanceCount = 2;
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 100, 0);
    transform = CATransform3DScale(transform, 1, -1, 0);
//    transform = CATransform3DRotate(transform, M_PI, 1, 0, 0);
    replayer.instanceTransform = transform;
    [self.repLContent.layer addSublayer:replayer];
    [replayer addSublayer:layer];
}


// 圆形波
- (void)circleWave {
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 4, 4);
    layer.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7].CGColor;
    layer.cornerRadius = 2;
    layer.masksToBounds = YES;
    layer.position = CGPointMake(self.circleWaveContent.bounds.size.width *  0.5, self.circleWaveContent.bounds.size.height * 0.5);
    [self.circleWaveContent.layer addSublayer:layer];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        
        CABasicAnimation *basic = [CABasicAnimation animation];
        basic.keyPath = @"transform.scale";
        basic.toValue = @50;
        
        CABasicAnimation *alpha = [CABasicAnimation animation];
        alpha.keyPath = @"opacity";
        alpha.toValue = @0;
        
        group.duration = 2.0;
        group.repeatCount = MAXFLOAT;
        group.animations = @[basic, alpha];
        [layer addAnimation:group forKey:nil];
    });
    
    CAReplicatorLayer *replLayer = [CAReplicatorLayer layer];
    replLayer.instanceCount = 5;
    replLayer.instanceDelay = 0.3;
    [self.circleWaveContent.layer addSublayer:replLayer];
    [replLayer addSublayer:layer];
}


// 圆形多图
- (void)circleRect {
    CALayer *layer = [CALayer layer];
    layer.bounds = self.circleRectContent.bounds;
    layer.position = CGPointMake(self.circleRectContent.bounds.size.width * 0.5, self.circleRectContent.bounds.size.height * 0.5);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.circleRectContent.layer addSublayer:layer];
    
    CAReplicatorLayer *repLayer = [CAReplicatorLayer layer];
    repLayer.instanceCount = 12;
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 120, 0);
    transform = CATransform3DRotate(transform, M_PI / 6, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -120, 0);
    repLayer.instanceTransform = transform;
    repLayer.instanceRedOffset -= 0.1;
    repLayer.instanceBlueOffset -= 0.1;
    [self.circleRectContent.layer addSublayer:repLayer];
    [repLayer addSublayer:layer];
}


@end
