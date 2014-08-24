//
//  FMPlayerView.m
//  DoubanFM
//
//  Created by exitingchen on 14-8-13.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMPlayerView.h"
#import "FMPlayerControlButton.h"
#import "FMPlayerPlayButton.h"
#import "FMPlayerAnimationCalculator.h"


static const float kControlButtonMarginLeft = 40;
static const float kControlButtonMarginButtom = 85;
static const float kControlButtonGap = 65;
static const float kPlayButtonMarginTop = 120;
static const float kSmallPlayButtonMarginLeft = 25;
static const float kAdditionButtonMarginLeft = 70;
static const float kAdditionButtonMarginTop = 360;
static const float kSmallHight = 60;

@interface FMPlayerView ()
{
    float _sHeight;
    float _bHeight;
    NSMutableArray *_alphaChangingViews;
}

@property (nonatomic,assign) CGPoint preLoc;

@end

@implementation FMPlayerView

- (void)dealloc
{
    SAFE_DELETE(_alphaChangingViews);
    
    [self removeObserver:self forKeyPath:@"frame"];
    
    for(UIView *view in self.subviews){
        [self removeObserver:view forKeyPath:@"frame"];
    }
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _sHeight = kSmallHight;
        _bHeight = frame.size.height;
        _bOrigin = frame.origin;
        _sOrigin = CGPointMake(0, SCREEN_SIZE.height - _sHeight);
        _status = FMPlayerViewStatusSmall;
        _alphaChangingViews = [[NSMutableArray alloc] init];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidTap)];
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidPan:)];
        
        [tapRecognizer requireGestureRecognizerToFail:panRecognizer];
        
        [self addGestureRecognizer:tapRecognizer];
        [self addGestureRecognizer:panRecognizer];
        
        [tapRecognizer release];
        [panRecognizer release];
        
        self.frame = CGRectMake(_sOrigin.x, _sOrigin.y, SCREEN_SIZE.width, _sHeight);
        
        [self addAdditionButtons];
        [self addLabels];
        [self addControlButtons];
        
        [self addObserver:self forKeyPath:@"frame" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:self];
        
    }
    return self;
}

- (void)addAdditionButtons
{
    CGRect channelRect = CGRectMake(0, 25, SCREEN_SIZE.width, SCREEN_SIZE.height*0.1);
    UIButton *channelButton = [[UIButton alloc] initWithFrame:channelRect];
    [self addSubview:channelButton];
    [_alphaChangingViews addObject:channelButton];
    
    CGRect similarRect = CGRectMake(kAdditionButtonMarginLeft, kAdditionButtonMarginTop, 30, 30);
    UIButton *similarButton = [[UIButton alloc] initWithFrame:similarRect];
    [self addSubview:similarButton];
    [_alphaChangingViews addObject:similarButton];
    
    CGRect lrcRect = CGRectMake(SCREEN_SIZE.width/2.0 - 15, similarRect.origin.y, 30, 30);
    UIButton *lrcButton = [[UIButton alloc] initWithFrame:lrcRect];
    [self addSubview:lrcButton];
    [_alphaChangingViews addObject:lrcButton];
    
    CGRect opRect = CGRectMake(SCREEN_SIZE.width - kAdditionButtonMarginLeft - 30, similarRect.origin.y, 30, 30);
    UIButton *opButton = [[UIButton alloc] initWithFrame:opRect];
    [self addSubview:opButton];
    [_alphaChangingViews addObject:opButton];
    
    [channelButton release];
    [similarButton release];
    [lrcButton release];
    [opButton release];
    
    
    for(UIView *view in _alphaChangingViews){
        view.backgroundColor = [UIColor greenColor];
        view.alpha = 0;
    }
}

- (void)addLabels
{
    CGRect nameRect = CGRectMake(SCREEN_SIZE.width / 2.0 - 50, 290, 100, 30);
    UILabel *songnameLabel = [[UILabel alloc] initWithFrame:nameRect];
    songnameLabel.text = @"Hello world";
    [self addSubview:songnameLabel];
    [_alphaChangingViews addObject:songnameLabel];
    [songnameLabel release];
    
    CGRect artistRect = CGRectMake(SCREEN_SIZE.width /2.0 -  30, 330, 60, 15);
    UILabel *artistLabel = [[UILabel alloc] initWithFrame:artistRect];
    artistLabel.text = @"once";
    [self addSubview:artistLabel];
    [_alphaChangingViews addObject:artistLabel];
    [artistLabel release];
    
}

