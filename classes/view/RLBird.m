//
//  RLBird.m
//  flapppyBird
//
//  Created by rylynn lai on 15/10/21.
//  Copyright © 2015年 rylynn lai. All rights reserved.
//

#import "RLBird.h"
#import "RLGameOver.h"
#import "RLGameOver.h"

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
#define birdWH 18
#define birdFrame CGRectMake(screenW / 3, screenH / 2, birdWH, birdWH)
#define landLoca screenH - 120


@interface RLBird ()

@property (nonatomic, getter = isFlyingDown) BOOL flyingDown;
@property (nonatomic) NSInteger count;
@property (nonatomic) CGFloat velocity;
@end

@implementation RLBird

+ (instancetype)birdBorn {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.image = [UIImage imageNamed:@"bird0_1"];
        self.frame = birdFrame;
        self.contentMode = UIViewContentModeCenter;
        NSMutableArray *birdImages = [NSMutableArray array];
        for (int i = 0; i < 3; i ++) {
            UIImage *bird = [UIImage imageNamed:[NSString stringWithFormat:@"bird0_%i",i]];
            [birdImages addObject:bird];
        }
        self.animationImages = birdImages;
        self.animationDuration = 0.5;
        [self startAnimating];
    }
    return self;
}

- (void)awakeFromNib {
    self.frame = birdFrame;
    NSMutableArray *birdImages = [NSMutableArray array];
    for (int i = 0; i < 3; i ++) {
        UIImage *bird = [UIImage imageNamed:[NSString stringWithFormat:@"bird0_%i",i]];
        [birdImages addObject:bird];
    }
    self.animationImages = birdImages;
    self.animationDuration = 0.5;
    [self startAnimating];
}
//直向前飞
- (void)flyForword {
    CGRect tempF = self.frame;
    if (tempF.origin.x >= screenW) {
        tempF.origin.x = (- tempF.size.width);
    }
    tempF.origin.x ++;
    self.frame = tempF;
}
//上下飞(在准备界面)
- (void)flyUpAndDown {
    CGPoint tempC = self.center;
    if (self.isFlyingDown) {
        if (tempC.y >= screenH / 2) {
            _flyingDown = NO;
        }
        tempC.y += 0.5;
    }else {
        if (tempC.y < (screenH / 2 - 30) ) {
            _flyingDown = YES;
        }
        tempC.y -= 0.5;
    }
    self.center = tempC;
}
//模拟重力下落
- (void)flyJumpAndFall {
    CGPoint tempC = self.center;
    CGFloat offV = - 1.0/60 * 600;
    CGFloat s = (_velocity + _velocity + offV) * 1/60 * 0.5;
    tempC.y -= s;
    self.center = tempC;
    if (self.center.y >= 1000) {
        _velocity = 0;
    }
    _velocity += offV;
    if (_velocity > 0) {
        self.transform = CGAffineTransformMakeRotation(M_PI_2 * (- 0.3));
    }else {
        self.transform = CGAffineTransformMakeRotation(M_PI_2 * 0.3);
    }
}

- (void)resetVelocity {
    _velocity = 250;
}

- (void)resetBird {
    self.frame = birdFrame;
    [self startAnimating];
    self.transform = CGAffineTransformMakeRotation(0);
    _velocity = 0;
}

- (void)dead {
    [self stopAnimating];
    self.image = [UIImage imageNamed:@"bird0_1"];
    CGPoint tempC = self.center;
    CGFloat off = tempC.y - (landLoca);
    tempC.y -= off;
    //落地
    [UIView animateWithDuration: sqrt(fabs(2 * off * 0.001)) delay:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.center = tempC;
        self.transform = CGAffineTransformMakeRotation(M_PI_2 * 0.3);
    } completion:^(BOOL finished) {
       
    }];
}

@end
