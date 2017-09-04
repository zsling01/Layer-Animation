//
//  EmitterViewController.m
//  02-MASK遮罩
//
//  Created by zsling on 17/7/12.
//  Copyright © 2017年 zsling. All rights reserved.
//

#import "EmitterViewController.h"

#define kMainW [UIScreen mainScreen].bounds.size.width
#define kMainH [UIScreen mainScreen].bounds.size.height

@interface EmitterViewController ()

@property (nonatomic, strong) CAEmitterLayer *emitteLayer;

@end

@implementation EmitterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self fireWorks];
//    [self mydemo];
}

// 属性了解,http://www.cnblogs.com/densefog/p/5424155.html

- (void)mydemo {
    CAEmitterLayer *layer = [CAEmitterLayer layer];
    self.emitteLayer = layer;
    layer.emitterPosition = CGPointMake(0, 0);
    layer.emitterSize = CGSizeMake(200, 200);
    layer.zPosition = 30;
    layer.emitterShape = kCAEmitterLayerPoint;
    layer.emitterMode = kCAEmitterLayerSurface;
    [self.view.layer addSublayer:layer];
    
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.name = @"move";
    cell.contents = (id)[UIImage imageNamed:@"dolt"].CGImage;
    cell.birthRate = 20;
    cell.lifetime = 10;
    cell.lifetimeRange = 2;
    cell.velocity = 50;
    cell.velocityRange = 5;
    cell.yAcceleration = 15;
    cell.emissionLongitude = M_PI_4 * 3;
    cell.emissionRange = M_PI_2;
    cell.scale = 0.2;
    cell.scaleRange = 0.1;
    cell.scaleSpeed = -0.05;
    cell.alphaRange = -0.4;
    cell.alphaSpeed = -0.1;
    
    cell.color = [UIColor colorWithRed:1 green:0 blue:0 alpha:1.0].CGColor;
    cell.redRange = 10;
    cell.blueRange = 10;
    cell.greenRange = 10;
    cell.redSpeed = 0.01;
    cell.blueSpeed = 0.2;
    cell.greenSpeed = 0.3;
    
    layer.emitterCells = @[cell];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSSet *allTouces = [event allTouches];
    UITouch *touch = [allTouces anyObject];
    CGPoint point = [touch locationInView:[touch view]];
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"emitterCells.move.scale"];
    anim.fromValue = @0.02;
    anim.toValue = @1.5;
    anim.duration = 1.0;
    [self.emitteLayer addAnimation:anim forKey:nil];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.emitteLayer.position = point;
    [CATransaction commit];
}

- (void)fire {
    
}



- (void)fireWorks {
    CAEmitterLayer *layer = [CAEmitterLayer layer];
    layer.emitterPosition = CGPointMake(kMainW / 2, kMainH);
    layer.emitterSize = CGSizeMake(kMainW / 2, 0);
    layer.emitterShape = kCAEmitterLayerLine;
    layer.emitterMode = kCAEmitterLayerSurface;
    layer.seed = arc4random() %100 + 1;
    [self.view.layer addSublayer:layer];
    
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.name = @"spark";
    cell.contents = (id)[UIImage imageNamed:@"dolt"].CGImage;
    cell.birthRate = 5;
    cell.lifetime = 1.6;
    cell.lifetimeRange = 1;
    cell.velocity = 300;
    cell.velocityRange = 20;
    cell.yAcceleration = 70;
//    cell.emissionLongitude =
    cell.scale = 0.2;
    cell.scaleRange = 0.1;
    cell.scaleSpeed = 0.01;
    cell.color = (__bridge CGColorRef _Nullable)((id)[UIColor redColor].CGColor);
    cell.redRange = 10;
    cell.blueRange = 10;
    cell.greenRange = 10;
    
//    //爆炸效果
//    CAEmitterCell *burst    = [CAEmitterCell emitterCell];
//    burst.birthRate         = 1/1.4;
//    burst.velocity          = 0;
//    burst.scale             = 2.5;
//    burst.redSpeed          =- 1.5;
//    burst.blueSpeed         =+ 1.5;
//    burst.greenSpeed        =+ 1.0;
//    burst.lifetime          = 0.35;
//    
//    
//    //烟花
//    CAEmitterCell *spark    = [CAEmitterCell emitterCell];
//    spark.birthRate         = 400;
//    spark.velocity          = 125;
//    spark.emissionRange     = 2 * M_PI;
//    spark.yAcceleration     = 75;
//    spark.lifetime          = 3;
//    
//    spark.contents          = (id)[[UIImage imageNamed:@"Sparkle"] CGImage];
//    spark.scaleSpeed        =- 0.2;
//    spark.greenSpeed        =- 0.1;
//    spark.redSpeed          =  0.4;
//    spark.blueSpeed         =- 0.1;
//    spark.alphaSpeed        =- 0.25;
//    spark.spin              = 2 * M_PI;
//    spark.spinRange         = 2 * M_PI;
    
    CAEmitterCell *wait = [CAEmitterCell emitterCell];
    wait.birthRate = 1/1.4;
    wait.velocity = 0;
    wait.scale = 2.5;
    wait.redSpeed = -1.5;
    wait.blueSpeed = 1.5;
    wait.greenRange = 1.0;
    wait.lifetime = 0.35;
    
    CAEmitterCell *explod = [CAEmitterCell emitterCell];
    explod.contents = (id)[UIImage imageNamed:@"star"].CGImage;
    explod.birthRate = 400;
    explod.lifetime = 3;
    explod.lifetimeRange = 0.1;
    explod.velocity = 100;
    explod.velocityRange = 20;
    explod.yAcceleration = 75;
    explod.scale = 1.0;
    explod.scaleRange = 0.1;
    explod.scaleSpeed = -0.01;
    explod.emissionRange = 2 * M_PI;
    explod.color = (__bridge CGColorRef _Nullable)((id)[UIColor redColor].CGColor);
    explod.redRange = 0.3;
    explod.blueRange = -0.1;
    explod.greenRange = -0.3;
    explod.spin = 2 * M_PI;
    explod.spinRange = 2 * M_PI;
    
    layer.emitterCells = @[cell];
    cell.emitterCells = @[wait];
    wait.emitterCells = @[explod];
}

- (UIColor *)jk_randomColor {
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    return randColor;
}
@end
