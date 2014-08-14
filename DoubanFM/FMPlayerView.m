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
            
            if (velocity.y > 1500 && self.frame.size.height > (SCREEN_SIZE.height - _bOrigin.y) - 50) {
                [self animateToStatusSmall];
            }else if(velocity.y < - 1500 && self.frame.size.height < (SCREEN_SIZE.height - _sOrigin.y) + 50){
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
        
        [UIView animateWithDuration:0.1
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             CGRect frame = CGRectMake(_bOrigin.x,_bOrigin.y, SCREEN_SIZE.width, SCREEN_SIZE.height-_bOrigin.y);                             self.frame = frame;
                         }
                         completion:^(BOOL success){
                             self.status = FMPlayerViewStatusBig;
                         }];

    };
    
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
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
        
        [UIView animateWithDuration:0.1
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
    
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:animationBlock
                     completion:comleteBlock];
}
@end