- (void)addControlButtons
{
    //Init this view as small status.
    float sButtonHight = [FMPlayerControlButton sSize].height;
    float bButtonWidth = [FMPlayerControlButton bSize].width;
    
    CGPoint likeButtonOriginB = CGPointMake(kControlButtonMarginLeft , _bHeight - kControlButtonMarginButtom);
    CGPoint likeButtonOriginS = CGPointMake(SCREEN_SIZE.width/2.0f - 25, _sHeight / 2.0 - sButtonHight / 2.0);
    FMPlayerControlButton *likeButton = [[FMPlayerControlButton alloc] initSmaillOrigin:likeButtonOriginS
                                                                              bigOrigin:likeButtonOriginB];
    
    CGPoint trashButtonOriginB = CGPointMake(SCREEN_SIZE.width/2.0 - bButtonWidth/2.0, likeButtonOriginB.y);
    CGPoint trashButtonOriginS = CGPointMake(likeButtonOriginS.x + kControlButtonGap, likeButtonOriginS.y);
    FMPlayerControlButton *trashButton = [[FMPlayerControlButton alloc] initSmaillOrigin:trashButtonOriginS
                                                                               bigOrigin:trashButtonOriginB];
    
    CGPoint nextButtonOriginB = CGPointMake(SCREEN_SIZE.width - kControlButtonMarginLeft - bButtonWidth, likeButtonOriginB.y);
    CGPoint nextButtonOriginS = CGPointMake(trashButtonOriginS.x + kControlButtonGap, likeButtonOriginS.y);
    FMPlayerControlButton *nextButton = [[FMPlayerControlButton alloc] initSmaillOrigin:nextButtonOriginS
                                                                              bigOrigin:nextButtonOriginB];
    
    [self addSubview:likeButton];
    [self addObserver:likeButton forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:self];
    [self addSubview:trashButton];
    [self addObserver:trashButton forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:self];
    [self addSubview:nextButton];
    [self addObserver:nextButton forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:self];
    
    [likeButton release];
    [trashButton release];
    [nextButton release];
    
    CGSize pSBtnSize = [FMPlayerPlayButton sSize];
    CGSize pBBtnSize = [FMPlayerPlayButton bSize];
    
    CGPoint playButtonOriginB = CGPointMake((SCREEN_SIZE.width - pBBtnSize.width) / 2.0,kPlayButtonMarginTop);
    CGPoint playButtonOriginS = CGPointMake(kSmallPlayButtonMarginLeft, (_sHeight - pSBtnSize.height) / 2.0);
    FMPlayerPlayButton *playButton = [[FMPlayerPlayButton alloc] initSmaillOrigin:playButtonOriginS
                                                                        bigOrigin:playButtonOriginB];
    [self addSubview:playButton];
    [self addObserver:playButton forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:self];
    [playButton release];
}

#pragma mark - Gesture event helpers
- (void)myToucheBegan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint curLoc = [recognizer locationInView:self];
    _preLoc = curLoc;
}

- (void)myTouchMoved:(UIPanGestureRecognizer *)recognizer
{
    CGPoint curLoc = [recognizer locationInView:self];
    if (self.status == FMPlayerViewStatusDrag){
        
            [UIView animateWithDuration:0.1
                             animations:^{
                                 CGRect frame = self.frame;
                                 float changedY = frame.origin.y + (curLoc.y - _preLoc.y);
                                 frame = CGRectMake(0, changedY , SCREEN_SIZE.width, SCREEN_SIZE.height-changedY);
                                 self.frame = frame;
                             }];
        
        }
    
}

- (void)myTouchEnded:(UIPanGestureRecognizer *)recognizer
{
    if (self.status == FMPlayerViewStatusDrag) {
        
        CGPoint velocity = [recognizer velocityInView:self];
        CGFloat centerY = SCREEN_SIZE.height / 2.0f;
        //拖动结束的时候通过此时手指滑动的方向和view的frame大小来决定最终的形态
        if (velocity.y > 0 && self.frame.size.height < SCREEN_SIZE.height * 0.65) {
            [self animateToStatusSmall];
        }else if (velocity.y < 0 && self.frame.size.height > SCREEN_SIZE.height * 0.3){
            [self animateToStatusBig];
        }else{
            if (self.frame.size.height > centerY) {
                [self animateToStatusBig];
            }else{
                [self animateToStatusSmall];
            }
        }
    }
}

