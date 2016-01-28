//
//  RLExtraGuideView.m
//  FlappyBird
//
//  Created by rylynn lai on 15/11/7.
//  Copyright © 2015年 rylynn lai. All rights reserved.
//

#import "RLExtraGuideView.h"

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

@interface RLExtraGuideView ()

@property (nonatomic, getter = isDown) BOOL down;
@end

@implementation RLExtraGuideView


- (void)guideGesture {
    CGPoint tempC = self.center;
    if (self.down) {
        if (tempC.y >= screenH - 140) {
            _down = NO;
        }
        tempC.y += 0.5;
    }else {
        if (tempC.y < (screenH - 140 - 30) ) {
            _down = YES;
        }
        tempC.y -= 0.5;
    }
    self.center = tempC;
}



@end
