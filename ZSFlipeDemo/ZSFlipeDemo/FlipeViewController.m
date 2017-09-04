//
//  FlipeViewController.m
//  02-MASK遮罩
//
//  Created by zsling on 17/7/12.
//  Copyright © 2017年 zsling. All rights reserved.
//

#import "FlipeViewController.h"

@interface FlipeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *topView;

@property (weak, nonatomic) IBOutlet UIImageView *bottomView;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation FlipeViewController

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor blackColor].CGColor];
        _gradientLayer.opacity = 0;
//        _gradientLayer.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor redColor].CGColor, (id)[UIColor yellowColor].CGColor];
//        _gradientLayer.startPoint = CGPointMake(0, 0);
//        _gradientLayer.endPoint = CGPointMake(1, 1);
//        _gradientLayer.locations = @[@0.05, @0.6, @0.8];
    }
    return _gradientLayer;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 这里注意：手势View的高度应该为 topView ＋ bottomView的高度，即100 ＋ 100，因为topview的anchorPoint为（0.5，1）则设置anchorPoint后layer图层会让最底部跟约束的中心点处于同一水平线
    self.topView.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
    self.topView.layer.anchorPoint = CGPointMake(0.5, 1);
    self.bottomView.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
    self.bottomView.layer.anchorPoint = CGPointMake(0.5, 0);
    
    self.gradientLayer.bounds = self.bottomView.bounds;
    self.gradientLayer.position = CGPointMake(self.bottomView.bounds.size.width * 0.5, self.bottomView.bounds.size.height * 0.5);
    [self.bottomView.layer addSublayer:self.gradientLayer];
}


- (IBAction)flipGesture:(UIPanGestureRecognizer *)pan {
    CGPoint offset = [pan translationInView:pan.view];
    
    CGFloat angle = MIN(offset.y * M_PI / 250, M_PI);
    
    CATransform3D transform = CATransform3DIdentity;
    // 这个参数用于远小近大
    transform.m34 = -1 / 400.0;
    
    self.gradientLayer.opacity = offset.y * 1.0 / 250;
    self.topView.layer.transform = CATransform3DRotate(transform, -angle, 1, 0, 0);
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.topView.layer.transform = CATransform3DIdentity;
            self.gradientLayer.opacity = 0;
        } completion:^(BOOL finished) {
        }];
    }
}

@end
