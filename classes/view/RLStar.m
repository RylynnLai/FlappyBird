//
//  RLStar.m
//  FlappyBird
//
//  Created by rylynn lai on 15/11/17.
//  Copyright © 2015年 rylynn lai. All rights reserved.
//

#import "RLStar.h"
#define starHW 30
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
#define starFWithY(Y) CGRectMake(screenW + 30, Y, starHW, starHW)


@interface RLStar ()

@property (nonatomic) CGFloat angle;
@property (nonatomic) NSInteger score;
@end

@implementation RLStar

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:starFWithY(rand() % (int)screenH)]) {
        self.image = [UIImage imageNamed:@"star-vector"];
        _angle = rand() % 60 - 120;
        self.newOne = NO;
    }
    return self;
}


+ (instancetype)star {
    RLStar *star = [[RLStar alloc] init];
    
//    创建旋转动画对象
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.toValue = @(- M_PI * 2);
    anim.repeatCount = MAXFLOAT;
    anim.duration = 5;
    [star.layer addAnimation:anim forKey:nil];
//    
//    //创建x移动动画对象
//    CABasicAnimation *anim1 = [CABasicAnimation animation];
//    anim1.delegate = star;
//    anim1.keyPath = @"position.x";
//    anim1.toValue = @(-40);
//    //动画完成时,会自动的删除动画
//    anim1.removedOnCompletion = NO;
//    //保持动画完毕时最前面的那个效果.
//    anim1.fillMode = @"forwards";
//    anim1.duration = arc4random_uniform(5) + 2;
//    [star addAnimation:anim1 forKey:nil];
//    
//    //创建y移动动画对象
//    CABasicAnimation *anim2 = [CABasicAnimation animation];
//    anim2.keyPath = @"position.y";
//    anim2.toValue = @(arc4random_uniform(screenW * 2) - screenW * 0.5);
//    //动画完成时,会自动的删除动画
//    anim2.removedOnCompletion = NO;
//    //保持动画完毕时最前面的那个效果.
//    anim2.fillMode = @"forwards";
//    anim2.duration = 5;
//    [star addAnimation:anim2 forKey:nil];
    
    return star;
}
- (void)sweepPass {
    if (self.frame.origin.x <= - 40) {
        self.frame = starFWithY(rand() % (int)screenH);
        _angle = rand() % 60 - 120;
        self.newOne = YES;
    }
    CGPoint tempC = self.center;
    tempC.x += sin(_angle * M_PI / 180.0) * 5;
    tempC.y -= cos(_angle * M_PI / 180.0) * 5;
    self.center = tempC;
}


@end
