//
//  RLGameOver.m
//  FlappyBird
//
//  Created by rylynn lai on 15/10/23.
//  Copyright © 2015年 rylynn lai. All rights reserved.
//

#import "RLGameOver.h"
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

@implementation RLGameOver

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"RLGameOver" owner:nil options:nil] firstObject];
    }
    self.frame = CGRectMake(0, screenH, screenW, screenH);
    return self;
}

+ (instancetype)gameOver {
    RLGameOver *gameOver = [[[NSBundle mainBundle] loadNibNamed:@"RLGameOver" owner:nil options:nil] firstObject];
    gameOver.frame = CGRectMake(0, screenH, screenW, screenH);
    return gameOver;
}

- (void)poppingOut {
    [UIView animateWithDuration:2.0 animations:^{
        self.frame = self.bounds;
    }];
}
- (IBAction)okBtnClick:(UIButton *)sender {
    [self.delegate resetGameOver:self];
    self.frame = CGRectMake(0, screenH, screenW, screenH);
}
@end
