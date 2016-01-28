//
//  RLScoreBoard.h
//  FlappyBird
//
//  Created by rylynn lai on 15/10/21.
//  Copyright © 2015年 rylynn lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RLScoreBoard : UIView
@property (nonatomic) NSInteger score;

- (void)reSetScore;
@end
