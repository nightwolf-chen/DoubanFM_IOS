//
//  FMTabbarView.h
//  DoubanFM
//
//  Created by exitingchen on 14-8-13.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "./ui/FMTabbarViewDelegate.h"

@interface FMTabbarView : UIView

@property (nonatomic,assign) id<FMTabbarViewDelegate> delegate;

- (id)initWithDelegate:(id)delegate;

+ (float)tabbarViewHight;

@end
