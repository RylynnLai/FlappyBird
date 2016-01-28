//
//  UIView+frame.m
//  NeteaseLottery
//
//  Created by rylynn lai on 15/10/27.
//  Copyright © 2015年 rylynn lai. All rights reserved.
//

#import "UIView+frame.h"

@implementation UIView (frame)

- (CGFloat)width {
    return self.bounds.size.width;
}
- (CGFloat)heigth {
    return self.bounds.size.height;
}
- (CGFloat)x {
    return self.frame.origin.x;
}
- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect tempF = self.frame;
    tempF.size.width = width;
    self.frame = tempF;
}
- (void)setHeigth:(CGFloat)heigth {
    CGRect tempF = self.frame;
    tempF.size.height = heigth;
    self.frame = tempF;
}
- (void)setX:(CGFloat)x {
    CGRect tempF = self.frame;
    tempF.origin.x = x;
    self.frame = tempF;
}
- (void)setY:(CGFloat)y {
    CGRect tempF = self.frame;
    tempF.origin.y = y;
    self.frame = tempF;
}

@end
