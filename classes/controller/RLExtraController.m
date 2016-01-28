//
//  RLExtraController.m
//  FlappyBird
//
//  Created by rylynn lai on 15/11/7.
//  Copyright © 2015年 rylynn lai. All rights reserved.
//

#import "RLExtraController.h"
#import "RLExtraGuideView.h"
#import "RLExtraBg.h"
#import "RLFlyPipe.h"
#import "RLBird.h"
#import "RLGameOver.h"
#import "UIView+frame.h"

#import "RLStar.h"


#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
//游戏状态
typedef NS_ENUM(NSInteger, RLExtraGameState) {
    RLExtraGameStateGuide,
    RLExtraGameStateGameStart,
    RLExtraGameStateGameOver,
};
@interface RLExtraController ()<RLGameOverDelegate>
@property (nonatomic, strong) RLExtraBg *extraBg;
@property (weak, nonatomic) RLBird *bird;
//@property (nonatomic, strong) RLFlyPipe *flyPipe;
@property (weak, nonatomic) IBOutlet RLExtraGuideView *guideView;
@property (nonatomic, strong) RLGameOver *gameOverView;
@property (nonatomic, strong) NSMutableArray *flyPipes;
@property (nonatomic, strong) NSMutableArray *stars;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic) RLExtraGameState extragameState;
@end

@implementation RLExtraController

#pragma mark -------------------------------------------------------------------------
#pragma mark 定时器懒加载,定时器启动与停止



- (CADisplayLink *)displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        _displayLink.paused = YES;
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return _displayLink;
}
- (void)startDisplayLink {
    self.displayLink.paused = NO;
}
- (void)stopDisplayLink {
    self.displayLink.paused = YES;
    [self.displayLink invalidate];
    self.displayLink = nil;
}
- (RLBird *)bird {
    if (!_bird) {
        RLBird *bird = [RLBird birdBorn];
        _bird = bird;
        [self.view addSubview:_bird];
    }
    return _bird;
}
- (RLExtraBg *)extraBg {
    if (!_extraBg) {
        RLExtraBg *bg = [[RLExtraBg alloc] init];
        _extraBg = bg;
        [self.view insertSubview:bg atIndex:0];
    }
    return _extraBg;
}
- (NSMutableArray *)flyPipes {
    if (!_flyPipes) {
        _flyPipes = [NSMutableArray arrayWithCapacity:5];
        for (int i = 0; i < 5; i ++) {
            RLFlyPipe *flyPipe = [RLFlyPipe flyPipe];
            flyPipe.x += i * 150;
            [_flyPipes addObject:flyPipe];
            [self.view addSubview:flyPipe];
        }
    }
    return _flyPipes;
}

- (NSMutableArray *)stars {
    if (!_stars) {
        _stars = [NSMutableArray arrayWithCapacity:20];
        for (int i = 0; i < 10; i ++) {
            RLStar *star = [RLStar star];
            star.x += i * 40;
            [_stars addObject:star];
            [self.view addSubview:star];
        }
    }
    return _stars;
}

- (RLGameOver *)gameOverView {
    if (!_gameOverView) {
        RLGameOver *gameOverV = [RLGameOver gameOver];
        _gameOverView = gameOverV;
        _gameOverView.delegate = self;
        [self.view addSubview:_gameOverView];
    }
    return _gameOverView;
}

- (void)update {
        switch (_extragameState) {
            case RLExtraGameStateGuide://游戏引导
                [self.bird flyUpAndDown];
                [self.extraBg move];
                [_guideView guideGesture];
                break;
            case RLExtraGameStateGameStart://游戏开始
                [self.extraBg move];
//                for (RLFlyPipe *flyPipe in self.flyPipes) {
//                    [flyPipe sweepPass];
//                    if (CGRectIntersectsRect(_bird.frame, flyPipe.frame)) {
//                        self.extragameState = RLExtraGameStateGameOver;
//                        flyPipe.image = [UIImage imageNamed:@"pipe_up"];
//                    }
//                }
                
                for (RLStar *star in self.stars) {
                    [star sweepPass];
                    if (CGRectIntersectsRect(_bird.frame, star.frame)) {
                        self.extragameState = RLExtraGameStateGameOver;
                    }else if (star.isNewOne) {//判断得分
                        _scoreBoard.score ++;
                        star.newOne = false;
                    }
                }
                break;
            case RLExtraGameStateGameOver://游戏结束
                [self stopDisplayLink];
                [self.gameOverView poppingOut];
                [_bird stopAnimating];
                for (RLStar *star in self.stars) {
                    [star.layer removeAllAnimations];
                }
                [self.view removeGestureRecognizer:self.view.gestureRecognizers[0]];
                [self shake];
                break;
        }
}

#pragma mark ------------------------------------------------------------
#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.extragameState = RLExtraGameStateGuide;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    
    [self startDisplayLink];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    self.scoreBoard.y += 100;
}

- (void)shake {
    CGPoint tempC = self.view.center;
    tempC.x += 5;
    self.view.center = tempC;
    tempC.x -= 5;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.view.center = tempC;
    } completion:^(BOOL finished) {
        
    }];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    RLStar *star = [RLStar star];
//    [self.view.layer insertSublayer:star above:_extraBg.layer];
//}

- (void)pan:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateBegan) {
        if (_extragameState == RLExtraGameStateGuide) {
            _extragameState = RLExtraGameStateGameStart;
            _guideView.hidden = YES;
            
        }
    }else if (pan.state == UIGestureRecognizerStateChanged) {
          CGPoint transP =  [pan translationInView:self.view];
          self.bird.transform = CGAffineTransformTranslate(self.bird.transform, transP.x, transP.y);
          //复位操作,(相对于上一次).
          [pan setTranslation:CGPointZero inView:self.bird];
    }
    
}

#pragma mark -------------------------------------------------------------------------
#pragma mark RLGameOverDelegate
- (void)resetGameOver:(RLGameOver *)gameOver {
    
    [self.flyPipes makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.flyPipes = nil;
    [self.bird resetBird];
    [_bird flyUpAndDown];
    
    self.extragameState = RLExtraGameStateGuide;
    
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RLExtraController * VC = [storyBoard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = VC;
    
}



@end
