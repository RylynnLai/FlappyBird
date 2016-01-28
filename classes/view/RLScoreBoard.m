//
//  RLScoreBoard.m
//  FlappyBird
//
//  Created by rylynn lai on 15/10/21.
//  Copyright © 2015年 rylynn lai. All rights reserved.
//

#import "RLScoreBoard.h"

#define screenW [UIScreen mainScreen].bounds.size.width

@interface RLScoreBoard ()
@property (nonatomic, strong) NSMutableDictionary *numImgDic;
@end

@implementation RLScoreBoard

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib {
    [self setUp];
}

//加载数字图片,封装成字典
- (void)setUp {
    _score = 0;
    
    for (int i = 0; i < 10; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"font_0%d", 48 + i]];
        [self.numImgDic setObject:image forKey:[NSString stringWithFormat:@"%d", i]];
    }
}

- (NSMutableDictionary *)numImgDic {
    if (!_numImgDic) {
        _numImgDic = [NSMutableDictionary dictionary];
    }
    return _numImgDic;
}

- (void)setScore:(NSInteger)score {
    _score = score;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSArray *scoreStrs = [self arrayWithInteger:_score];
    
    for (NSInteger i = scoreStrs.count; i > 0; i --) {
        if ([scoreStrs[i - 1] intValue] != 0) {//从高位开始,第一个不为0的数字才开始转为数字图片添加
            for (NSInteger j = i; j > 0; j --) {
                int num = [scoreStrs[j - 1] intValue];
                UIImage *scoreImg = self.numImgDic[[NSString stringWithFormat:@"%d", num]];
                [self addSubview:[[UIImageView alloc] initWithImage:scoreImg]];
            }
            break;
        }else if (i == 1) {//现实0分
            UIImage *scoreImg = self.numImgDic[@"0"];
            [self addSubview:[[UIImageView alloc] initWithImage:scoreImg]];
        }
    }
    [self setNeedsLayout];
}
//转换成数组
- (NSMutableArray *)arrayWithInteger:(NSInteger)integer {
    //    NSInteger one = score % 10;
    //    NSInteger ten = (score - one) % 100;
    //    NSInteger hundred = (score - ten) % 1000;
    //    NSInteger thousand = (score - hundred) % 10000;
    //    ......
    NSMutableArray *scoreStrs = [NSMutableArray arrayWithCapacity:8];//最大8位数得分
    NSInteger tempResult = 0;
    //转换为数组
    for (int i = 1; i <= 8; i ++) {
        NSInteger result = ((integer - tempResult) % (NSInteger)pow(10, i)) / (NSInteger)pow(10, i - 1);
        tempResult = result;
        [scoreStrs addObject:@(result)];
    }
    return scoreStrs;
}
- (void)layoutSubviews {
    NSInteger count = self.subviews.count;
    CGFloat offsetX = -12 * (count -1);
    for (int i = 0; i < count; i ++) {
        UIImageView *scoreImgV = self.subviews[i];
        scoreImgV.center = CGPointMake(screenW / 2 + offsetX + 24 * i, scoreImgV.center.y);
    }
}
- (void)reSetScore {
    self.score = 0;
    [self setNeedsLayout];
}

@end
