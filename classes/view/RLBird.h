//
//  RLBird.h
//  flapppyBird
//
//  Created by rylynn lai on 15/10/21.
//  Copyright © 2015年 rylynn lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RLGameOver;
@interface RLBird : UIImageView

- (void)flyForword;
- (void)flyUpAndDown;
- (void)flyJumpAndFall;
- (void)resetBird;
- (void)resetVelocity;
- (void)dead;
+ (instancetype)birdBorn;
@end
