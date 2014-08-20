//
//  FMTabbarView.m
//  DoubanFM
//
//  Created by exitingchen on 14-8-13.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMTabbarView.h"

@interface FMTabbarView ()
{
    UIView *_greenLineView;
    CGPoint _greenLeft;
    CGPoint _greenRight;
}

@end

@implementation FMTabbarView

static const float kTabbarHight = 61;
- (void)dealloc
{
    SAFE_DELETE(_greenLineView);
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithDelegate:(id)delegate
{
    self = [self init];
    
    if (self) {
        _delegate = delegate;
    }
    
    return self;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        CGSize screenSize = SCREEN_SIZE;
        CGSize statusBarSize = STATUSBAR_SIZE;
        float bgHeight = kTabbarHight;
        float bgWidth = screenSize.width;
        
        UIView *backgroundView = self;
        backgroundView.backgroundColor = [UIColor yellowColor];
        backgroundView.frame = CGRectMake(0, 0, bgWidth,bgHeight);
        
        float blacklineHight = 1;
        UIView *blackLine = [[UIView alloc] initWithFrame:CGRectMake(0, bgHeight-blacklineHight, bgWidth,blacklineHight)];
        blackLine.backgroundColor = [UIColor grayColor];
        [backgroundView addSubview:blackLine];
        
        float greenLineLen = screenSize.width*0.4;
        UIView *greenLine = [[UIView alloc] initWithFrame:CGRectMake(30, 58,greenLineLen, 3)];
        _greenLeft = CGPointMake(30, 58);
        _greenRight = CGPointMake(screenSize.width-30-greenLineLen, 58);
        _greenLineView = greenLine;
        greenLine.backgroundColor = [UIColor greenColor];
        [backgroundView addSubview:greenLine];
        
        float buttonLen = screenSize.width/2.0;
        float buttonHeight = backgroundView.frame.size.height - statusBarSize.height;
        UIButton *discoverButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [discoverButton setTitle:@"发现音乐" forState:UIControlStateNormal];
        [discoverButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [discoverButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        discoverButton.titleLabel.font = [UIFont systemFontOfSize:15];
        discoverButton.frame = CGRectMake(0, statusBarSize.height,buttonLen, buttonHeight);
        [discoverButton addTarget:self action:@selector(discoverButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:discoverButton];
        
        UIButton *fmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [fmButton setTitle:@"我的FM" forState:UIControlStateNormal];
        [fmButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [fmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        fmButton.titleLabel.font = [UIFont systemFontOfSize:15];
        fmButton.frame = CGRectMake(screenSize.width/2.0, statusBarSize.height, buttonLen, buttonHeight);
        [fmButton addTarget:self action:@selector(fmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:fmButton];
        
        [blackLine release];
    }
    
    return self;
}

- (void)fmButtonClicked
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = _greenLineView.frame;
        frame = CGRectMake(_greenRight.x, _greenRight.y, frame.size.width, frame.size.height);
        _greenLineView.frame = frame;
    }];
    
    [self.delegate tabbar:self didSelected:2];
}

- (void)discoverButtonClicked
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = _greenLineView.frame;
        frame = CGRectMake(_greenLeft.x, _greenLeft.y, frame.size.width, frame.size.height);
        _greenLineView.frame = frame;
    }];
    
    [self.delegate tabbar:self didSelected:1];
}

+ (float)tabbarViewHight
{
    return kTabbarHight;
}

+ (CGPoint)tabbarOrigin
{
    return CGPointMake(0, STATUSBAR_SIZE.height);
}
@end
