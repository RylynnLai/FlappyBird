//
//  RLLand.m
//  flapppyBird
//
//  Created by rylynn lai on 15/10/21.
//  Copyright © 2015年 rylynn lai. All rights reserved.
//

#import "RLLand.h"
#define screenW [UIScreen mainScreen].bounds.size.width

@implementation RLLand

- (void)move {
    CGRect tempF = self.frame;
    if (tempF.origin.x <= (screenW - self.bounds.size.width)) {
        tempF.origin.x = 0.0;
    }
    tempF.origin.x --;
    self.frame = tempF;
}

@end
