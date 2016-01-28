//
//  RLTitle.m
//  flapppyBird
//
//  Created by rylynn lai on 15/10/21.
//  Copyright © 2015年 rylynn lai. All rights reserved.
//

#import "RLTitle.h"

#define screenW [UIScreen mainScreen].bounds.size.width

@interface RLTitle ()

@property (nonatomic, getter = isSwingDown) BOOL swingDown;
@end

@implementation RLTitle

//上下飘
- (void)swing {
    CGPoint tempC = self.center;
    if (self.isSwingDown) {
        if (tempC.y >= 96) {
            _swingDown = NO;
        }
        tempC.y += 0.5;
    }else {
        if (tempC.y < 76) {
            _swingDown = YES;
        }
        tempC.y -= 0.5;
    }
    self.center = tempC;
}
@end
