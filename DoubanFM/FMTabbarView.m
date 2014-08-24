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
    
    for (int i = 0; i < _tabNum; i++) {
        
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

- (IBAction)buttonClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    [self  marklineAnimateTo:button];
    
    if ([_delegate respondsToSelector:@selector(tabbar:didSelected:)]) {
        [_delegate tabbar:self didSelected:(float)button.tag];
    }
}

- (void)marklineAnimateTo:(UIButton *)button
{
    [UIView animateWithDuration:0.2 animations:^{
        _greenLineView.frame = [self calculateFrameBy:button.frame];
    }];
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
