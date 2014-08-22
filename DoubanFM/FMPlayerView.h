//
//  FMPlayerView.h
//  DoubanFM
//
//  Created by exitingchen on 14-8-13.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum FMPlayerViewStatus {
    FMPlayerViewStatusBig,
    FMPlayerViewStatusDrag,
    FMPlayerViewStatusAnimation,
    FMPlayerViewStatusSmall,
}FMPlayerViewStatus;

@interface FMPlayerView : UIView

@property (nonatomic,assign) CGPoint bOrigin;
@property (nonatomic,assign) CGPoint sOrigin;
@property (nonatomic,assign) FMPlayerViewStatus status;

+ (float)smallPlayerHeight;

- (void)animateToStatusSmall;
- (void)animateToStatusBig;

- (void)setSizeToSmall;
- (void)setSizeToBig;

@end
