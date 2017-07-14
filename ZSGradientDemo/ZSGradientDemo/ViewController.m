//
//  ViewController.m
//  ZSGradientDemo
//
//  Created by zsling on 17/7/14.
//  Copyright © 2017年 zsling. All rights reserved.
//

#import "ViewController.h"
#import "ZSSlideUnlockView.h"
#import "ZSGradientColorLayer.h"

@interface ViewController ()

@property (nonatomic, strong) ZSSlideUnlockView *slideUnlockView;

@property (nonatomic, strong) ZSGradientColorLayer *colorLayer;

@end

@implementation ViewController

- (ZSSlideUnlockView *)slideUnlockView {
    if (!_slideUnlockView) {
        UILabel *textlabel = [[UILabel alloc] init];
        textlabel.textAlignment = NSTextAlignmentCenter;
        textlabel.text = @"滑动来解锁>>";
        textlabel.textColor = [UIColor blackColor];
        textlabel.font = [UIFont systemFontOfSize:30];
        
        _slideUnlockView = [ZSSlideUnlockView slideUnlockViewWithLabel:textlabel];
        _slideUnlockView.frame = CGRectMake(50, 100, 200, 40);
    }
    return _slideUnlockView;
}


- (ZSGradientColorLayer *)colorLayer {
    if (!_colorLayer) {
        NSArray *orgin = @[(id)[UIColor redColor].CGColor, (id)[UIColor blueColor].CGColor];
        NSArray *orgin1 = @[(id)[UIColor orangeColor].CGColor, (id)[UIColor greenColor].CGColor];
        NSArray *orgin2 = @[(id)[UIColor purpleColor].CGColor, (id)[UIColor orangeColor].CGColor];
        NSArray *orgin3 = @[(id)[UIColor yellowColor].CGColor, (id)[UIColor redColor].CGColor];
        NSArray *colorsArray = @[orgin,orgin1, orgin2, orgin3, orgin];
        
        _colorLayer = [ZSGradientColorLayer layerWithColors:colorsArray];
    }
    return _colorLayer;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark 滑动解锁
- (IBAction)slideOpenEffect:(UIButton *)sender {
    self.view.backgroundColor = [UIColor grayColor];
    [self.colorLayer removeFromSuperlayer];
    
    [self.view addSubview:self.slideUnlockView];
    [self.slideUnlockView startAnimation];
}

#pragma mark 背景色渐变
- (IBAction)changeColorEffect:(UIButton *)sender {
    [self.slideUnlockView removeFromSuperview];

    [self.view.layer insertSublayer:self.colorLayer atIndex:0];
    self.colorLayer.frame = self.view.bounds;
    [self.colorLayer startAnimation];
}


@end
