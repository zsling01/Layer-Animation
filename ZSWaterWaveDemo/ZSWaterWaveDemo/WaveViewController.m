//
//  WaveViewController.m
//  02-MASK遮罩
//
//  Created by zsling on 17/7/11.
//  Copyright © 2017年 zsling. All rights reserved.
//

#import "WaveViewController.h"
#import "WaveView.h"

@interface WaveViewController ()

@property (nonatomic, strong) WaveView *waveView;

@end

@implementation WaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WaveView *waveView = [WaveView waveViewWithFrame:CGRectMake(0, 200, CGRectGetWidth(self.view.frame), 40)];
    waveView.waveColor = [UIColor redColor];
    self.waveView = waveView;
    [self.view addSubview:waveView];
    
    [waveView startWave];
    
}

- (IBAction)amplitedeChange:(UISlider *)sender {
//    self.waveView.amplitude = sender.value;
    self.waveView.frame = CGRectMake(0, 200, CGRectGetWidth(self.view.frame), sender.value);
}

- (IBAction)speedChange:(UISlider *)sender {
    self.waveView.waveSpeed = sender.value;
}

- (IBAction)cycleChange:(UIStepper *)sender {
    self.waveView.cycleCount = sender.value;
}

- (IBAction)directionChange:(UISwitch *)sender {
    self.waveView.waveDirection = sender.on;
}

@end
