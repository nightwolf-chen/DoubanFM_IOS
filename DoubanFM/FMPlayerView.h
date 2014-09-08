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

typedef enum FMPlayerViewTag{
    FMPlayerViewTagButtonStart = 1000,
    FMPlayerViewTagButtonPlay,
    FMPlayerViewTagButtonLike,
    FMPlayerViewTagButtonTrash,
    FMPlayerViewTagButtonSkip,
    FMPlayerViewTagButtonSimilar,
    FMPlayerViewTagButtonLrc,
    FMPlayerViewTagButtonShare,
    FMPlayerViewTagButtonEnd,
    FMPlayerViewTagButtonChannel,
    FMPlayerViewTagLabelSong,
    FMPlayerViewTagProgressView,
    FMPlayerViewTagLabelArtist
}FMPlayerViewTag;

@interface FMPlayerView : UIView

@property (nonatomic,assign) CGPoint bOrigin;
@property (nonatomic,assign) CGPoint sOrigin;
@property (nonatomic,assign) FMPlayerViewStatus status;

- (void)animateToStatusSmall;
- (void)animateToStatusBig;

- (void)setSizeToSmall;
- (void)setSizeToBig;

+ (CGPoint)sOrigin;
+ (float)smallPlayerHeight;

@end
