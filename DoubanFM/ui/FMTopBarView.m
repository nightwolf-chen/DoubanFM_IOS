//
//  FMTopBarView.m
//  DoubanFM
//
//  Created by exitingchen on 14-8-22.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMTopBarView.h"
#import "FMTabbarView.h"
#import "FMPresentedViewTopbar.h"


@implementation FMTopBarView

static const float kTabbarHight = 61;

+ (id)topbarWithType:(FMTopBarViewType)type
{
    switch (type) {
        case FMTopBarViewTypeTabbar:
            return [[[FMTabbarView alloc] init] autorelease];
            break;
            
        default:
            return [[[FMPresentedViewTopbar alloc] init] autorelease];
            break;
    }
    
    @throw NSInvalidArgumentException;
    
    return nil;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        
        CGSize screenSize = SCREEN_SIZE;
        float bgHeight = kTabbarHight;
        float bgWidth = screenSize.width;
        
        UIView *backgroundView = self;
        backgroundView.backgroundColor = [UIColor colorWithRed:112.f/255.f green:196.f/255.f blue:241.f/255.f alpha:1];
        backgroundView.frame = CGRectMake(0, 0, bgWidth,bgHeight);
        
        float blacklineHight = 1;
        UIView *blackLine = [[UIView alloc] initWithFrame:CGRectMake(0, bgHeight-blacklineHight, bgWidth,blacklineHight)];
        blackLine.backgroundColor = [UIColor grayColor];
        [backgroundView addSubview:blackLine];
        
        [blackLine release];
    }
    
    return self;
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
