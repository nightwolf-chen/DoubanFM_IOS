//
//  FMPlayerControlButton.m
//  DoubanFM
//
//  Created by exitingchen on 14-8-15.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMPlayerControlButton.h"
#import "FMPlayerView.h"
#import "FMPlayerAnimationCalculator.h"

@interface FMPlayerControlButton ()

@end

@implementation FMPlayerControlButton

static const int kBigButtonHeight = 40;
static const int kBigButtonWidth = 40;
static const int kSmallButtonHeiht = 30;
static const int kSmallButtonWidth = 30;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initSmaillOrigin:(CGPoint)sOrigin bigOrigin:(CGPoint)bOrigin
{
   
    CGSize sButtonSize = [self.class sSize];
    CGSize bButtonSize = [self.class bSize];
    
    self = [super initWithFrame:CGRectMake(sOrigin.x, sOrigin.y, sButtonSize.width, sButtonSize.height)];
    
    if (self) {
        _sOrigin = sOrigin;
        _bOrigin = bOrigin;
        
        _sFrame = CGRectMake(_sOrigin.x, _sOrigin.y, sButtonSize.width, sButtonSize.height);
        _bFrame = CGRectMake(_bOrigin.x, _bOrigin.y, bButtonSize.width, bButtonSize.height);
        self.frame = _sFrame;
        self.backgroundColor = [UIColor blueColor];
    }
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqual:@"frame"]) {
        FMPlayerView *pView = object;
        CGRect pFrame = [change[@"new"] CGRectValue];
        float rate = [FMPlayerAnimationCalculator calculateRate:pView.sOrigin.y end:pView.bOrigin.y current:pFrame.origin.y];
        CGRect curSelfFrame = [FMPlayerAnimationCalculator calculateCurrentRect:self.sFrame end:self.bFrame rate:rate];
        self.frame = curSelfFrame;
    }
}

+ (CGSize)sSize
{
    return CGSizeMake(kSmallButtonWidth, kSmallButtonHeiht);
}

+ (CGSize)bSize
{
    return CGSizeMake(kBigButtonWidth, kBigButtonHeight);
}

@end
