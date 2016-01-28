//
//  RLDoublePipes.m
//  FlappyBird
//
//  Created by rylynn lai on 15/10/21.
//  Copyright © 2015年 rylynn lai. All rights reserved.
//

#import "RLDoublePipes.h"

#define pipeWidth 52
#define pipeHeight 360
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
#define pipesFWithY(Y) CGRectMake(screenW, Y, pipeWidth, screenW)
#define pipeGap 120

@implementation RLDoublePipes

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:pipesFWithY(-(rand() % 300))]) {
        UIImageView *pipeUp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pipe_up"]];
        _pipeUp = pipeUp;
        _pipeUp.frame = CGRectMake(0, pipeHeight + pipeGap, pipeWidth, pipeHeight);
        [self addSubview:_pipeUp];
        
        UIImageView *pipeDown = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pipe_down"]];
        _pipeDown = pipeDown;
        _pipeDown.frame = CGRectMake(0, 0, pipeWidth, pipeHeight);
        [self addSubview:_pipeDown];
    }
    return self;
}


+ (instancetype)doublePipes {
    RLDoublePipes *doublePipes = [[self alloc] init];
    return doublePipes;
}

- (void)sweepPass {
    if (self.frame.origin.x <= - pipeWidth) {
        self.frame = pipesFWithY(-(rand() % 300));
        self.through = NO;
    }
    CGPoint tempC = self.center;
    tempC.x --;
    self.center = tempC;
}

@end
