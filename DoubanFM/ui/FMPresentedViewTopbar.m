//
//  FMPresentedViewTopbar.m
//  DoubanFM
//
//  Created by exitingchen on 14-8-22.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMPresentedViewTopbar.h"

@implementation FMPresentedViewTopbar

static const float kLeftButtonMargin = 15;
static const float kButtonWidth = 50;
static const float kButtonHight = 20;

- (id)init
{
    self = [super init];
    
    if (self) {
        
        _cancleButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _cancleButton.frame = CGRectMake(kLeftButtonMargin, self.frame.origin.y + STATUSBAR_SIZE.height / 2.0+ self.frame.size.height / 2.0 - kButtonHight / 2.0, kButtonWidth, kButtonHight);
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancleButton addTarget:self action:@selector(cancleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancleButton];
    }
    
    return self;
}

- (IBAction)cancleButtonClicked:(id)sender
{
    if (_buttonClickedBlock) {
        _buttonClickedBlock();
    }
}

@end
