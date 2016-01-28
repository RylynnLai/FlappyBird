//
//  UIView+frame.h
//  NeteaseLottery
//
//  Created by rylynn lai on 15/10/27.
//  Copyright © 2015年 rylynn lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (frame)
// 分类中是不能声明属性

// @property在类中功能:会自动生成get,set方法的声明和实现,和_成员属性.

// @property在分类功能:只会生成get,set方法的声明(没有实现,没有成员变量)
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat heigth;
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@end
