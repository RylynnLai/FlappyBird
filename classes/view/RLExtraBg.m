//
//  RLExtraBg.m
//  FlappyBird
//
//  Created by rylynn lai on 15/11/8.
//  Copyright © 2015年 rylynn lai. All rights reserved.
//

#import "RLExtraBg.h"

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
@implementation RLExtraBg

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, screenW * 3, screenH);
        self.image = [UIImage imageNamed:@"bgx3"];
    }
    return self;
}


- (void)move {
    CGRect tempF = self.frame;
    if (tempF.origin.x <= (screenW - self.bounds.size.width)) {
        tempF.origin.x = 0.0;
    }
    tempF.origin.x --;
    self.frame = tempF;
}

@end