#pragma mark - GestureRecognizer Actions.
- (void)viewDidTap
{
    if (self.status == FMPlayerViewStatusSmall) {
        [self animateToStatusBig];
    }
}

- (void)viewDidPan:(UIPanGestureRecognizer *)recognizer
{
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.status = FMPlayerViewStatusDrag;
            [self myToucheBegan:recognizer];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint velocity = [recognizer velocityInView:self];
            
            //在刚开始拖动的时候如果速度比较大的话直接执行切换动画，否则执行拖动动画
            if (velocity.y > 1200 && self.frame.size.height > (SCREEN_SIZE.height - _bOrigin.y) - 30) {
                [self animateToStatusSmall];
            }else if(velocity.y < - 1200 && self.frame.size.height < (SCREEN_SIZE.height - _sOrigin.y) + 30){
                [self animateToStatusBig];
            }else{
                [self myTouchMoved:recognizer];
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        {
            [self myTouchEnded:recognizer];
        }
            break;
        case UIGestureRecognizerStatePossible:
        {
            
        }
            break;
    }
    
}


#pragma mark - Animation helpers.
- (void)animateToStatusBig
{
    if (self.status == FMPlayerViewStatusAnimation) {
        return;
    }
    else{
        self.status = FMPlayerViewStatusAnimation;
    }
    
    void (^animationBlock)(void) = ^{
        CGFloat targetY = _bOrigin.y - 10;
        CGRect frame = CGRectMake(_bOrigin.x,targetY, SCREEN_SIZE.width, SCREEN_SIZE.height-targetY);
        self.frame = frame;
    };
    
    void (^comleteBlock)(BOOL) = ^(BOOL isSuccess){
        
        [UIView animateWithDuration:0.2
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             CGRect frame = CGRectMake(_bOrigin.x,_bOrigin.y, SCREEN_SIZE.width, SCREEN_SIZE.height-_bOrigin.y);                             self.frame = frame;
                         }
                         completion:^(BOOL success){
                             self.status = FMPlayerViewStatusBig;
                         }];

    };
    
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:animationBlock
                     completion:comleteBlock];
}

- (void)animateToStatusSmall
{
    if (self.status == FMPlayerViewStatusAnimation) {
        return;
    }
    else{
        self.status = FMPlayerViewStatusAnimation;
    }
    
    void (^animationBlock)(void) = ^{
        CGFloat targetY = _sOrigin.y + 10;
        CGRect frame = CGRectMake(_sOrigin.x,targetY, SCREEN_SIZE.width, SCREEN_SIZE.height-targetY);
        self.frame = frame;
    };
    
    void (^comleteBlock)(BOOL) = ^(BOOL isSuccess){
        
        [UIView animateWithDuration:0.2
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             CGRect frame = CGRectMake(_sOrigin.x,_sOrigin.y, SCREEN_SIZE.width, SCREEN_SIZE.height-_sOrigin.y);
                             self.frame = frame;
                         }
                         completion:^(BOOL success){
                             self.status = FMPlayerViewStatusSmall;
                         }];
        
    };
    
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:animationBlock
                     completion:comleteBlock];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqual:@"frame"]) {
        
        FMPlayerView *pView = object;
        CGRect pFrame = [change[@"new"] CGRectValue];
        float rate = [FMPlayerAnimationCalculator calculateRate:pView.sOrigin.y end:pView.bOrigin.y current:pFrame.origin.y];
        float alpha = [FMPlayerAnimationCalculator calculateCurrentValue:-2 end:1 rate:rate];
        
        for(UIView *view in _alphaChangingViews){
            view.alpha = alpha;
        }
        
    }
}

+ (float)smallPlayerHeight
{
    return kSmallHight;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

- (void)setSizeToSmall
{
    CGRect frame = CGRectMake(_sOrigin.x, _sOrigin.y, SCREEN_SIZE.width, _sHeight);
    self.frame = frame;
}

- (void)setSizeToBig
{
    CGRect frame = CGRectMake(_bOrigin.x, _bOrigin.y, SCREEN_SIZE.width, _bHeight);
    self.frame = frame;
}

+ (CGPoint)sOrigin
{
   return CGPointMake(0, SCREEN_SIZE.height - kSmallHight);
}
@end
