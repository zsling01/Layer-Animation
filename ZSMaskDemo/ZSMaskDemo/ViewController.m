//
//  ViewController.m
//  ZSMaskDemo
//
//  Created by zsling on 17/7/14.
//  Copyright © 2017年 zsling. All rights reserved.
//

#import "ViewController.h"
#import "ZSFragmentView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bottomImgView;
@property (weak, nonatomic) IBOutlet UIImageView *topImgView;
@property (nonatomic, strong) ZSFragmentView *maskView;

@end

@implementation ViewController

- (ZSFragmentView *)maskView {
    if (!_maskView) {
        _maskView = [[ZSFragmentView alloc] initWithFrame:CGRectZero];
    }
    return _maskView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

// 碎片化遮罩效果
- (IBAction)fragmentMask:(UIButton *)sender {
    self.bottomImgView.hidden = self.topImgView.hidden = NO;
    self.topImgView.maskView = self.maskView;
    [self.maskView show];
}

// 图片遮罩效果
- (IBAction)pictureShapeMaskEffect:(UIButton *)sender {
    self.bottomImgView.hidden = YES;
    self.topImgView.hidden = NO;
    
    CALayer *layer = [CALayer layer];
    UIImage *img = [UIImage imageNamed:@"hehuaShape"];
    layer.contents = (id)img.CGImage;
    layer.bounds = CGRectMake(0, 0, img.size.width, img.size.height);
    layer.contentsScale = [UIScreen mainScreen].scale;
    layer.position = CGPointMake(self.topImgView.bounds.size.width * 0.5, self.topImgView.bounds.size.height * 0.5);
    
    // 可以展示一些动画效果
//    CABasicAnimation *anim = [CABasicAnimation animation];
//    anim.keyPath = @"transform.translation.y";
//    anim.byValue = @200;
//    anim.duration = 2.0;
//    
//    [layer addAnimation:anim forKey:nil];
    
    self.topImgView.layer.mask = layer;
}

// 路径遮罩效果
- (IBAction)pathMaskEffect:(UIButton *)sender {
    self.bottomImgView.hidden = YES;
    self.topImgView.hidden = NO;
    
    // 自定义路径
    UIRectCorner corner = UIRectCornerAllCorners;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-50, -50, 100, 100) byRoundingCorners:corner cornerRadii:CGSizeMake(50, 0)];
    
    // 创建CAShapeLayer
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.anchorPoint = CGPointMake(0.5, 0.5);
    layer.position = CGPointMake(self.topImgView.bounds.size.width * 0.5, self.topImgView.bounds.size.height * 0.5);
    layer.path = path.CGPath;
    
    // 添加动画效果
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale";
    anim.fromValue = @0.2;
    anim.toValue = @10.0;
    anim.duration = 0.5;
    
    [layer addAnimation:anim forKey:nil];
    
    self.topImgView.layer.mask = layer;
}


@end
