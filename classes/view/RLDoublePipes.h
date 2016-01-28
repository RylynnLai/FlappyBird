//
//  RLDoublePipes.h
//  FlappyBird
//
//  Created by rylynn lai on 15/10/21.
//  Copyright © 2015年 rylynn lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RLDoublePipes : UIView

@property (nonatomic, weak) UIImageView *pipeUp;

@property (nonatomic, weak) UIImageView *pipeDown;

@property (nonatomic,getter=isThrough) BOOL through;

+ (instancetype)doublePipes;

- (void)sweepPass;

@end
