//
//  FMPlayerView.m
//  DoubanFM
//
//  Created by exitingchen on 14-8-13.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMPlayerView.h"

typedef enum FMPlayerViewStatus {
    FMPlayerViewStatusBig,
    FMPlayerViewStatusDrag,
    FMPlayerViewStatusAnimation,
    FMPlayerViewStatusSmall,
}FMPlayerViewStatus;

@interface FMPlayerView ()
{
    CGPoint _bOrigin;
    CGPoint _sOrigin;
    float _sHeight;
}

@property (nonatomic,assign) FMPlayerViewStatus status;
@property (nonatomic,assign) CGPoint preLoc;
@end

@implementation FMPlayerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _sHeight = 60;
        _bOrigin = frame.origin;
        _sOrigin = CGPointMake(0, SCREEN_SIZE.height - _sHeight);
        _status = FMPlayerViewStatusBig;
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidTap)];
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidPan:)];
        
        [tapRecognizer requireGestureRecognizerToFail:panRecognizer];
        
        [self addGestureRecognizer:tapRecognizer];
        [self addGestureRecognizer:panRecognizer];
        
        [tapRecognizer release];
        [panRecognizer release];
    }
    return self;
}


#pragma mark - Gesture event helpers
- (void)myToucheBegan:(CGPoint)curLoc
{
    _preLoc = curLoc;
}

- (void)myTouchMoved:(CGPoint)curLoc
{
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

- (void)myTouchEnded:(CGPoint)curLoc
{
    if (self.status == FMPlayerViewStatusDrag) {
        float screenCenterY = SCREEN_SIZE.height * 0.4f;
        if (self.frame.size.height > screenCenterY) {
            [self animateToStatusBig];
        }else{
            [self animateToStatusSmall];
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
    CGPoint curLoc = [recognizer locationInView:self];

    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.status = FMPlayerViewStatusDrag;
            [self myToucheBegan:curLoc];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint velocity = [recognizer velocityInView:self];
            
            if (velocity.y > 2800) {
            }else if(velocity.y < -2800){
                [self animateToStatusBig];
            }else{
                [self myTouchMoved:curLoc];
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        {
            [self myTouchEnded:curLoc];
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
    self.status = FMPlayerViewStatusAnimation;
    
    void (^animationBlock)(void) = ^{
        CGRect frame = CGRectMake(_bOrigin.x,_bOrigin.y, SCREEN_SIZE.width, SCREEN_SIZE.height-_bOrigin.y);
        self.frame = frame;
    };
    
    void (^comleteBlock)(BOOL) = ^(BOOL isSuccess){
        self.status = FMPlayerViewStatusBig;
    };
    
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:animationBlock
                     completion:comleteBlock];
}

- (void)animateToStatusSmall
{
    self.status = FMPlayerViewStatusAnimation;
    
    void (^animationBlock)(void) = ^{
        CGRect frame = CGRectMake(_sOrigin.x,_sOrigin.y, SCREEN_SIZE.width, SCREEN_SIZE.height-_sOrigin.y);
        self.frame = frame;
    };
    
    void (^comleteBlock)(BOOL) = ^(BOOL isSuccess){
        self.status = FMPlayerViewStatusSmall;
    };
    
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:animationBlock
                     completion:comleteBlock];
}
@end
