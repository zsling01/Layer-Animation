//
//  RepliView.m
//  02-MASK遮罩
//
//  Created by zsling on 17/7/12.
//  Copyright © 2017年 zsling. All rights reserved.
//

#import "RepliView.h"

@implementation RepliView

+ (Class)layerClass {
    return [CAReplicatorLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUp];
}

- (void)setUp {
    CAReplicatorLayer *replayer = (CAReplicatorLayer *)self.layer;
    replayer.instanceCount = 2;
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, self.bounds.size.height, 0);
    transform = CATransform3DScale(transform, 1, -1, 0);
    replayer.instanceTransform = transform;
    replayer.instanceAlphaOffset -= 0.3;
    replayer.instanceRedOffset -= 0.1;
    replayer.instanceBlueOffset -= 0.1;
    replayer.instanceGreenOffset -= 0.1;
}
 
@end
