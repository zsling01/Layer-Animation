//
//  WaveView.h
//  02-MASK遮罩
//
//  Created by zsling on 17/7/11.
//  Copyright © 2017年 zsling. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WaveDirection) {
    WaveDirectionUp,        // 上半部分波纹
    WaveDirectionDown       // 下半部分波纹
};

@interface WaveView : UIView
/**
 振幅，默认是高度的1/2
 */
@property (nonatomic, assign) CGFloat amplitude;

/**
 一个长度内的周期数，例如如果现在wave长度内展示两个周期，则为2，默认为1
 */
@property (nonatomic, assign) CGFloat cycleCount;

/**
 波动单位内移动的距离，值越大，波动的越快
 */
@property (nonatomic, assign) CGFloat waveSpeed;

/**
 波的颜色
 */
@property (nonatomic, strong) UIColor *waveColor;

/**
 波的上下位置,默认 WaveDirectionUp
 */
@property (nonatomic, assign) WaveDirection waveDirection;

+ (instancetype)waveViewWithFrame:(CGRect)frame;


/**
 开始波动
 */
- (void)startWave;

/**
 停止波动
 */
- (void)stopWave;

/**
 是否在波动

 @return YES 当前正在波动
         NO  当前没有在波动
 */
- (BOOL)waving;

@end
