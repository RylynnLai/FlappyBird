//
//  RLFlyPipe.m
//  FlappyBird
//
//  Created by rylynn lai on 15/11/7.
//  Copyright © 2015年 rylynn lai. All rights reserved.
//

#import "RLFlyPipe.h"

#define pipeWidth 52
#define pipeHeight 320
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
#define pipeFWithY(Y) CGRectMake(screenW + 180, Y, pipeWidth, screenW)

@interface RLFlyPipe ()
@property (nonatomic) CGFloat angle;
@end

@implementation RLFlyPipe

//        screenH - 160 - 52 ~ - 160 + 52
//             screenH - 212 ~ -108
//             screenH - 104 ~ 0
- (instancetype)initWithFrame:(CGRect)frame {
//    arc4random_uniform(screenH - 104) - 188)//不知为何有时会有问题
    
    if (self = [super initWithFrame:pipeFWithY(rand() % ((int)screenH - 104) - 188)]) {
        self.image = [UIImage imageNamed:@"pipe2_up"];
//        self.transform = CGAffineTransformMakeRotation(0);
        _angle = rand() % 60 - 120;
//        self.transform = CGAffineTransformMakeRotation(_angle * M_PI / 180);
    }
    return self;
}

+ (instancetype)flyPipe {
    RLFlyPipe *flyPipe = [[self alloc] init];
    return flyPipe;
}

- (void)sweepPass {
    if (self.center.x <= - 180) {
//        self.layer.transform = CATransform3DMakeRotation(0, 0, 0, 1);
        self.frame = pipeFWithY(arc4random_uniform(screenH - 104) - 188);
        _angle = rand() % 60 - 120;
//        self.transform = CGAffineTransformMakeRotation(_angle * M_PI / 180);
//        self.layer.transform = CATransform3DMakeRotation(_angle * M_PI / 180, 0, 0, 1);
    }
    CGPoint tempC = self.center;
    tempC.x += sin(_angle * M_PI / 180.0) * 10;
    tempC.y -= cos(_angle * M_PI / 180.0) * 10;
    self.center = tempC;
}

@end
