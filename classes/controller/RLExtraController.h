//
//  RLExtraController.h
//  FlappyBird
//
//  Created by rylynn lai on 15/11/7.
//  Copyright © 2015年 rylynn lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RLScoreBoard.h"


@interface RLExtraController : UIViewController
@property (nonatomic) NSInteger score;
@property (weak, nonatomic) RLScoreBoard *scoreBoard;
@end
