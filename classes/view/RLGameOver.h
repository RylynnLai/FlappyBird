//
//  RLGameOver.h
//  FlappyBird
//
//  Created by rylynn lai on 15/10/23.
//  Copyright © 2015年 rylynn lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RLGameOver;
@protocol RLGameOverDelegate <NSObject>
@optional
- (NSInteger)gameOverWithScroe;
- (void)resetGameOver:(RLGameOver *)gameOver;

@end

@interface RLGameOver : UIView

@property (nonatomic, weak) id<RLGameOverDelegate> delegate;
+ (instancetype)gameOver;
- (void)poppingOut;
@end
