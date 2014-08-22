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
    int _tabNum;
    int _greenLineHight;
    int _greenLineWidth;
    int _greenLineOriginY;
    int _buttonHight;
    int _buttonWidth;
}

@end

@implementation FMTabbarView

static const float kTabbarHight = 61;
- (void)dealloc
{
    SAFE_DELETE(_greenLineView);
    [super dealloc];
}

- (id)initWithDelegate:(id)delegate
{
    self = [self init];
    
    if (self) {
        _delegate = delegate;
    }
    
    return self;
}

- (id)initWithTabNumber:(int)tabNum
{
    self = [super init];
    
    if (self) {
        _tabNum = tabNum;
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews
{
    [self setupTabButtons];
    [self setupMarkline];
}

- (void)setupTabButtons
{
    const float buttonWidth = SCREEN_SIZE.width / (float)_tabNum;
    const float buttonHight = self.frame.size.height - STATUSBAR_SIZE.height;
   
    _buttonWidth = buttonWidth;
    _buttonHight = buttonHight;
    
    CGRect buttonFrame = CGRectMake(0, STATUSBAR_SIZE.height, buttonWidth, buttonHight);
    
    NSMutableArray *tmpButtons = [NSMutableArray array];
    
    for (int i = 1; i <= _tabNum; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = buttonFrame;
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        button.tag = i;
        
        [self addSubview:button];
        [tmpButtons addObject:button];
        
        buttonFrame.origin.x += buttonWidth;
    }
    
    _tabButtons = [[NSArray alloc] initWithArray:tmpButtons];
}

- (void)setupMarkline
{
    _greenLineWidth = _buttonWidth * 0.8;
    _greenLineHight = 3;
    _greenLineOriginY = 58;
    
    UIButton *firstTabButton = _tabButtons[0];
    UIView *markline = [[UIView alloc] initWithFrame:[self calculateFrameBy:firstTabButton.frame]];
    markline.backgroundColor = [UIColor greenColor];
    
    [self addSubview:markline];
    _greenLineView = markline;
    
    [markline release];
}

- (CGRect)calculateFrameBy:(CGRect)buttonFrame
{
    int x = buttonFrame.origin.x + (buttonFrame.size.width - _greenLineWidth) / 2.0f;
    return CGRectMake(x, _greenLineOriginY, _greenLineWidth, _greenLineHight);
}

- (id)init
{
    self = [super init];
    
    if (self) {
        
        CGSize screenSize = SCREEN_SIZE;
        CGSize statusBarSize = STATUSBAR_SIZE;
        
        float greenLineLen = screenSize.width*0.4;
        UIView *greenLine = [[UIView alloc] initWithFrame:CGRectMake(30, 58,greenLineLen, 3)];
        _greenLeft = CGPointMake(30, 58);
        _greenRight = CGPointMake(screenSize.width-30-greenLineLen, 58);
        _greenLineView = greenLine;
        greenLine.backgroundColor = [UIColor greenColor];
        [self addSubview:greenLine];
        
        float buttonLen = screenSize.width/2.0;
        float buttonHeight = self.frame.size.height - statusBarSize.height;
        UIButton *discoverButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [discoverButton setTitle:@"发现音乐" forState:UIControlStateNormal];
        [discoverButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [discoverButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        discoverButton.titleLabel.font = [UIFont systemFontOfSize:15];
        discoverButton.frame = CGRectMake(0, statusBarSize.height,buttonLen, buttonHeight);
        [discoverButton addTarget:self action:@selector(discoverButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:discoverButton];
        
        UIButton *fmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [fmButton setTitle:@"我的FM" forState:UIControlStateNormal];
        [fmButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [fmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        fmButton.titleLabel.font = [UIFont systemFontOfSize:15];
        fmButton.frame = CGRectMake(screenSize.width/2.0, statusBarSize.height, buttonLen, buttonHeight);
        [fmButton addTarget:self action:@selector(fmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:fmButton];
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

- (IBAction)buttonClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [self  marklineAnimateTo:button];
    [self.delegate tabbar:self didSelected:button.tag];
}

- (void)marklineAnimateTo:(UIButton *)button
{
    [UIView animateWithDuration:0.2 animations:^{
        _greenLineView.frame = [self calculateFrameBy:button.frame];
    }];
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
