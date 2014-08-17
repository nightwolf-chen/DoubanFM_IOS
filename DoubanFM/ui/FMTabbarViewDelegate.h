//
//  FMTabbarViewDelegate.h
//  DoubanFM
//
//  Created by nirvawolf on 17/8/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMTabbarView;

@protocol FMTabbarViewDelegate <NSObject>

@required
- (void)tabbar:(FMTabbarView *)tabbarView didSelected:(int)index;

@end
