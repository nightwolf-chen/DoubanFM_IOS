//
//  FMTabbarView.h
//  DoubanFM
//
//  Created by exitingchen on 14-8-13.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMTopBarView.h"

@class FMTabbarView;

@protocol FMTabbarViewDelegate <NSObject>

@required
- (void)tabbar:(FMTabbarView *)tabbarView didSelected:(int)index;
@end



@interface FMTabbarView : FMTopBarView

@property (nonatomic,assign) id<FMTabbarViewDelegate> delegate;
@property (nonatomic,retain) NSArray *tabButtons;

- (id)initWithDelegate:(id)delegate;

- (id)initWithTabNumber:(int)tabNum;

+ (float)tabbarViewHight;

+ (CGPoint)tabbarOrigin;

@end
