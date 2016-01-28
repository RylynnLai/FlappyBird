//
//  ViewController.m
//  flapppyBird
//
//  Created by rylynn lai on 15/10/20.
//  Copyright © 2015年 rylynn lai. All rights reserved.
//

#import "ViewController.h"
#import "RLExtraController.h"
#import "RLLand.h"
#import "RLBird.h"
#import "RLTitle.h"
#import "RLScoreBoard.h"
#import "RLDoublePipes.h"
#import "RLGameOver.h"

#import "RLStar.h"

#import "UIView+frame.h"

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
//游戏状态
typedef NS_ENUM(NSInteger, RLGameState) {
    RLGameStateMainView,
    RLGameStateGuideView,
    RLGameStateGameStart,
    RLGameStateGameOver,
    RLGameStateExtra,
};

@interface ViewController ()<RLGameOverDelegate>
@property (weak, nonatomic) IBOutlet RLLand *land;
@property (weak, nonatomic) RLBird *bird;
@property (weak, nonatomic) IBOutlet RLTitle *FBtitle;
@property (weak, nonatomic) IBOutlet UIButton *guideTap;
@property (weak, nonatomic) IBOutlet RLScoreBoard *scoreBoard;
@property (weak, nonatomic) IBOutlet UIImageView *getReady;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *scoreBtn;

@property (nonatomic, weak) RLGameOver *gameOverView;
@property (nonatomic, weak) RLDoublePipes *doublePipesFir;
@property (nonatomic, weak) RLDoublePipes *doublePipesSec;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic) RLGameState gameState;
@property (nonatomic) NSInteger score;
@end


@implementation ViewController
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
        [self.view insertSubview:_bird aboveSubview:_land];
    }
    return _bird;
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

#pragma mark -------------------------------------------------------------------------
#pragma mark 定时器控制下处理每帧画面的动画与事件
- (void)update {
    switch (_gameState) {
        case RLGameStateMainView://游戏开始欢迎页
            [_land move];
            [_bird flyForword];
            [_FBtitle swing];
            break;
        case RLGameStateGuideView://游戏准备开始
            [_scoreBoard reSetScore];
            [_land move];
            [_bird flyUpAndDown];
            break;
        case RLGameStateGameStart://游戏进行中
            [_land move];
            [_doublePipesFir sweepPass];
            [_doublePipesSec sweepPass];
            [_bird flyJumpAndFall];
            
            if (_bird.y < (- screenH / 2)) {
                self.gameState = RLGameStateExtra;
            }
            
            //坐标系转换[父视图 convertRect:需要转换的视图 toView:目标坐标系视图]
            CGRect pipeUp1F = [_doublePipesFir convertRect:_doublePipesFir.pipeUp.frame toView:self.view];
            CGRect pipeDown1F = [_doublePipesFir convertRect:_doublePipesFir.pipeDown.frame toView:self.view];
            CGRect pipeUp2F = [_doublePipesSec convertRect:_doublePipesSec.pipeUp.frame toView:self.view];
            CGRect pipeDown2F = [_doublePipesSec convertRect:_doublePipesSec.pipeDown.frame toView:self.view];
            
            //判断碰撞
            if (CGRectIntersectsRect(_bird.frame, _land.frame) ||
                CGRectIntersectsRect(_bird.frame, pipeUp1F)    ||
                CGRectIntersectsRect(_bird.frame, pipeDown1F)  ||
                CGRectIntersectsRect(_bird.frame, pipeUp2F)    ||
                CGRectIntersectsRect(_bird.frame, pipeDown2F)) {
                
                self.gameState = RLGameStateGameOver;
                
            //在没有碰撞的前提下,判断是否得分
            }else if (!_doublePipesFir.isThrough && (_doublePipesFir.x) + 52 < _bird.x) {
                _scoreBoard.score ++;
                _doublePipesFir.through = YES;
            }else if (!_doublePipesSec.isThrough && (_doublePipesSec.x) + 52 < _bird.x) {
                _scoreBoard.score ++;
                _doublePipesSec.through = YES;
            }
            
            break;
            
        case RLGameStateGameOver://游戏结束
            [_bird dead];
            [self stopDisplayLink];
            [self.gameOverView poppingOut];
            [self shake];
            break;
            
        case RLGameStateExtra:
            [self stopDisplayLink];
           
            [self pushExtraController];

            break;
            
        default:
            break;
    }
}

#pragma mark -------------------------------------------------------------------------
#pragma mark 所有按钮事件
- (IBAction)playBtnClick {
    _guideTap.hidden = NO;
    _FBtitle.hidden = YES;
    _scoreBoard.hidden = NO;
    _getReady.hidden = NO;
    _playBtn.hidden = YES;
    _scoreBtn.hidden = YES;
    
    self.gameState = RLGameStateGuideView;
    //小鸟重置位置
    [_bird resetBird];
}
- (IBAction)scoreBtnClick {
    [self stopDisplayLink];
    [self pushExtraController];
}
- (IBAction)guideTap:(UIButton *)sender {
    _guideTap.hidden = YES;
    _FBtitle.hidden = YES;
    _getReady.hidden = YES;
    
    RLDoublePipes *doublePipes1 = [RLDoublePipes doublePipes];
    _doublePipesFir = doublePipes1;
    //插入视图在地面后面
    [self.view insertSubview:_doublePipesFir belowSubview:_land];
    
    RLDoublePipes *doublePipes2 = [RLDoublePipes doublePipes];
    _doublePipesSec = doublePipes2;
    //第二排水管在第一排后面(screenW + 52) / 2
    _doublePipesSec.transform = CGAffineTransformMakeTranslation((screenW + 52) / 2, 0);
    //插入视图在地面后面
    [self.view insertSubview:_doublePipesSec belowSubview:_land];
    
    
//    [_bird resetFrame];
    self.gameState = RLGameStateGameStart;
}

#pragma mark -------------------------------------------------------------------------
#pragma mark 屏幕点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_bird resetVelocity];//更新鸟的初速度
}


#pragma mark -------------------------------------------------------------------------
#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.bird resetBird];
    [self startDisplayLink];
    self.gameState = RLGameStateMainView;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark -------------------------------------------------------------------------
#pragma mark 其他
//撞障碍物后抖动
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

- (void)pushExtraController {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RLExtraController * extraVC = [storyBoard instantiateViewControllerWithIdentifier:@"extraController"];
    //传递得分板和得分
    [extraVC.view addSubview:_scoreBoard];
    extraVC.scoreBoard = _scoreBoard;

    UIImageView *extraBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    extraBG.frame = CGRectMake(0, -screenH, screenW, screenH);
    [self.view insertSubview:extraBG belowSubview:_bird];
    [UIView animateWithDuration:2.0 animations:^{
        self.view.y += screenH;
//        extraBG.y += screenH;
    } completion:^(BOOL finished) {
        [UIApplication sharedApplication].keyWindow.rootViewController = extraVC;
        
    }];
}

#pragma mark -------------------------------------------------------------------------
#pragma mark RLGameOverDelegate
- (void)resetGameOver:(RLGameOver *)gameOver {
    [_doublePipesFir removeFromSuperview];
    [_doublePipesSec removeFromSuperview];
    
    [self.bird resetBird];
    [_bird flyUpAndDown];
    
    _guideTap.hidden = NO;
    _getReady.hidden = NO;
    
    self.gameState = RLGameStateGuideView;
    
    [self startDisplayLink];
}

- (NSInteger)gameOverWithScroe {
    return _score;
}

- (void)dealloc {

    NSLog(@"%s", __func__);
}

@end
