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

- (id)initWithDelegate:(id)delegate;


@end
