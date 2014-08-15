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

@property (nonatomic,assign) CGPoint bOrigin;
@property (nonatomic,assign) CGPoint sOrigin;
@property (nonatomic,assign) CGRect bFrame;
@property (nonatomic,assign) CGRect sFrame;

@end

@implementation FMPlayerControlButton

static const int kBigButtonHeight = 50;
static const int kBigButtonWidth = 50;
static const int kSmallButtonHeiht = 25;
static const int kSmallButtonWidth = 25;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initSmaillOrigin:(CGPoint)bOrigin bigOrigin:(CGPoint)sOrigin
{
    
    self = [super initWithFrame:CGRectMake(sOrigin.x, sOrigin.y, kSmallButtonWidth, kSmallButtonHeiht)];
    
    if (self) {
        _sOrigin = sOrigin;
        _bOrigin = bOrigin;
        
        _sFrame = CGRectMake(_sOrigin.x, _sOrigin.y, kSmallButtonWidth, kSmallButtonHeiht);
        _bFrame = CGRectMake(_bOrigin.x, _bOrigin.y, kBigButtonWidth, kBigButtonHeight);
        self.frame = _sFrame;
    }
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqual:@"frame"]) {
        FMPlayerView *pView = object;
        CGRect pFrame = [[change objectForKey:@"new"] CGRectValue];
        float rate = [FMPlayerAnimationCalculator calculateRate:pView.sOrigin.y end:pView.bOrigin.y current:pFrame.origin.y];
        CGRect curSelfFrame = [FMPlayerAnimationCalculator calculateCurrentRect:self.sFrame end:self.bFrame rate:rate];
        self.frame = curSelfFrame;
    }
}

@end
