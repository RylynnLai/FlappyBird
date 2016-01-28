//
//  RLStar.h
//  FlappyBird
//
//  Created by rylynn lai on 15/11/17.
//  Copyright © 2015年 rylynn lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RLStar : UIImageView

@property (nonatomic, getter=isNewOne) BOOL newOne;
+ (instancetype)star;
- (void)sweepPass;
@end
